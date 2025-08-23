import os
import xbmcvfs
import xbmc
import xbmcgui

def is_idle():
    return not xbmc.Player().isPlaying()

def notify(msg, heading='Bingie Maintenance'):
    xbmcgui.Dialog().notification(heading, msg, xbmcgui.NOTIFICATION_INFO, 5000, False)

def purge_cache():
    notify("Deleting Fenlight cache...")
    virtual_path = 'special://profile/addon_data/plugin.video.fenlight/databases/traktcache.db'
    db_path = xbmcvfs.translatePath(virtual_path)
    if os.path.exists(db_path):
        try:
            os.remove(db_path)
            notify("Fenlight cache deleted.")
        except Exception:
            notify("Failed to delete cache.")

def force_repo_updates():
    notify("Updating addon repositories...")
    xbmc.executebuiltin('UpdateAddonRepos')
    xbmc.sleep(3000)

def force_addon_updates():
    notify("Checking for addon updates...")
    xbmc.executebuiltin('UpdateLocalAddons')
    xbmc.sleep(3000)

    while xbmc.getCondVisibility('System.HasActiveModalDialog'):
        notify("Installing updates...")
        xbmc.sleep(5000)

def maintenance_cycle():
    if is_idle():
        purge_cache()
        force_repo_updates()
        force_addon_updates()
        notify("Cache deleted and all addons updated.")

while not xbmc.Monitor().abortRequested():
    maintenance_cycle()
    xbmc.Monitor().waitForAbort(21600)  # 6 hours

