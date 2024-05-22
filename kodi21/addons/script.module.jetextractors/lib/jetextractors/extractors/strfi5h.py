import requests, re
from bs4 import BeautifulSoup

from ..models.Extractor import Extractor
from ..models.Game import Game
from ..models.Link import Link
from ..util import jsunpack, find_iframes
from .voodc import Voodc

class Strfi5h(Extractor):
    def __init__(self) -> None:
        self.domains = ["strfish.xyz"]
        self.name = "Strfi5h"

    def get_games_in_range(self, start_page, end_page):
        all_games = []

        for page in range(start_page, end_page + 1):
            games_on_page = self.get_games_page(page)
            if not games_on_page:
                break

            all_games.extend(games_on_page)

        return all_games
    
    def get_games(self):
        return self.get_games_in_range(1, 3)

    def get_games_page(self, page):
        page = int(page)
        games = []
        r = requests.get(f"https://{self.domains[0]}/?paged={page}").text
        soup = BeautifulSoup(r, "html.parser")
        for game in soup.select("div.cutemag-item-post"):
            game_title = game.select_one("h2").text.strip().replace("@","vs")
            game_href = game.select_one("a").get("href")
            # game_icon = game.select_one("img").get("src")
            # game_league = game_icon.split("/")[-1].split("-")[0].upper()
            games.append(Game(game_title, links=[Link(game_href, is_links=True)]))
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
    