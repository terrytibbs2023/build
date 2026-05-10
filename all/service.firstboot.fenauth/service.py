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
        # Log this as info rather than error during first-run scenarios
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
    # This prevents the loop from jumping back up while the user is still typing/authing
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

        # Wait for the UI to be ready before doing anything
        if not wait_for_kodi_home():
            log("Kodi home window timed out. Exiting service check.")
            return

        # Trigger repo update only after home is visible to prevent startup lag
        xbmc.executebuiltin('UpdateAddonRepos')
        time.sleep(2)

        dialog = xbmcgui.Dialog()

        while not xbmc.Monitor().abortRequested():
            trakt = trakt_enabled()
            rd = rd_enabled()

            # If both are enabled, exit the loop cleanly
            if trakt and rd:
                log("Both Trakt and Real-Debrid are enabled — cleaning up service")
                break

            missing = []
            if not trakt: missing.append("Trakt")
            if not rd: missing.append("Real-Debrid")

            missing_str = " & ".join(missing)

            # yesno returns True if user clicks 'Yes'
            yes = dialog.yesno(
                "Bingie Setup",
               "You Must Enable These Accounts NOW!:\n\n%s\n\n"
                "Bingie requires these to function.\n"
                "Open POV My Services now?" % missing_str
            )

            if not yes:
                log("User declined setup — will re-prompt in 10 seconds")
                # Wait longer if they said no so it's not spammy
                time.sleep(10)
                continue

            # Open POV My Services
            log("Opening POV My Services window")
            xbmc.executebuiltin(MY_SERVICES_TRIGGER)

            # Give the user time to actually do the auth
            time.sleep(5) 
            wait_for_fen_dialog_close()
            time.sleep(2)

        log("Service check completed successfully.")

    except Exception as e:
        log("Exception in service.py: %s" % repr(e), xbmc.LOGERROR)
        log(traceback.format_exc(), xbmc.LOGERROR)

if __name__ == "__main__":
    run_service()
    # Script ends naturally here. No SystemExit called.

