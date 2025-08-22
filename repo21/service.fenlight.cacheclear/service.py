import os
import xbmc

# Path to traktcache.db
db_path = xbmc.translatePath('special://profile/addon_data/plugin.video.fenlight/databases/traktcache.db')

# Delete if exists
if os.path.exists(db_path):
    try:
        os.remove(db_path)
        xbmc.log("Fenlight traktcache.db deleted on startup", xbmc.LOGINFO)
    except Exception as e:
        xbmc.log(f"Failed to delete traktcache.db: {e}", xbmc.LOGERROR)

