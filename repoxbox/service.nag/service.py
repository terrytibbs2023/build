import xbmc
import xbmcvfs
import xml.etree.ElementTree as ET
import time

ADDON_ID = 'plugin.video.fen'
SETTINGS_PATH = xbmcvfs.translatePath(f'special://profile/addon_data/{ADDON_ID}/settings.xml')
TRAKT_TRIGGER = (
    'PlayMedia("plugin://plugin.video.fen/?mode=auth_accounts_choice'
    '&service=trakt&active=False&isFolder=false&iconImage=https%3A%2F%2Fi.imgur.com%2FWQO1410.png")'
)

def get_setting_value(root, key):
    for setting in root.findall('setting'):
        if setting.get('id') == key:
            return (setting.text or '').strip()
    return ''

def wait_for_kodi_ready(timeout=10):
    for _ in range(timeout):
        if xbmc.getCondVisibility('Window.IsVisible(home)'):
            return True
        time.sleep(1)
    return False

def trakt_is_disabled(settings_path):
    if not xbmcvfs.exists(settings_path):
        return True
    try:
        tree = ET.parse(settings_path)
        root = tree.getroot()
        return get_setting_value(root, 'trakt.indicators_active').lower() != 'true'
    except:
        return True

if __name__ == '__main__':
    if wait_for_kodi_ready() and trakt_is_disabled(SETTINGS_PATH):
        xbmc.executebuiltin(TRAKT_TRIGGER)
        xbmc.log("[TraktCheck] Trakt not active — Triggered PlayMedia", xbmc.LOGINFO)

