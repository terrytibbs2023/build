import requests, re, base64
from bs4 import BeautifulSoup
from dateutil.parser import parse
from datetime import timedelta, datetime

from ..models.Extractor import Extractor
from ..models.Game import Game
from ..models.Link import Link
from ..util.m3u8_src import scan_page
from ..util import jsunpack, find_iframes

class Sportshub(Extractor):
    def __init__(self) -> None:
        self.domains = ["sportshub.ai"]
        self.name = "Sportshub"
        self.short_name = "SH"

    def get_games(self):
        games = []
        r = requests.get(f"https://{self.domains[0]}").text
        soup = BeautifulSoup(r, "html.parser")
        

        # games = soup.select("ul.competitions")  # Select all <li> elements within the <ul class="competitions"> element

        
          

        for competition in soup.select("div.top-tournament"):
            sport = " ".join(competition.find("h2").text.split(" ")[1:-2])
            for game in competition.select("li"):
                block = game.find("a")
                href = block.get("href")
                if "d-block" in block.attrs["class"]:
                    name = "-".join(game.find("div").text.replace("\n", "").strip().split("-")[:-1])
                else:
                    name = " ".join(block.get("title").split(" ")[1:])
                score_elem = block.find("span", class_="competition-cell-score")
                if score_elem != None:
                    try:
                        score_info = score_elem.text.strip().split("\n")
                        score = score_info[0].strip()
                        quarter = score_info[1].strip()
                        name += f" ({score}, {quarter})"
                    except:
                        pass
                    game.previous
                games.append(Game(name, links=[Link(href)], league=sport))
        return games

    def get_link(self, url):
        iframes = [Link(u) if not isinstance(u, Link) else u for u in find_iframes.find_iframes(url, "", [], [])]
        return iframes[0]









    
