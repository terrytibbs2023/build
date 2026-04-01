import os
import xbmcaddon
import xbmcvfs
from ..plugin import Plugin

PATH = xbmcvfs.translatePath(xbmcaddon.Addon().getAddonInfo("path"))


class Local(Plugin):
    name = "local"
    priority = 0

    def get_list(self, url: str):
        if url.startswith("file://"):
            url = url.replace("file://", "")
            if url.endswith(".json"):
                input_file = xbmcvfs.File(os.path.join(PATH, "json", url))
            elif url.endswith(".xml"):
                input_file = xbmcvfs.File(os.path.join(PATH, "xml", url))
            else:
                input_file = xbmcvfs.File(os.path.join(PATH, "texts", url))
            return input_file.read()
