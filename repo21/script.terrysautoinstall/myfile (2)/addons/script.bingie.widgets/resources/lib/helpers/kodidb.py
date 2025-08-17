#!/usr/bin/python
# -*- coding: utf-8 -*-

import os, sys
import xbmc
import xbmcgui
import xbmcvfs
from .utils import json, try_encode, log_msg, log_exception, get_clean_image, KODI_VERSION
from .utils import try_parse_int
from .kodi_constants import *
from operator import itemgetter
from infotagger.listitem import ListItemInfoTag

class KodiDb(object):
    ''' various methods and helpers to get data from kodi json api '''

    def movie(self, db_id):
        ''' get moviedetails from kodi db '''
        return self.get_json("VideoLibrary.GetMovieDetails", returntype="moviedetails",
                             fields=FIELDS_MOVIES, optparam=("movieid", try_parse_int(db_id)))

    def movies(self, sort=None, filters=None, limits=None, filtertype=None):
        ''' get moviedetails from kodi db '''
        return self.get_json("VideoLibrary.GetMovies", sort=sort, filters=filters,
                             fields=FIELDS_MOVIES, limits=limits, returntype="movies", filtertype=filtertype)

    def movie_by_imdbid(self, imdb_id):
        ''' gets a movie from kodidb by imdbid. '''
        # apparently you can't filter on imdb so we have to do this the complicated way
        if KODI_VERSION > 16:
            # from Kodi 17 we have a uniqueid field instead of imdbnumber
            all_items = self.get_json('VideoLibrary.GetMovies', fields=["uniqueid"], returntype="movies")
            for item in all_items:
                if 'uniqueid' in item:
                    for item2 in item["uniqueid"].values():
                        if item2 == imdb_id:
                            return self.movie(item["movieid"])
        else:
            all_items = self.get_json('VideoLibrary.GetMovies', fields=["imdbnumber"], returntype="movies")
            for item in all_items:
                if item["imdbnumber"] == imdb_id:
                    return self.movie(item["movieid"])
        return {}

    def tvshow(self, db_id):
        ''' get tvshow from kodi db '''
        tvshow = self.get_json("VideoLibrary.GetTvShowDetails", returntype="tvshowdetails",
                               fields=FIELDS_TVSHOWS, optparam=("tvshowid", try_parse_int(db_id)))
        return self.tvshow_watchedcounts(tvshow)

    def tvshows(self, sort=None, filters=None, limits=None, filtertype=None):
        ''' get tvshows from kodi db '''
        tvshows = self.get_json("VideoLibrary.GetTvShows", sort=sort, filters=filters,
                                fields=FIELDS_TVSHOWS, limits=limits, returntype="tvshows", filtertype=filtertype)
        # append watched counters
        for tvshow in tvshows:
            self.tvshow_watchedcounts(tvshow)
        return tvshows

    def tvshow_by_imdbid(self, imdb_id):
        ''' gets a tvshow from kodidb by imdbid (or tvdbid). '''
        # apparently you can't filter on imdb so we have to do this the complicated way
        if KODI_VERSION > 16:
            # from Kodi 17 we have a uniqueid field instead of imdbnumber
            all_items = self.get_json('VideoLibrary.GetTvShows', fields=["uniqueid"], returntype="tvshows")
            for item in all_items:
                if 'uniqueid' in item:
                    for item2 in item["uniqueid"].values():
                        if item2 == imdb_id:
                            return self.tvshow(item["tvshowid"])
        else:
            # pre-kodi 17 approach
            all_items = self.get_json('VideoLibrary.GetTvShows', fields=["imdbnumber"], returntype="tvshows")
            for item in all_items:
                if item["imdbnumber"] == imdb_id:
                    return self.tvshow(item["tvshowid"])
        return {}

    def episode(self, db_id):
        ''' get episode from kodi db '''
        return self.get_json("VideoLibrary.GetEpisodeDetails", returntype="episodedetails",
                             fields=FIELDS_EPISODES, optparam=("episodeid", try_parse_int(db_id)))

    def episodes(self, sort=None, filters=None, limits=None, filtertype=None, tvshowid=None, fields=FIELDS_EPISODES):
        ''' get episodes from kodi db '''
        if tvshowid:
            params = ("tvshowid", try_parse_int(tvshowid))
        else:
            params = None
        return self.get_json("VideoLibrary.GetEpisodes", sort=sort, filters=filters, fields=fields,
                             limits=limits, returntype="episodes", filtertype=filtertype, optparam=params)

    def movieset(self, db_id, include_set_movies_fields=""):
        ''' get movieset from kodi db '''
        if include_set_movies_fields:
            optparams = [("setid", try_parse_int(db_id)), ("movies", {"properties": include_set_movies_fields})]
        else:
            optparams = ("setid", try_parse_int(db_id))
        return self.get_json("VideoLibrary.GetMovieSetDetails", returntype="",
                             fields=["title", "art", "playcount"], optparam=optparams)

    def moviesets(self, sort=None, limits=None, include_set_movies=False):
        ''' get moviesetdetails from kodi db '''
        if include_set_movies:
            optparam = ("movies", {"properties": FIELDS_MOVIES})
        else:
            optparam = None
        return self.get_json("VideoLibrary.GetMovieSets", sort=sort,
                             fields=["title", "art", "playcount"],
                             limits=limits, returntype="", optparam=optparam)

    def files(self, vfspath, sort=None, limits=None):
        ''' gets all items in a kodi vfs path '''
        return self.get_json("Files.GetDirectory", returntype="", optparam=("directory", vfspath),
                             fields=FIELDS_FILES, sort=sort, limits=limits)

    def genres(self, media_type):
        ''' return all genres for the given media type (movie/tvshow) '''
        return self.get_json("VideoLibrary.GetGenres", fields=["thumbnail", "title"],
                             returntype="genres", optparam=("type", media_type))

    @staticmethod
    def set_json(jsonmethod, params):
        ''' method to set info in the kodi json api '''
        kodi_json = {}
        kodi_json["jsonrpc"] = "2.0"
        kodi_json["method"] = jsonmethod
        kodi_json["params"] = params
        kodi_json["id"] = 1
        json_response = xbmc.executeJSONRPC(try_encode(json.dumps(kodi_json)))
        return json.loads(json_response)

    @staticmethod
    def get_json(jsonmethod, sort=None, filters=None, fields=None, limits=None,
                 returntype=None, optparam=None, filtertype=None):
        ''' method to get details from the kodi json api '''
        kodi_json = {}
        kodi_json["jsonrpc"] = "2.0"
        kodi_json["method"] = jsonmethod
        kodi_json["params"] = {}
        if optparam:
            if isinstance(optparam, list):
                for param in optparam:
                    kodi_json["params"][param[0]] = param[1]
            else:
                kodi_json["params"][optparam[0]] = optparam[1]
        kodi_json["id"] = 1
        if sort:
            kodi_json["params"]["sort"] = sort
        if filters:
            if not filtertype:
                filtertype = "and"
            if len(filters) > 1:
                kodi_json["params"]["filter"] = {filtertype: filters}
            else:
                kodi_json["params"]["filter"] = filters[0]
        if fields:
            kodi_json["params"]["properties"] = fields
        if limits:
            kodi_json["params"]["limits"] = {"start": limits[0], "end": limits[1]}
        json_response = xbmc.executeJSONRPC(try_encode(json.dumps(kodi_json)))
        json_object = json.loads(json_response)
        # set the default returntype to prevent errors
        if "details" in jsonmethod.lower():
            result = {}
        else:
            result = []
        if 'result' in json_object:
            if returntype and returntype in json_object['result']:
                # returntype specified, return immediately
                result = json_object['result'][returntype]
            else:
                # no returntype specified, we'll have to look for it
                for key, value in json_object['result'].items():
                    if not key == "limits" and (isinstance(value, list) or isinstance(value, dict)):
                        result = value
        else:
            log_msg(json_response)
            log_msg(kodi_json)
        return result

    @staticmethod
    def create_listitem(item, as_tuple=True, offscreen=True):
        ''' helper to create a kodi listitem from kodi compatible dict with mediainfo '''
        try:
            if KODI_VERSION > 17:
                liz = xbmcgui.ListItem(
                    label=item.get("label", ""),
                    label2=item.get("label2", ""),
                    path=item['file'],
                    offscreen=offscreen)
                info_tag = ListItemInfoTag(liz, 'video', type_check=True)
            else:
                liz = xbmcgui.ListItem(
                    label=item.get("label", ""),
                    label2=item.get("label2", ""),
                    path=item['file'])

            nodetype = "Video"            

            # extra properties
            for key, value in item["extraproperties"].items():
                 liz.setProperty(key, value)

            # video infolabels
            if nodetype == "Video":
                infolabels = {
                    "title": item.get("title"),
                    "path": item.get("file"),
                    "size": item.get("size"),
                    "top250": item.get("top250"),
                    "tracknumber": item.get("tracknumber"),
                    "rating": item.get("rating"),
                    "playcount": item.get("playcount"),
                    "overlay": item.get("overlay"),
                    "cast": item.get("cast"),
                    "castandrole": item.get("castandrole"),
                    "mpaa": item.get("mpaa"),
                    "plot": item.get("plot"),
                    "plotoutline": item.get("plotoutline"),
                    "originaltitle": item.get("originaltitle"),
                    "sorttitle": item.get("sorttitle"),
                    "duration": item.get("duration"),
                    "tagline": item.get("tagline"),
                    "tvshowtitle": item.get("tvshowtitle"),
                    "premiered": item.get("premiered"),
                    "status": item.get("status"),
                    "code": item.get("imdbnumber"),
                    "imdbnumber": item.get("imdbnumber"),
                    "aired": item.get("aired"),
                    "credits": item.get("credits"),
                    "votes": item.get("votes"),
                    "trailer": item.get("trailer")
                }

                if "season" in item:
                    infolabels["season"] = item["season"]
                    infolabels["episode"] = item["episode"]
                if "resume" in item:
                    resume_float = float(item['resume']['position'])
                    total_float = float(item['resume']['total'])
                    info_tag._info_tag.setResumePoint(time=resume_float, totaltime=total_float)
                # streamdetails
                if item.get("streamdetails"):				
                    stream_details = {
						'video': [item["streamdetails"].get("video", {})],
						'audio': [item["streamdetails"].get("audio", {})],
						'subtitle': [item["streamdetails"].get("subtitle", {})]}
                    info_tag.set_stream_details(stream_details)
                if "dateadded" in item:
                    infolabels["dateadded"] = item["dateadded"]
                if "date" in item:
                    infolabels["date"] = item["date"]
                if "studio" in item:
                    infolabels["studio"] = item["studio"]
                if "genre" in item:
                    infolabels["genre"] = item["genre"]					
                if "writer" in item:
                    infolabels["writer"] = item["writer"]		
                if "director" in item:
                    infolabels["director"] = item["director"]
                if "country" in item:
                    infolabels["country"] = item["country"]
                if item["type"] in ["movie"] and "year" in item:
                    infolabels["year"] = item["year"]
                if "tag" in item:
                    infolabels["tag"] = item["tag"]

            # setting the dbtype and dbid is supported from kodi krypton and up
            if item["type"] not in ["genre", "categorie"]:
                infolabels["mediatype"] = item["type"]
                if nodetype == "Video" and "DBID" in item["extraproperties"]:
                    infolabels["dbid"] = item["extraproperties"]["DBID"]

            if "lastplayed" in item:
                infolabels["lastplayed"] = item["lastplayed"]

            # assign the infolabels
            info_tag.set_info(infolabels)
            # artwork
            liz.setArt(item.get("art", {}))
            if KODI_VERSION > 17:
                if "icon" in item:
                    liz.setArt({"icon":get_clean_image(item['icon'])})
                if "thumbnail" in item:
                    liz.setArt({"thumb":get_clean_image(item['thumbnail'])})

            # contextmenu
            if item["type"] in ["episode", "season"] and "season" in item and "tvshowid" in item:
                # add series and season level to widgets
                if "contextmenu" not in item:
                    item["contextmenu"] = []
                item["contextmenu"] += [
                    (xbmc.getLocalizedString(20364), "ActivateWindow(Video,videodb://tvshows/titles/%s/,return)"
                        % (item["tvshowid"])),
                    (xbmc.getLocalizedString(20373), "ActivateWindow(Video,videodb://tvshows/titles/%s/%s/,return)"
                        % (item["tvshowid"], item["season"]))]
            if "contextmenu" in item:
                liz.addContextMenuItems(item["contextmenu"])

            if as_tuple:
                return item["file"], liz, item.get("isFolder", False)
            else:
                return liz
        except Exception as exc:
            log_exception(__name__, exc)
            log_msg(item)
            return None

    @staticmethod
    def prepare_listitem(item, offscreen=True):
        ''' helper to convert kodi output from json api to compatible format for listitems '''
        liz = xbmcgui.ListItem(
            label=item.get("label", ""),
            label2=item.get("label2", ""),
            path=item['file'],
            offscreen=offscreen)
        info_tagger = ListItemInfoTag(liz, 'video')
        try:
            # fix values returned from json to be used as listitem values
			
            properties = item.get("extraproperties", {})

            # set type
            for idvar in [
                ('episode', 'DefaultTVShows.png'),
                ('tvshow', 'DefaultTVShows.png'),
                ('movie', 'DefaultMovies.png')]:
                dbid = item.get(idvar[0] + "id")
                if dbid:
                    properties["DBID"] = str(dbid)
                    if not item.get("type"):
                        item["type"] = idvar[0]
                    if not item.get("icon"):
                        item["icon"] = idvar[1]
                    break

            # general properties
            
            if "duration" not in item and "runtime" in item:
                if (item["runtime"] // 60) > 300:
                    item["duration"] = item["runtime"] // 60
                else:
                    item["duration"] = item["runtime"]
            if "plot" not in item and "comment" in item:
                item["plot"] = item["comment"]
            if "tvshowtitle" not in item and "showtitle" in item:
                item["tvshowtitle"] = item["showtitle"]
            if "premiered" not in item and "firstaired" in item:
                item["premiered"] = item["firstaired"]
            if "firstaired" in item and "aired" not in item:
                item["aired"] = item["firstaired"]
            if "imdbnumber" not in properties and "imdbnumber" in item:
                properties["imdbnumber"] = item["imdbnumber"]
            if "imdbnumber" not in properties and "uniqueid" in item:
                for value in item["uniqueid"].values():
                    if value.startswith("tt"):
                        properties["imdbnumber"] = value

            properties["dbtype"] = item["type"]
            properties["type"] = item["type"]
            properties["path"] = item.get("file")

            # cast
            list_cast = []
            list_castandrole = []
            item["cast_org"] = item.get("cast", [])
            if "cast" in item and isinstance(item["cast"], list):
                for castmember in item["cast"]:
                    if isinstance(castmember, dict):
                        list_cast.append(castmember.get("name", ""))
                        list_castandrole.append((castmember["name"], castmember["role"]))
                    else:
                        list_cast.append(castmember)
                        list_castandrole.append((castmember, ""))

            item["cast"] = list_cast
            item["castandrole"] = list_castandrole

            if "season" in item and "episode" in item:
                properties["episodeno"] = "s%se%s" % (item.get("season"), item.get("episode"))
            if "streamdetails" in item:
                streamdetails = item["streamdetails"]
                audiostreams = streamdetails.get('audio', [])
                videostreams = streamdetails.get('video', [])
                subtitles = streamdetails.get('subtitle', [])
                if len(videostreams) > 0:
                    stream = videostreams[0]
                    height = stream.get("height", "")
                    width = stream.get("width", "")
                    if height and width:
                        resolution = ""
                        if width <= 720 and height <= 480:
                            resolution = "480"
                        elif width <= 768 and height <= 576:
                            resolution = "576"
                        elif width <= 960 and height <= 544:
                            resolution = "540"
                        elif width <= 1280 and height <= 720:
                            resolution = "720"
                        elif width <= 1920 and height <= 1080:
                            resolution = "1080"
                        elif width * height >= 6000000:
                            resolution = "4K"
                        properties["VideoResolution"] = resolution
                    if stream.get("codec", ""):
                        properties["VideoCodec"] = str(stream["codec"])
                    if stream.get("aspect", ""):
                        properties["VideoAspect"] = str(round(stream["aspect"], 2))
                    item["streamdetails"]["video"] = stream

                # grab details of first audio stream
                if len(audiostreams) > 0:
                    stream = audiostreams[0]
                    properties["AudioCodec"] = stream.get('codec', '')
                    properties["AudioChannels"] = str(stream.get('channels', ''))
                    properties["AudioLanguage"] = stream.get('language', '')
                    item["streamdetails"]["audio"] = stream

                # grab details of first subtitle
                if len(subtitles) > 0:
                    properties["SubtitleLanguage"] = subtitles[0].get('language', '')
                    item["streamdetails"]["subtitle"] = subtitles[0]
            else:
                item["streamdetails"] = {}
                item["streamdetails"]["video"] = {'duration': item.get('duration', 0)}        

            # artwork
            art = item.get("art", {})
            if item["type"] in ["episode", "season"]:
                if not art.get("fanart") and art.get("season.fanart"):
                    art["fanart"] = art["season.fanart"]
                if not art.get("poster") and art.get("season.poster"):
                    art["poster"] = art["season.poster"]
                if not art.get("landscape") and art.get("season.landscape"):
                    art["poster"] = art["season.landscape"]
                if not art.get("fanart") and art.get("tvshow.fanart"):
                    art["fanart"] = art.get("tvshow.fanart")
                if not art.get("poster") and art.get("tvshow.poster"):
                    art["poster"] = art.get("tvshow.poster")
                if not art.get("clearlogo") and art.get("tvshow.clearlogo"):
                    art["clearlogo"] = art.get("tvshow.clearlogo")
                if not art.get("banner") and art.get("tvshow.banner"):
                    art["banner"] = art.get("tvshow.banner")
                if not art.get("landscape") and art.get("tvshow.landscape"):
                    art["landscape"] = art.get("tvshow.landscape")
            if not art.get("fanart") and item.get('fanart'):
                art["fanart"] = item.get('fanart')
            if not art.get("thumb") and item.get('thumbnail'):
                art["thumb"] = get_clean_image(item.get('thumbnail'))
            if not art.get("thumb") and art.get('poster'):
                art["thumb"] = get_clean_image(art.get('poster'))
            if not art.get("thumb") and item.get('icon'):
                art["thumb"] = get_clean_image(item.get('icon'))
            if not item.get("thumbnail") and art.get('thumb'):
                item["thumbnail"] = art["thumb"]

            # clean art
            for key, value in art.items():
                if not isinstance(value, str):
                    art[key] = ""
                elif value:
                    art[key] = get_clean_image(value)
            item["art"] = art

            item["extraproperties"] = properties

            if "file" not in item:
                log_msg("Item is missing file path ! --> %s" % item["label"], xbmc.LOGWARNING)
                item["file"] = ""

            # return the result
            return item

        except Exception as exc:
            log_exception(__name__, exc)
            log_msg(item)
            return None

    @staticmethod
    def tvshow_watchedcounts(tvshow):
        ''' append watched counts to tvshow details '''
        tvshow["extraproperties"] = {"totalseasons": str(tvshow["season"]),
                                     "totalepisodes": str(tvshow["episode"]),
                                     "watchedepisodes": str(tvshow["watchedepisodes"]),
                                     "unwatchedepisodes": str(tvshow["episode"] - tvshow["watchedepisodes"])
                                     }
        return tvshow
