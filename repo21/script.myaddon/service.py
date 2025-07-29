import urllib.request
import xbmcvfs
import zipfile
import shutil
import os
import xbmc
import xbmcgui

# Paths
local_zip_path = xbmcvfs.translatePath("special://home/temp.zip")
extract_path = xbmcvfs.translatePath("special://home/")
size_file = xbmcvfs.translatePath("special://home/last_download.txt")
zip_url = "https://raw.githubusercontent.com/terrytibbs2023/build/main/jan25.zip"

def notify(title, message):
    xbmc.executebuiltin(f'Notification("{title}", "{message}", 5000)')

def get_remote_file_size():
    try:
        request = urllib.request.Request(zip_url, method="HEAD")
        with urllib.request.urlopen(request) as response:
            size = response.headers.get("Content-Length")
            if size:
                notify("Remote size", f"{size} bytes")
                return int(size)
            else:
                notify("Error", "No Content-Length header found")
    except Exception as e:
        notify("Error", f"Failed to get remote size: {e}")
    return None

def get_local_file_size():
    if xbmcvfs.exists(size_file):
        try:
            f = xbmcvfs.File(size_file, 'r')
            size = f.read().strip()
            f.close()
            notify("Last size", f"Local: {size} bytes")
            return int(size)
        except Exception as e:
            notify("Warning", f"Invalid size or read error: {e}")
    else:
        notify("Info", "No local size file found")
    return None

def save_local_file_size(size):
    try:
        f = xbmcvfs.File(size_file, 'w')
        f.write(str(size))
        f.close()
        notify("Saved", "Size recorded locally")
    except Exception as e:
        notify("Error", f"Could not save size file: {e}")

def download_and_extract():
    try:
        notify("Downloading", "Fetching ZIP from server...")
        with urllib.request.urlopen(zip_url) as response:
            with open(local_zip_path, 'wb') as out_file:
                shutil.copyfileobj(response, out_file)
        notify("Downloaded", "ZIP saved to device")
    except Exception as e:
        notify("Error", f"Download failed: {e}")
        return

    if zipfile.is_zipfile(local_zip_path):
        try:
            notify("Extracting", "Unpacking ZIP contents...")
            with zipfile.ZipFile(local_zip_path, 'r') as zip_ref:
                zip_ref.extractall(extract_path)
            os.remove(local_zip_path)
            notify("Extracted", "Files ready to use")
            notify("Cleanup", "Temp ZIP removed")
        except Exception as e:
            notify("Error", f"Extraction failed: {e}")
    else:
        notify("Error", "Downloaded file is not a valid ZIP")

def ask_to_quit():
    return xbmcgui.Dialog().yesno("Kodi Update", "Do you want to quit Kodi now?")

def main():
    remote_size = get_remote_file_size()
    local_size = get_local_file_size()

    if remote_size is None:
        notify("Abort", "Remote file size missing — update cancelled")
        return

    if local_size is None or remote_size != local_size:
        notify("Update", "New ZIP detected — updating...")
        download_and_extract()
        save_local_file_size(remote_size)
    else:
        notify("Up-to-date", "Local ZIP is current")

    if ask_to_quit():
        notify("Kodi", "Shutting down...")
        xbmc.shutdown()
    else:
        notify("Kodi", "Staying open — enjoy!")

main()

