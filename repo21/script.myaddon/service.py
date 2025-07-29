import urllib.request
import xbmcvfs
import zipfile
import shutil
import os
import xbmc
import datetime

# Paths
local_zip_path = xbmcvfs.translatePath("special://home/temp.zip")
extract_path = xbmcvfs.translatePath("special://home/")
timestamp_file = xbmcvfs.translatePath("special://home/last_download.txt")
zip_url = "https://raw.githubusercontent.com/terrytibbs2023/build/main/jan25.zip"

def notify(title, message):
    xbmc.executebuiltin(f'Notification("{title}", "{message}", 5000)')

def get_remote_timestamp():
    notify("Checking for update", "Querying server timestamp...")
    request = urllib.request.Request(zip_url, method="HEAD")
    with urllib.request.urlopen(request) as response:
        modified = response.headers.get("Last-Modified")
        if modified:
            notify("Timestamp found", f"Remote: {modified}")
            return datetime.datetime.strptime(modified, "%a, %d %b %Y %H:%M:%S %Z")
    notify("Error", "No Last-Modified header found")
    return None

def get_local_timestamp():
    if xbmcvfs.exists(timestamp_file):
        try:
            with open(timestamp_file, "r") as f:
                stamp = f.read().strip()
                notify("Last download", f"Local: {stamp}")
                return datetime.datetime.strptime(stamp, "%Y-%m-%d %H:%M:%S")
        except Exception as e:
            notify("Warning", f"Invalid timestamp or read error: {e}")
            return None
    else:
        notify("First run", "No local timestamp found")
        return None

def save_local_timestamp(dt):
    with open(timestamp_file, "w") as f:
        f.write(dt.strftime("%Y-%m-%d %H:%M:%S"))
    notify("Saved", "Timestamp updated locally")

def download_and_extract():
    notify("Downloading", "Grabbing ZIP from server...")
    with urllib.request.urlopen(zip_url) as response:
        with open(local_zip_path, 'wb') as out_file:
            shutil.copyfileobj(response, out_file)
    notify("Download complete", "ZIP file saved locally")

    if zipfile.is_zipfile(local_zip_path):
        notify("Extracting", "Unzipping contents...")
        with zipfile.ZipFile(local_zip_path, 'r') as zip_ref:
            zip_ref.extractall(extract_path)
        notify("Extraction done", "Files ready to go")
        os.remove(local_zip_path)
        notify("Cleanup", "Temp ZIP removed")
    else:
        notify("Error", "Downloaded file is not a valid ZIP")

def main():
    remote_time = get_remote_timestamp()
    local_time = get_local_timestamp()

    if not remote_time:
        return

    if not local_time or remote_time > local_time:
        notify("Update needed", "Server ZIP is newer — downloading...")
        download_and_extract()
        save_local_timestamp(remote_time)
    else:
        notify("No update", "Local ZIP is already up to date")

    notify("Kodi", "Shutting down...")
    xbmc.shutdown()

main()

