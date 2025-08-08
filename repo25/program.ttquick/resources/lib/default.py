import xbmc
import xbmcaddon
import xbmcgui
import xbmcvfs
import zipfile
import os

def extract_zip_if_new():
    addon = xbmcaddon.Addon()
    addon_path = xbmcvfs.translatePath(addon.getAddonInfo('path'))
    zip_path = os.path.join(addon_path, 'myfile')
    home_path = xbmcvfs.translatePath('special://home')
    extract_path = home_path
    timestamp_file = os.path.join(addon_path, '.timestamp')

    if os.path.exists(zip_path):
        zip_mtime = os.path.getmtime(zip_path)

        last_mtime = 0
        if os.path.exists(timestamp_file):
            try:
                with open(timestamp_file, 'r') as f:
                    last_mtime = float(f.read().strip())
            except:
                pass

        if zip_mtime > last_mtime:
            try:
                with zipfile.ZipFile(zip_path, 'r') as zip_ref:
                    zip_ref.extractall(extract_path)

                with open(timestamp_file, 'w') as f:
                    f.write(str(zip_mtime))

                try:
                    os.remove(zip_path)
                except:
                    pass

                xbmcgui.Dialog().notification("Terry Tibbs Installer", "Bingie Build Installed!", xbmcgui.NOTIFICATION_INFO)
                os._exit(1)

            except:
                xbmcgui.Dialog().notification("Terry Tibbs Installer", "Extraction failed", xbmcgui.NOTIFICATION_ERROR)
        else:
            xbmcgui.Dialog().notification("Terry Tibbs Installer", "No update needed", xbmcgui.NOTIFICATION_INFO)
    else:
        xbmcgui.Dialog().notification("Terry Tibbs Installer", "ZIP file not found", xbmcgui.NOTIFICATION_ERROR)

def main():
    xbmcgui.Dialog().ok("Terry Tibbs Installer", "Starting Bingie Build Installation...")
    extract_zip_if_new()

if __name__ == '__main__':
    main()

