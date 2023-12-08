import requests, re
from bs4 import BeautifulSoup

from ..models.Extractor import Extractor
from ..models.Game import Game
from ..models.Link import Link

class Voodc(Extractor):
    def __init__(self) -> None:
        self.domains = ["voodc.com"]
        self.name = "Voodc"
        self.short_name = "TP"

    def get_link(self, url):
        r = requests.get(url, headers={"User-Agent": self.user_agent}).text
        script = "https:" + re.findall(r'" src="(.+?)"', r)[0]
        split = script.split("/")
        embed_url = f"https://voodc.com/player/d/{split[-1]}/{split[-2]}"
        r = requests.get(embed_url, headers={"User-Agent": self.user_agent}).text
        m3u8 = re.findall(r'"file": \'(.+?)\'',  r)[0]
        return Link(m3u8, headers={"User-Agent": self.user_agent})