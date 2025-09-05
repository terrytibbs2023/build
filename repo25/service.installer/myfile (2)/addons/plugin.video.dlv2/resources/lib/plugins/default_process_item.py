import urllib.parse
import json
from ..plugin import Plugin


class default_process_item(Plugin):
    name = "default process item"
    priority = 0

    def process_item(self, item):
        is_dir = False
        tag = item["type"]
        link = item.get("link", "")
        if link:
            if tag == "dir":
                link = f"/get_list/{link}"
                is_dir = True
            elif tag == "mac":
                link = f"/get_list/mac://{link}"
                is_dir = True
        if tag == "item":
            link_item = urllib.parse.quote_plus(json.dumps(item))
            link = f"play_video/{link_item}"
        
        item["link"] = link
        item["is_dir"] = is_dir
        return item