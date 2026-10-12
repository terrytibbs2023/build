from ..plugin import Plugin
from xbmcplugin import addDirectoryItem, endOfDirectory
from ..DI import DI
import urllib.parse

route_plugin = DI.plugin


class display(Plugin):
    name = "display"

    def display_list(self, jen_list):
        for item in jen_list:
            link = item["link"]
            list_item = item["list_item"]
            if item.get('is_playable'):
                list_item.setProperty('IsPlayable', 'true')
            is_dir = item["is_dir"]
            addDirectoryItem(
                route_plugin.handle, route_plugin.url_for_path(link), list_item, is_dir
            )
        endOfDirectory(route_plugin.handle)
        return True