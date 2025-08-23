import os
import xbmcvfs

# Resolve the virtual path to an actual filesystem path
virtual_path = 'special://profile/addon_data/plugin.video.fenlight/databases/traktcache.db'
db_path = xbmcvfs.translatePath(virtual_path)

if os.path.exists(db_path):
    try:
        os.remove(db_path)
    except Exception:
        pass  # Fail silently

