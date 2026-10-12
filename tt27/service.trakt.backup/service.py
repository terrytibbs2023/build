import xbmc
import xbmcvfs
import xml.etree.ElementTree as ET
import os

# Addon details
ADDON_ID = "plugin.video.fen"
ADDON_DATA = xbmcvfs.translatePath(f"special://profile/addon_data/{ADDON_ID}")
SETTINGS_FILE = os.path.join(ADDON_DATA, "settings.xml")
BACKUP_FILE = "/storage/emulated/0/Download/trakt_full_backup.txt"

# Full Trakt credential set
TRAKT_KEYS = [
    "trakt.enabled", "trakt.authorization", "trakt.refresh_token",
    "trakt.token", "trakt.username", "trakt.account_linked",
    "trakt.sync_collection", "trakt.sync_watched", "trakt.scrobble",
    "trakt.manager"
]

def get_setting_value(root, key):
    for setting in root.findall("setting"):
        if setting.get("id") == key:
            return setting.text or ""
    return ""

def set_setting_value(root, key, value):
    for setting in root.findall("setting"):
        if setting.get("id") == key:
            setting.text = value
            return True
    ET.SubElement(root, "setting", id=key, default="true").text = value
    return True

def backup_trakt_credentials(root):
    creds = {}
    for key in TRAKT_KEYS:
        val = get_setting_value(root, key)
        if val:
            creds[key] = val

    if not creds:
        xbmc.log("[TRAKTBACKUP] No Trakt credentials found—skipping backup", xbmc.LOGWARNING)
        return

    try:
        with open(BACKUP_FILE, "w") as f:
            for k, v in creds.items():
                f.write(f"{k}={v}\n")
        xbmc.log("[TRAKTBACKUP] Trakt credentials backed up", xbmc.LOGINFO)
    except Exception as e:
        xbmc.log(f"[TRAKTBACKUP] Backup failed: {str(e)}", xbmc.LOGERROR)

def restore_trakt_credentials(tree, root):
    if not os.path.exists(BACKUP_FILE):
        xbmc.log("[TRAKTBACKUP] No backup file found—cannot restore", xbmc.LOGWARNING)
        return False

    try:
        with open(BACKUP_FILE, "r") as f:
            for line in f:
                if "=" in line:
                    key, val = line.strip().split("=", 1)
                    if key in TRAKT_KEYS:
                        set_setting_value(root, key, val)
                        xbmc.log(f"[TRAKTBACKUP] Restored {key}", xbmc.LOGINFO)

        tree.write(SETTINGS_FILE)
        xbmc.log("[TRAKTBACKUP] Trakt credentials restored", xbmc.LOGINFO)
        return True
    except Exception as e:
        xbmc.log(f"[TRAKTBACKUP] Restore failed: {str(e)}", xbmc.LOGERROR)
        return False

def main():
    if not os.path.exists(SETTINGS_FILE):
        xbmc.log("[TRAKTBACKUP] settings.xml not found", xbmc.LOGWARNING)
        return

    try:
        tree = ET.parse(SETTINGS_FILE)
        root = tree.getroot()

        trakt_enabled = get_setting_value(root, "trakt.enabled").strip().lower()
        xbmc.log(f"[TRAKTBACKUP] trakt.enabled = {trakt_enabled}", xbmc.LOGINFO)

        if trakt_enabled == "true":
            backup_trakt_credentials(root)
        elif trakt_enabled == "false":
            if restore_trakt_credentials(tree, root):
                xbmc.log("[TRAKTBACKUP] Forcing Kodi shutdown after restore", xbmc.LOGINFO)
                xbmc.executebuiltin("Quit()")
        else:
            xbmc.log("[TRAKTBACKUP] trakt.enabled value unclear—no action taken", xbmc.LOGWARNING)

    except Exception as e:
        xbmc.log(f"[TRAKTBACKUP] Error: {str(e)}", xbmc.LOGERROR)

main()

if hasattr(xbmc, "abortRequested"):
    while not xbmc.abortRequested:
        xbmc.sleep(10000)

