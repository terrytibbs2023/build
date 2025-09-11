import xbmc
import xbmcvfs
import xml.etree.ElementTree as ET
import time

# Constants
ADDON_ID = 'plugin.video.fen'
SETTINGS_PATH = xbmcvfs.translatePath(f'special://profile/addon_data/{ADDON_ID}/settings.xml')

TRAKT_TRIGGER = (
    'PlayMedia("plugin://plugin.video.fen/?mode=auth_accounts_choice'
    '&service=trakt&active=False&isFolder=false&iconImage=https%3A%2F%2Fi.imgur.com%2FWQO1410.png")'
)

RD_TRIGGER = (
    'PlayMedia("plugin://plugin.video.fen/?mode=auth_accounts_choice'
    '&service=realdebrid&active=False&isFolder=false&iconImage=https%3A%2F%2Fi.imgur.com%2FhlHDYca.png")'
)

def get_setting_value(root, key):
    for setting in root.findall('setting'):
        if setting.get('id') == key:
            return (setting.text or '').strip()
    return ''

def check_services(settings_path):
    if not xbmcvfs.exists(settings_path):
        xbmc.log(f"[ServiceCheck] settings.xml not found at {settings_path}", xbmc.LOGWARNING)
        return {'trakt': False, 'rd': False}

    try:
        tree = ET.parse(settings_path)
        root = tree.getroot()

        trakt_active = get_setting_value(root, 'trakt.indicators_active').lower() == 'true'
        rd_client_id = get_setting_value(root, 'rd.client_id')
        rd_refresh = get_setting_value(root, 'rd.refresh')
        rd_active = bool(rd_client_id or rd_refresh)

        return {'trakt': trakt_active, 'rd': rd_active}

    except Exception as e:
        xbmc.log(f"[ServiceCheck] Failed to parse settings.xml: {e}", xbmc.LOGERROR)
        return {'trakt': False, 'rd': False}

def run_trigger(trigger, label):
    xbmc.log(f"[ServiceCheck] Triggering {label} PlayMedia", xbmc.LOGINFO)
    xbmc.executebuiltin(trigger)

def wait_for_kodi_ready(timeout=10):
    for _ in range(timeout):
        if xbmc.getCondVisibility('Window.IsVisible(home)'):
            return True
        time.sleep(1)
    return False

if __name__ == '__main__':
    if wait_for_kodi_ready():
        status = check_services(SETTINGS_PATH)

        if not status['trakt']:
            run_trigger(TRAKT_TRIGGER, 'Trakt')

        if not status['rd']:
            run_trigger(RD_TRIGGER, 'Real-Debrid')
    else:
        xbmc.log("[ServiceCheck] Kodi GUI not ready — skipping triggers", xbmc.LOGWARNING)

