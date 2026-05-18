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

def run_service():
    try:
        log("Service start")

        if not wait_for_kodi_home():
            log("Kodi home window timed out. Exiting service check.")
            return

        xbmc.executebuiltin('UpdateAddonRepos')
        time.sleep(2)

        monitor = xbmc.Monitor()

        while not monitor.abortRequested():
            if trakt_enabled():
                log("Trakt is enabled — exiting service loop")
                break

            log("Displaying Trakt warning notification")
            
            # Universal built-in command format: Notification(Heading, Message, Time_In_MS)
            # This triggers a standard, non-blocking notification toast in the top-right corner.
            heading = "Trakt Setup"
            message = "Bingie requires Trakt to work"
            duration = 50000  # Visible for 5 seconds
            
            xbmc.executebuiltin(f'Notification({heading}, {message}, {duration})')

            # Safe 10-second wait that yields immediately if Kodi exits
            for _ in range(10):
                if monitor.waitForAbort(1):
                    break

        log("Service check completed successfully.")

    except Exception as e:
        log("Exception in service.py: %s" % repr(e), xbmc.LOGERROR)
        log(traceback.format_exc(), xbmc.LOGERROR)

if __name__ == "__main__":
    run_service()

