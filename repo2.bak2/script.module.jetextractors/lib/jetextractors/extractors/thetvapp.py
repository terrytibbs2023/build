import requests, re
from bs4 import BeautifulSoup

from ..models.Extractor import Extractor
from ..models.Game import Game
from ..models.Link import Link

class TheTVApp(Extractor):
    def __init__(self) -> None:
        self.domains = ["thetvapp.to"]
        self.name = "TheTVApp"

    def get_games(self):
        games = [
            Game("Live TV", page="tv"),
            Game("NBA", page="nba"),
            Game("MLB", page="mlb"),
            Game("NHL", page="nhl"),
            Game("NFL", page="nfl"),
        ]
        return games
    
    def get_games_page(self, page):
        games = []
        
        r = requests.get(f"https://{self.domains[0]}/{page}").text
        soup = BeautifulSoup(r, "html.parser")
        for link in soup.select("a.list-group-item"):
            href = f"https://{self.domains[0]}" + link.get("href")
            name = link.text
            games.append(Game(name, [Link(href)]))

        return games

    def get_link(self, url):
        s = requests.Session()
        r = s.get(url, headers={"User-Agent": self.user_agent, "Referer": f"https://{self.domains[0]}/"}).text
        csrf_token = re.findall(r'name="csrf-token" content="(.+?)"', r)[0]
        token_url = f"https://{self.domains[0]}" + re.findall(r'url: "(.+?)"', r)[0]
        r_token = s.post(token_url, headers={"X-CSRF-TOKEN": csrf_token, "x-requested-with": "XMLHttpRequest", "Referer": url, "User-Agent": self.user_agent}).text
        return Link(r_token, headers={"Referer": f"https://{self.domains[0]}/", "User-Agent": self.user_agent})