import xbmcaddon
import xbmcgui
import os
import zipfile
import urllib.request

addon = xbmcaddon.Addon()
addon_path = addon.getAddonInfo('path')
data_path = xbmcaddon.Addon().getAddonInfo('profile')
flag_file = os.path.join(data_path, 'setup_done.txt')

def download_and_extract_zip(url, extract_to):
    zip_path = os.path.join(extract_to, 'setup.zip')
    urllib.request.urlretrieve(url, zip_path)
    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        zip_ref.extractall(extract_to)
    os.remove(zip_path)

if not os.path.exists(flag_file):
    dialog = xbmcgui.Dialog()
    dialog.ok("AutoSetup Wizard", "Running first-time setup...")
    
    zip_url = "https://example.com/setup.zip"  # Replace with your actual URL
    download_and_extract_zip(zip_url, data_path)

    with open(flag_file, 'w') as f:
        f.write("Setup complete")

    dialog.ok("Setup Complete", "Files downloaded and extracted.")
else:
    xbmcgui.Dialog().ok("AutoSetup Wizard", "Setup already completed.")

