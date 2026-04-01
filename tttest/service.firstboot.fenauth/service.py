import xbmc
import xbmcgui
import xbmcvfs
import xml.etree.ElementTree as ET
import time
import traceback

LOG_PREFIX = "[POVSetupService] "

SETTINGS_PATH = xbmcvfs.translatePath(
    "special://profile/addon_data/plugin.video.pov/settings.xml"
)

# POV AUTH TRIGGERS
TRAKT_TRIGGER = (
   'PlayMedia("plugin://plugin.video.pov/?mode=auth_trakt")'
)

RD_TRIGGER = (
    'PlayMedia("plugin://plugin.video.pov/?mode=auth_debrid")'
)

def log(msg, level=xbmc.LOGINFO):
    xbmc.log(f"{LOG_PREFIX}{msg}", level)

def get_setting(root, key):
    for setting in root.findall("setting"):
        if setting.get("id") == key:
            return (setting.text or "").strip()
    return ""

def pov_settings():
    if not xbmcvfs.exists(SETTINGS_PATH):
        log("POV settings.xml not found")
        return None
    try:
        tree = ET.parse(SETTINGS_PATH)
        return tree.getroot()
    except Exception as e:
        log(f"Error reading POV settings: {e}", xbmc.LOGERROR)
        return None

# POV setting keys:
# trakt.enabled
# debrid.enabled
def trakt_enabled():
    root = pov_settings()
    if not root:
        return False
    return get_setting(root, "trakt.enabled").lower() == "true"

def rd_enabled():
    root = pov_settings()
    if not root:
        return False
    return get_setting(root, "debrid.enabled").lower() == "true"

def wait_for_kodi_home(timeout=20):
    for _ in range(timeout):
        if xbmc.getCondVisibility("Window.IsVisible(home)"):
            return True
        time.sleep(1)
    return False

def wait_for_pov_dialog_close(timeout=60):
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

        # If both are already enabled, exit immediately
        if trakt_enabled() and rd_enabled():
            log("Trakt & RD already enabled — exiting")
            raise SystemExit

        wait_for_kodi_home()
        time.sleep(2)

        dialog = xbmcgui.Dialog()
        yes = dialog.yesno(
            "Bingie Setup",
            "Bingie Needs Trakt and Real-Debrid To Work, Are you ready to activate them now?"
        )
        log(f"User selected: {'YES' if yes else 'NO'}")

        if not yes:
            log("User declined — exiting")
            raise SystemExit

        # Run Trakt if needed
        if not trakt_enabled():
            log("Triggering Trakt auth")
            xbmc.executebuiltin(TRAKT_TRIGGER)
            wait_for_pov_dialog_close()
        else:
            log("Trakt already enabled — skipping")

        # Run RD if needed
        if not rd_enabled():
            log("Triggering RealDebrid auth")
            xbmc.executebuiltin(RD_TRIGGER)
            wait_for_pov_dialog_close()
        else:
            log("RealDebrid already enabled — skipping")

        log("Service end (normal)")

    except Exception as e:
        log("Exception in service.py", xbmc.LOGERROR)
        log(repr(e), xbmc.LOGERROR)
        log(traceback.format_exc(), xbmc.LOGERROR)
