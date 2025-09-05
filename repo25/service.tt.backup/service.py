import xbmc
import xbmcvfs
import xml.etree.ElementTree as ET
import os

ADDON_ID = "plugin.video.fen"
ADDON_DATA = xbmcvfs.translatePath(f"special://profile/addon_data/" + ADDON_ID)
SETTINGS_FILE = os.path.join(ADDON_DATA, "settings.xml")
BACKUP_FILE = "/storage/emulated/0/Download/kodi_cred_backup.txt"

RD_KEYS = ["rd.token", "rd.refresh", "rd.account_id", "rd.client_id", "rd.secret"]
TRAKT_KEYS = ["trakt.token", "trakt.refresh", "trakt.expires"]

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

def backup_credentials(root):
    creds = {}
    for key in RD_KEYS + TRAKT_KEYS:
        val = get_setting_value(root, key)
        if val:
            creds[key] = val

    try:
        with open(BACKUP_FILE, "w") as f:
            for k, v in creds.items():
                f.write(f"{k}={v}\n")
        xbmc.log("[CredBackup] Trakt + RD credentials backed up to /Download", xbmc.LOGINFO)
    except Exception as e:
        xbmc.log(f"[CredBackup] Backup failed: {str(e)}", xbmc.LOGERROR)

def restore_credentials(tree, root):
    if not os.path.exists(BACKUP_FILE):
        xbmc.log("[CredBackup] No backup file found—cannot restore", xbmc.LOGWARNING)
        return False

    try:
        with open(BACKUP_FILE, "r") as f:
            for line in f:
                if "=" in line:
                    key, val = line.strip().split("=", 1)
                    set_setting_value(root, key, val)
                    xbmc.log(f"[CredBackup] Restored {key}", xbmc.LOGINFO)

        set_setting_value(root, "rd.enabled", "true")
        set_setting_value(root, "trakt.enabled", "true")
        tree.write(SETTINGS_FILE)
        xbmc.log("[CredBackup] Credentials restored and services enabled", xbmc.LOGINFO)
        return True
    except Exception as e:
        xbmc.log(f"[CredBackup] Restore failed: {str(e)}", xbmc.LOGERROR)
        return False

def main():
    if not os.path.exists(SETTINGS_FILE):
        xbmc.log("[CredBackup] settings.xml not found", xbmc.LOGWARNING)
        return

    try:
        tree = ET.parse(SETTINGS_FILE)
        root = tree.getroot()

        rd_enabled = get_setting_value(root, "rd.enabled").strip().lower()
        xbmc.log(f"[CredBackup] rd.enabled = {rd_enabled}", xbmc.LOGINFO)

        if rd_enabled == "true":
            backup_credentials(root)
        elif rd_enabled == "false":
            if restore_credentials(tree, root):
                xbmc.log("[CredBackup] Forcing Kodi shutdown after restore", xbmc.LOGINFO)
                xbmc.executebuiltin("Quit()")
        else:
            xbmc.log("[CredBackup] rd.enabled value unclear—no action taken", xbmc.LOGWARNING)

    except Exception as e:
        xbmc.log(f"[CredBackup] Error: {str(e)}", xbmc.LOGERROR)

main()

if hasattr(xbmc, "abortRequested"):
    while not xbmc.abortRequested:
        xbmc.sleep(10000)

