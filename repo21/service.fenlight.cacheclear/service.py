import os
import xbmcvfs
import xbmc
import xbmcgui
import time

def is_idle():
    return not xbmc.Player().isPlaying()

def purge_cache():
    virtual_path = 'special://profile/addon_data/plugin.video.fenlight/databases/traktcache.db'
    db_path = xbmcvfs.translatePath(virtual_path)
    if os.path.exists(db_path):
        try:
            os.remove(db_path)
        except Exception:
            pass  # Silent fail

def reload_skin():
    try:
        xbmc.executebuiltin('ReloadSkin()')
    except Exception:
        pass

def notify(msg, heading='Kodi Maintenance'):
    xbmcgui.Dialog().notification(heading, msg, xbmcgui.NOTIFICATION_INFO, 5000, False)

def force_repo_updates():
    notify("Updates available. Please wait...")
    xbmc.executebuiltin('UpdateAddonRepos')
    xbmc.executebuiltin('UpdateLocalAddons')

    # Keep notifying until updates are done
    while xbmc.getCondVisibility('System.HasActiveModalDialog'):
        notify("Installing updates...")
        xbmc.sleep(5000)

def maintenance_cycle():
    if is_idle():
        purge_cache()
        reload_skin()
        force_repo_updates()

# Main loop
while not xbmc.Monitor().abortRequested():
    maintenance_cycle()
    xbmc.Monitor().waitForAbort(21600)  # 6 hours

