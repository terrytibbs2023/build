import os
import xbmc
import xbmcgui

db_path = 'special://profile/addon_data/plugin.video.fenlight/databases/traktcache.db'

xbmcgui.Dialog().notification("Fenlight Cache", "Checking traktcache.db...", xbmcgui.NOTIFICATION_INFO, 3000)

if os.path.exists(db_path):
    try:
        os.remove(db_path)
        xbmcgui.Dialog().notification("Fenlight Cache", "traktcache.db deleted", xbmcgui.NOTIFICATION_INFO, 3000)
    except Exception as e:
        xbmcgui.Dialog().notification("Fenlight Cache", f"Delete failed: {str(e)}", xbmcgui.NOTIFICATION_ERROR, 5000)
else:
    xbmcgui.Dialog().notification("Fenlight Cache", "traktcache.db not found", xbmcgui.NOTIFICATION_WARNING, 3000)

