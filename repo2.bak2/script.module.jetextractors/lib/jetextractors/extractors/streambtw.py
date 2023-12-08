import requests, re, base64
from bs4 import BeautifulSoup
from dateutil.parser import parse
from datetime import timedelta, datetime

from ..models.Extractor import Extractor
from ..models.Game import Game
from ..models.Link import Link
from ..util.m3u8_src import scan_page
from ..util import jsunpack, find_iframes
from ..util.hunter import hunter

class StreamBTW(Extractor):
    def __init__(self) -> None:
        self.domains = ["streambtw.com"]
        self.name = "StreamBTW"
        self.short_name = "CS"

    def get_games(self):
        games = []
        r = requests.get(f"https://{self.domains[0]}").text
        soup = BeautifulSoup(r, "html.parser")
        for game in soup.select("li"):
             name=game.text
             href = game.find("a").get("href")
             games.append(Game(name,links=[Link(href)]))




        return games

    def get_link(self, url):
            iframes = [Link(u) if not isinstance(u, Link) else u for u in find_iframes.find_iframes(url, "", [], [])]
            return iframes[0]