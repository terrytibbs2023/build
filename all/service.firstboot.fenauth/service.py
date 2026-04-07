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

# POV uses a unified "My Services" screen for Trakt/RD auth
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
        log("POV settings.xml not found")
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

def rd_enabled():
    root = fen_settings()
    if root is None:
        return False
    enabled = get_setting(root, "rd.enabled").lower() == "true"
    token = get_setting(root, "rd.token")
    return enabled and token not in ("", None)

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

if __name__ == "__main__":
    try:
        log("Service start")

        wait_for_kodi_home()
        time.sleep(2)

        dialog = xbmcgui.Dialog()

        while True:
            trakt = trakt_enabled()
            rd = rd_enabled()

            # If both are enabled, exit the loop and end service
            if trakt and rd:
                log("Both Trakt and Real-Debrid are enabled — exiting service")
                break

            missing = []
            if not trakt:
                missing.append("Trakt")
            if not rd:
                missing.append("Real-Debrid")

            missing_str = ", ".join(missing)

            yes = dialog.yesno(
                "Bingie Setup",
                "You Must Enable These Accounts NOW!:\n\n%s\n\n"
                "Bingie needs Trakt and Real-Debrid to work.\n"
                "Open POV My Services to enable them now?" % missing_str
            )

            log(f"User selected: {'YES' if yes else 'NO'}")

            if not yes:
                # User said NO → loop again
                log("User declined — showing dialog again")
                time.sleep(1)
                continue

            # User said YES → open POV My Services
            log("Opening POV My Services window")
            xbmc.executebuiltin(MY_SERVICES_TRIGGER)

            wait_for_fen_dialog_close()
            time.sleep(1)

        log("Service end (normal)")
        raise SystemExit

    except Exception as e:
        log("Exception in service.py", xbmc.LOGERROR)
        log(repr(e), xbmc.LOGERROR)
        log(traceback.format_exc(), xbmc.LOGERROR)

