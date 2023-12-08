# -*- coding: utf-8 -*-
import sys
from xbmc import executebuiltin, sleep

mode = sys.argv[1]
if   mode == 'refresh_widgets':
	executebuiltin('UpdateLibrary(video,special://skin/foo)')
elif mode == 'coalition_watched_params':
	executebuiltin('RunPlugin(%s)' % sys.listitem.getProperty('coalition_watched_params'))
	sleep(1000)
	executebuiltin('UpdateLibrary(video,special://skin/foo)')
elif mode == 'coalition_unwatched_params':
	executebuiltin('RunPlugin(%s)' % sys.listitem.getProperty('coalition_unwatched_params'))
	sleep(1000)
	executebuiltin('UpdateLibrary(video,special://skin/foo)')
elif mode == 'coalition_clearprog_params':
	executebuiltin('RunPlugin(%s)' % sys.listitem.getProperty('coalition_clearprog_params'))
	sleep(1000)
	executebuiltin('UpdateLibrary(video,special://skin/foo)')
elif mode == 'coalition_browse_params':
	executebuiltin('ActivateWindow(Videos,%s)' % sys.listitem.getProperty('coalition_browse_params'))
elif mode == 'coalition_browse_seas_params':
	executebuiltin('ActivateWindow(Videos,%s)' % sys.listitem.getProperty('coalition_browse_seas_params'))
elif mode == 'coalition_trakt_manager_params':
	executebuiltin('RunPlugin(%s)' % sys.listitem.getProperty('coalition_trakt_manager_params'))
elif mode == 'coalition_fav_manager_params':
	executebuiltin('RunPlugin(%s)' % sys.listitem.getProperty('coalition_fav_manager_params'))
elif mode == 'coalition_random_params':
	executebuiltin('RunPlugin(%s)' % sys.listitem.getProperty('coalition_random_params'))
elif mode == 'coalition_options_menu_params':
	executebuiltin('RunPlugin(%s)' % sys.listitem.getProperty('coalition_options_menu_params'))
elif mode == 'coalition_extras_menu_params':
	params = sys.listitem.getProperty('coalition_extras_menu_params')
	params += '&is_widget=false&is_home=true'
	executebuiltin('RunPlugin(%s)' % params)

