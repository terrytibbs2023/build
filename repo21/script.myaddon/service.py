import xbmc
import xbmcaddon
import xbmcgui
import xbmcvfs
import zipfile
import os

# Addon setup
addon = xbmcaddon.Addon()
addon_name = addon.getAddonInfo('name')
addon_path = xbmcvfs.translatePath(addon.getAddonInfo('path'))
zip_path = os.path.join(addon_path, 'myfile')

# Fixed: Extract to Kodi home directory
home_path = xbmcvfs.translatePath('special://home')
extract_path = os.path.join(home_path)  # Removed comma to prevent tuple

timestamp_file = os.path.join(addon_path, '.timestamp')

# Step 1: Starting addon
xbmcgui.Dialog().notification(addon_name, 'Addon started', xbmcgui.NOTIFICATION_INFO, 2000)

# Step 2: Locating ZIP file
if not os.path.exists(zip_path):
    xbmcgui.Dialog().notification(addon_name, 'ZIP file not found', xbmcgui.NOTIFICATION_ERROR, 4000)
else:
    zip_mtime = os.path.getmtime(zip_path)
    xbmcgui.Dialog().notification(addon_name, 'ZIP file found', xbmcgui.NOTIFICATION_INFO, 2000)

    # Step 3: Checking previous extraction
    last_mtime = 0
    if os.path.exists(timestamp_file):
        try:
            with open(timestamp_file, 'r') as f:
                last_mtime = float(f.read().strip())
            xbmcgui.Dialog().notification(addon_name, 'Read last extract timestamp', xbmcgui.NOTIFICATION_INFO, 2000)
        except:
            xbmcgui.Dialog().notification(addon_name, 'Error reading timestamp', xbmcgui.NOTIFICATION_WARNING, 2000)

    # Step 4: Compare timestamps
    if zip_mtime > last_mtime:
        xbmcgui.Dialog().notification(addon_name, 'New ZIP detected', xbmcgui.NOTIFICATION_INFO, 2000)

        # Step 5: Extracting
        try:
            with zipfile.ZipFile(zip_path, 'r') as zip_ref:
                zip_ref.extractall(extract_path)
            with open(timestamp_file, 'w') as f:
                f.write(str(zip_mtime))
            xbmcgui.Dialog().notification(addon_name, 'ZIP extracted successfully', xbmcgui.NOTIFICATION_INFO, 3000)

            # NEW: Delete the ZIP file after successful extraction
            try:
                os.remove(zip_path)
                xbmcgui.Dialog().notification(addon_name, 'ZIP file deleted', xbmcgui.NOTIFICATION_INFO, 2000)
            except Exception as e:
                xbmcgui.Dialog().notification(addon_name, f'Failed to delete ZIP: {e}', xbmcgui.NOTIFICATION_WARNING, 3000)

            # Step 6: Exit Kodi (only if extraction succeeded)
            xbmcgui.Dialog().notification(addon_name, 'Force quitting Kodi...', xbmcgui.NOTIFICATION_INFO, 2000)
            os._exit(1)

        except Exception as e:
            xbmcgui.Dialog().notification(addon_name, f'Extract failed: {e}', xbmcgui.NOTIFICATION_ERROR, 5000)
    else:
        xbmcgui.Dialog().notification(addon_name, 'No updates — skipping extraction', xbmcgui.NOTIFICATION_INFO, 3000)

