import requests, re
from bs4 import BeautifulSoup

from ..models.Extractor import Extractor
from ..models.Game import Game
from ..models.Link import Link
from ..util import jsunpack, find_iframes
from .voodc import Voodc

class Strfi5h(Extractor):
    def __init__(self) -> None:
        self.domains = ["strfi5h.blogspot.com"]
        self.name = "Strfi5h"

    def get_games(self):
        games = []
        r = requests.get(f"https://{self.domains[0]}/search?max-results=100").text
        soup = BeautifulSoup(r, "html.parser")
        for game in soup.select("div.blog-post"):
            game_title = game.select_one("h2.post-title").text.strip()
            game_href = game.select_one("a").get("href")
            game_icon = game.select_one("img").get("src")
            game_league = game.select_one("a.post-tag").text.strip()[1:]
            games.append(Game(game_title, links=[Link(game_href, is_links=True)], icon=game_icon, league=game_league))
        return games
    
    def get_links(self, url):
        r = requests.get(url).text
        soup = BeautifulSoup(r, "html.parser")
        links = [Link(link.get("href"), name=link.text) for link in soup.select("center > a")]
        if len(links) == 0:
            links = [Link(url)]
        return links

    def get_link(self, url):
        r = requests.get(url).text
        iframe = re.findall("iframe.+src=\"(.+?)\"", r)[0]
        if "voodc" in iframe:
            return Voodc().get_link(iframe)
        else:
            iframes = [Link(u) if not isinstance(u, Link) else u for u in find_iframes.find_iframes(iframe, "", [], [])]
            return iframes[0]
    