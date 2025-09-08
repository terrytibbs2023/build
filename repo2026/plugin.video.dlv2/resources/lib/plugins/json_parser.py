from ..plugin import Plugin
import json
from typing import Dict, Union


class json_parser(Plugin):
    name = "json_parser"
    description = "add json format support"
    priority = 1

    def parse_list(self, url: str, response):
        if url.endswith(".json") or response.startswith("{"):
            try:
                return json.loads(response)["items"]
            except json.decoder.JSONDecodeError:
                import xbmc
                xbmc.log(f"invallid json: {response}")
