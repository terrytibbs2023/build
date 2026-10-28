import xbmc
import xbmcaddon
import time

def is_fen_installed():
    try:
        xbmcaddon.Addon('service.installer')
        return True
    except:
        return False

if __name__ == '__main__':
    time.sleep(10)  # Optional delay to let Kodi settle
    if not is_fen_installed():
        xbmc.executebuiltin('InstallAddon(service.installer)')
        xbmc.log('[FenInstaller] Fen not found — triggered InstallAddon', xbmc.LOGINFO)

