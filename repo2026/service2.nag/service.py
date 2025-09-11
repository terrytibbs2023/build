import xbmc
import xbmcvfs
import xml.etree.ElementTree as ET
import time

ADDON_ID = 'plugin.video.fen'
SETTINGS_PATH = xbmcvfs.translatePath(f'special://profile/addon_data/{ADDON_ID}/settings.xml')
RD_TRIGGER = (
    'PlayMedia("plugin://plugin.video.fen/?mode=auth_accounts_choice'
    '&service=realdebrid&active=False&isFolder=false&iconImage=https%3A%2F%2Fi.imgur.com%2FhlHDYca.png")'
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

def rd_is_disabled(settings_path):
    if not xbmcvfs.exists(settings_path):
        return True
    try:
        tree = ET.parse(settings_path)
        root = tree.getroot()
        client_id = get_setting_value(root, 'rd.client_id')
        refresh = get_setting_value(root, 'rd.refresh')
        token = get_setting_value(root, 'rd.token')
        return not any([client_id, refresh, token])
    except:
        return True

if __name__ == '__main__':
    if wait_for_kodi_ready() and rd_is_disabled(SETTINGS_PATH):
        time.sleep(2)  # Extra delay for RD safety
        xbmc.executebuiltin(RD_TRIGGER)
        xbmc.log("[RDCheck] Real-Debrid not active — Triggered PlayMedia", xbmc.LOGINFO)

