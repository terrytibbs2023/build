import xbmc
import xbmcvfs
import xml.etree.ElementTree as ET
import os
import time

# Addon details
ADDON_ID = "plugin.video.fen"
ADDON_DATA = xbmcvfs.translatePath(f"special://profile/addon_data/{ADDON_ID}")
SETTINGS_FILE = os.path.join(ADDON_DATA, "settings.xml")
BACKUP_FILE = "/storage/emulated/0/Download/kodi_cred_backup.txt"

# Keys to track
RD_KEYS = [
    "rd.token", "rd.refresh", "rd.account_id",
    "rd.client_id", "rd.secret", "rd.enabled"
]

TRAKT_KEYS = [
    "trakt.token", "trakt.refresh", "trakt.expires",
    "trakt.user", "trakt.indicators_active", "trakt.sync_refresh_widgets"
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

def is_trakt_token_expired(root):
    expires = get_setting_value(root, "trakt.expires")
    try:
        return int(expires) < int(time.time())
    except:
        return True  # Treat missing or invalid expiry as expired

def backup_credentials(root):
    creds = {}
    for key in RD_KEYS + TRAKT_KEYS:
        val = get_setting_value(root, key)
        if val:
            creds[key] = val

    try:
        with open(BACKUP_FILE, "w") as f:
            f.write(f"#timestamp:{int(time.time())}\n")
            for k, v in creds.items():
                f.write(f"{k}={v}\n")
        xbmc.log("[CredBackup] Credentials backed up to /Download", xbmc.LOGINFO)
    except Exception as e:
        xbmc.log(f"[CredBackup] Backup failed: {str(e)}", xbmc.LOGERROR)

def restore_credentials(tree, root):
    if not os.path.exists(BACKUP_FILE):
        xbmc.log("[CredBackup] No backup file found—cannot restore", xbmc.LOGWARNING)
        return False

    try:
        with open(BACKUP_FILE, "r") as f:
            for line in f:
                if "=" in line and not line.startswith("#"):
                    key, val = line.strip().split("=", 1)
                    set_setting_value(root, key, val)
                    xbmc.log(f"[CredBackup] Restored {key}", xbmc.LOGINFO)

        # Force-enable indicators and widget refresh
        set_setting_value(root, "trakt.indicators_active", "true")
        set_setting_value(root, "trakt.sync_refresh_widgets", "true")
        xbmc.log("[CredBackup] Forced trakt.indicators_active and sync_refresh_widgets = true", xbmc.LOGINFO)

        tree.write(SETTINGS_FILE)
        xbmc.log("[CredBackup] Credentials restored", xbmc.LOGINFO)

        xbmc.executebuiltin('RunPlugin("plugin://plugin.video.fen/?action=traktSyncActivities")')
        xbmc.log("[CredBackup] Forced Trakt sync triggered", xbmc.LOGINFO)

        return True
    except Exception as e:
        xbmc.log(f"[CredBackup] Restore
