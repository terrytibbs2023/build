import requests, re, base64
from bs4 import BeautifulSoup
from dateutil.parser import parse
from datetime import timedelta, datetime

from ..models.Extractor import Extractor
from ..models.Game import Game
from ..models.Link import Link
from ..util.m3u8_src import scan_page
from ..util import jsunpack, find_iframes

class Freehdgames(Extractor):
    def __init__(self) -> None:
        self.domains = ["gameshdlive.net"]
        self.name = "Freehdgames"
        self.short_name = "HG"

    def get_games(self):
        games = []
        r = requests.get(f"https://{self.domains[0]}").text
        soup = BeautifulSoup(r, "html.parser")
        

        # games = soup.select("ul.competitions")  # Select all <li> elements within the <ul class="competitions"> element

        
          

        for game in soup.select("p > a"):
            league = game.previous.previous.text
            link_name = game.text
            game_time = game.previous.previous.previous.previous.text
            name = (game_time + " " + game.previous.text).strip()
            if not name or "GAMESHDLIVE.NET" in name:
                continue
            href = game.get("href")
            games.append(Game(name, league=league, links=[Link(href, name=link_name)]))
        return games

    def get_link(self, url):
        iframes = [Link(u) if not isinstance(u, Link) else u for u in find_iframes.find_iframes(url, "", [], [])]
        return iframes[0]









    
