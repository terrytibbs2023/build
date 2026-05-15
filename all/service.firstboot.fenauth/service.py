import xbmc
import xbmcgui
import xbmcvfs
import xml.etree.ElementTree as ET
import time
import traceback

LOG_PREFIX = "[FenSetupService] "

SETTINGS_PATH = xbmcvfs.translatePath(
    "special://profile/addon_data/plugin.video.pov/settings.xml"
)

MY_SERVICES_TRIGGER = (
    'PlayMedia("plugin://plugin.video.pov/?mode=myservices'
    '&name=My+Services&isFolder=false")'
)

def log(msg, level=xbmc.LOGINFO):
    xbmc.log(f"{LOG_PREFIX}{msg}", level)

def get_setting(root, key):
    for setting in root.findall("setting"):
        if setting.get("id") == key:
            return (setting.text or "").strip()
    return ""

def fen_settings():
    if not xbmcvfs.exists(SETTINGS_PATH):
        log("POV settings.xml not found yet", xbmc.LOGINFO)
        return None
    try:
        tree = ET.parse(SETTINGS_PATH)
        return tree.getroot()
    except Exception as e:
        log(f"Error reading POV settings: {e}", xbmc.LOGERROR)
        return None

def trakt_enabled():
    root = fen_settings()
    if root is None:
        return False
    token = get_setting(root, "trakt.token")
    return token not in ("", None)

def wait_for_kodi_home(timeout=20):
    for _ in range(timeout):
        if xbmc.getCondVisibility("Window.IsVisible(home)"):
            return True
        time.sleep(1)
    return False

def wait_for_fen_dialog_close(timeout=60):
    for _ in range(timeout):
        if not xbmc.getCondVisibility("Window.IsActive(yesnodialog)") and \
           not xbmc.getCondVisibility("Window.IsActive(busydialog)") and \
           not xbmc.getCondVisibility("Window.IsActive(progressdialog)"):
            return True
        time.sleep(1)
    return False

def run_service():
    try:
        log("Service start")

        if not wait_for_kodi_home():
            log("Kodi home window timed out. Exiting service check.")
            return

        xbmc.executebuiltin('UpdateAddonRepos')
        time.sleep(2)

        dialog = xbmcgui.Dialog()

        while not xbmc.Monitor().abortRequested():
            trakt = trakt_enabled()

            if trakt:
                log("Trakt is enabled — exiting service loop")
                break

            yes = dialog.yesno(
                "Bingie Setup",
                "You must enable Trakt NOW!\n\n"
                "Bingie requires Trakt to function.\n\n"
                "Open POV My Services now?"
            )

            if not yes:
                log("User declined setup — will re-prompt in 10 seconds")
                time.sleep(10)
                continue

            log("Opening POV My Services window")
            xbmc.executebuiltin(MY_SERVICES_TRIGGER)

            time.sleep(5)
            wait_for_fen_dialog_close()
            time.sleep(2)

        log("Service check completed successfully.")

    except Exception as e:
        log("Exception in service.py: %s" % repr(e), xbmc.LOGERROR)
        log(traceback.format_exc(), xbmc.LOGERROR)

if __name__ == "__main__":
    run_service()

