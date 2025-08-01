import xbmc
import xbmcaddon
import xbmcgui
import xbmcvfs
import zipfile
import os

# Addon setup
addon = xbmcaddon.Addon()
addon_path = xbmcvfs.translatePath(addon.getAddonInfo('path'))
zip_path = os.path.join(addon_path, 'myfile')

home_path = xbmcvfs.translatePath('special://home')
extract_path = os.path.join(home_path)  # Fixed comma issue

timestamp_file = os.path.join(addon_path, '.timestamp')

# Locate ZIP file
if os.path.exists(zip_path):
    zip_mtime = os.path.getmtime(zip_path)

    # Check previous extraction
    last_mtime = 0
    if os.path.exists(timestamp_file):
        try:
            with open(timestamp_file, 'r') as f:
                last_mtime = float(f.read().strip())
        except:
            pass  # Skip errors silently

    # Compare timestamps
    if zip_mtime > last_mtime:
        try:
            # Extract
            with zipfile.ZipFile(zip_path, 'r') as zip_ref:
                zip_ref.extractall(extract_path)

            # Update timestamp
            with open(timestamp_file, 'w') as f:
                f.write(str(zip_mtime))

            # Delete ZIP
            try:
                os.remove(zip_path)
            except:
                pass

            # Exit Kodi
            os._exit(1)

        except:
            pass  # Skip extraction errors silently

