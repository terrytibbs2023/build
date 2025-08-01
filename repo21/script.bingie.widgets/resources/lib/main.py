#!/usr/bin/python
# -*- coding: utf-8 -*-

import os, sys
import urllib.parse as urlparse
import random
import xbmcplugin
import xbmc
import xbmcaddon
import xbmcgui
from resources.lib.widgetshelper import WidgetsHelper
from resources.lib.utils import log_msg, log_exception, ADDON_ID, create_main_entry

ADDON_HANDLE = int(sys.argv[1])


class Main(object):
    ''' Main entry path for our widget listing. Process the arguments and load correct class and module '''

    def __init__(self):
        ''' Initialization '''

        self.widgetshelper = WidgetsHelper()
        self.addon = xbmcaddon.Addon(ADDON_ID)
        self.win = xbmcgui.Window(10000)
        self.options = self.get_options()

        # skip if shutdown requested
        if self.win.getProperty("BingieToolboxShutdownRequested"):
            log_msg("Not forfilling request: Kodi is exiting!", xbmc.LOGWARNING)
            xbmcplugin.endOfDirectory(handle=ADDON_HANDLE)

        elif not "mediatype" in self.options or not "action" in self.options:
            # we need both mediatype and action, so show the main listing
            self.mainlisting()
        else:
            # we have a mediatype and action so display the widget listing
            self.show_widget_listing()

        self.close()

    def close(self):
        ''' Cleanup Kodi Cpython instances '''
        self.widgetshelper.close()
        del self.addon
        del self.win
        log_msg("MainModule exited")

    def get_options(self):
        ''' get the options provided to the plugin path '''

        options = dict(urlparse.parse_qsl(sys.argv[2].replace('?', '').lower()))

        # set the widget settings as options
        options["hide_watched"] = self.addon.getSetting("hide_watched") == "true"
        if self.addon.getSetting("hide_watched_recent") == "true" and "recent" in options.get("action", ""):
            options["hide_watched"] = True
        options["num_recent_similar"] = int(self.addon.getSetting("num_recent_similar"))
        options["exp_recommended"] = self.addon.getSetting("exp_recommended") == "true"
        options["hide_watched_similar"] = self.addon.getSetting("hide_watched_similar") == "true"
        options["next_inprogress_only"] = self.addon.getSetting("nextup_inprogressonly") == "true"
        options["episodes_enable_specials"] = self.addon.getSetting("episodes_enable_specials") == "true"
        options["group_episodes"] = self.addon.getSetting("episodes_grouping") == "true"
        if "limit" in options:
            options["limit"] = int(options["limit"])
        else:
            options["limit"] = int(self.addon.getSetting("default_limit"))

        if "mediatype" not in options and "action" in options:
            # get the mediatype and action from the path (for backwards compatability with old style paths)
            for item in [
                    ("movies", "movies"),
                    ("shows", "tvshows"),
                    ("episode", "episodes"),
                    ("media", "media")]:
                if item[0] in options["action"]:
                    options["mediatype"] = item[1]
                    options["action"] = options["action"].replace(item[1], "").replace(item[0], "")
                    break

        # prefer reload param for the mediatype
        if "mediatype" in options:
            alt_reload = self.win.getProperty("widgetreload-%s" % options["mediatype"])           
            if "listing" in options["action"]:
                options["skipcache"] = "true"
            if options["action"] == "browsegenres" and options["mediatype"] == "randommovies":
                options["mediatype"] = "movies"
                options["random"] = True
            elif options["action"] == "browsegenres" and options["mediatype"] == "randomtvshows":
                options["mediatype"] = "tvshows"
                options["random"] = True

        options["skipcache"] = "true"

        return options

    def show_widget_listing(self):
        ''' display the listing for the provided action and mediatype '''
        media_type = self.options["mediatype"]
        action = self.options["action"]
        # set widget content type        
        xbmcplugin.setContent(ADDON_HANDLE, "files")
        # try to get from cache first...
        all_items = []
        # alter cache_str depending on whether "tag" is available
        if self.options["action"] == "similar":
            # if action is similar, use imdbid
            cache_id = self.options.get("imdbid", "")
            # if similar was called without imdbid, skip cache
            if not cache_id:
                self.options["skipcache"] = "true"
        elif self.options["action"] == "playlist" and self.options["mediatype"] == "media":
            # if action is mixed playlist, use playlist labels
            cache_id = self.options.get("movie_label")+self.options.get("tv_label")
        else:
            # use tag otherwise
            cache_id = self.options.get("tag")
        # set cache_str
        cache_str = "Bingie.Widgets.%s.%s.%s.%s.%s" % \
            (media_type, action, self.options["limit"], self.options.get("path"), cache_id)
        if not self.win.getProperty("widgetreload2"):
            # at startup we simply accept whatever is in the cache
            cache_checksum = None
        else:
            # we use a checksum based on the reloadparam to make sure we have the most recent data
            cache_checksum = self.options.get("reload", "")
        # only check cache if not "skipcache"
        if not self.options.get("skipcache") == "true":
            cache = self.widgetshelper.cache.get(cache_str, checksum=cache_checksum)
            if cache:
                log_msg("MEDIATYPE: %s - ACTION: %s - PATH: %s - TAG: %s -- got items from cache - CHECKSUM: %s"
                        % (media_type, action, self.options.get("path"), self.options.get("tag"), cache_checksum))
                all_items = cache

        # Call the correct method to get the content from json when no cache
        if not all_items:
            log_msg("MEDIATYPE: %s - ACTION: %s - PATH: %s - TAG: %s -- no cache, quering kodi api to get items - CHECKSUM: %s"
                    % (media_type, action, self.options.get("path"), self.options.get("tag"), cache_checksum))

            # dynamically import and load the correct module, class and function
            try:
                media_module = __import__(media_type)
                media_class = getattr(
                    media_module,
                    media_type.capitalize())(self.addon, self.widgetshelper, self.options)
                all_items = getattr(media_class, action)()
                del media_class
            except AttributeError:
                log_exception(__name__, "Incorrect widget action or type called")
            except Exception as exc:
                log_exception(__name__, exc)

            # randomize output if requested by skinner or user
            if self.options.get("randomize", "") == "true":
                all_items = sorted(all_items, key=lambda k: random.random())

            # prepare listitems and store in cache
            all_items = self.widgetshelper.process_method_on_list(self.widgetshelper.kodidb.prepare_listitem, all_items)
            self.widgetshelper.cache.set(cache_str, all_items, checksum=cache_checksum)

        # fill that listing...
        xbmcplugin.addSortMethod(int(sys.argv[1]), xbmcplugin.SORT_METHOD_UNSORTED)
        all_items = self.widgetshelper.process_method_on_list(self.widgetshelper.kodidb.create_listitem, all_items)
        xbmcplugin.addDirectoryItems(ADDON_HANDLE, all_items, len(all_items))

        # end directory listing
        xbmcplugin.endOfDirectory(handle=ADDON_HANDLE)

    def mainlisting(self):
        ''' main listing '''
        all_items = []
        xbmcplugin.setContent(ADDON_HANDLE, "files")

        # movie node
        if xbmc.getCondVisibility("Library.HasContent(movies)"):
            all_items.append((xbmc.getLocalizedString(342), "movieslisting", "DefaultMovies.png"))

        # tvshows and episodes nodes
        if xbmc.getCondVisibility("Library.HasContent(tvshows)"):
            all_items.append((xbmc.getLocalizedString(20343), "tvshowslisting", "DefaultTvShows.png"))
            all_items.append((xbmc.getLocalizedString(20360), "episodeslisting", "DefaultTvShows.png"))

        # combined node
        if xbmc.getCondVisibility(
                "Library.HasContent(movies) + Library.HasContent(tvshows)"):
            all_items.append((self.addon.getLocalizedString(32030), "medialisting", "DefaultVideo.png"))

        # process the listitems and display listing
        all_items = self.widgetshelper.process_method_on_list(create_main_entry, all_items)
        all_items = self.widgetshelper.process_method_on_list(self.widgetshelper.kodidb.prepare_listitem, all_items)
        all_items = self.widgetshelper.process_method_on_list(self.widgetshelper.kodidb.create_listitem, all_items)
        xbmcplugin.addDirectoryItems(ADDON_HANDLE, all_items, len(all_items))
        xbmcplugin.endOfDirectory(handle=ADDON_HANDLE)
