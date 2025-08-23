# -*- coding: utf-8 -*-
import os
import xbmc
import xbmcgui
import time

# Wait for Kodi to fully initialize
while not xbmc.getCondVisibility('Window.IsVisible(home)'):
    time.sleep(1)

# Resolve path and strip URI prefix if needed
raw_path = xbmc.translatePath('special://profile/addon_data/plugin.video.fenlight/databases/traktcache.db')
db_path = raw_path.replace('file://', '') if raw_path.startswith('file://') else raw_path

# Notify start
xbmcgui.Dialog().notification("Fenlight Cache", "Checking traktcache.db...", xbmcgui.NOTIFICATION_INFO, 3000)

# Delete if it exists
if os.path.exists(db_path):
    try:
        os.remove(db_path)
        xbmcgui.Dialog().notification("Fenlight Cache", "traktcache.db deleted", xbmcgui.NOTIFICATION_INFO, 3000)
    except Exception as e:
        xbmcgui.Dialog().notification("Fenlight Cache", f"Delete failed: {str(e)}", xbmcgui.NOTIFICATION_ERROR, 5000)
else:
    xbmcgui.Dialog().notification("Fenlight Cache", "traktcache.db not found", xbmcgui.NOTIFICATION_WARNING, 3000)

