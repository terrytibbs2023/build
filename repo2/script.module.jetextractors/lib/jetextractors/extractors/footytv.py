
import requests, re, datetime
from bs4 import BeautifulSoup

from ..models.Extractor import Extractor
from ..models.Game import Game
from ..models.Link import Link
from ..util import jsunpack

class FootyBiteTV(Extractor):
    def __init__(self) -> None:
        self.domains = ["www.footybite.one","footybite.tv", "www.footybite.tv"]
        self.name = "FootyBiteTV"

    def get_games(self):
        games = []
        r = requests.get(f"https://{self.domains[0]}").text
        soup = BeautifulSoup(r, "html.parser")

        for game in soup.find_all("tr"):
            name = game.select_one("td.et4").text
            game_time = game.select_one("td.et3").text.split(":")
            hour = int(game_time[0])
            minute = int(game_time[1])
            utc_time = datetime.datetime.now().replace(hour=hour, minute=minute) + datetime.timedelta(hours=23)
            
            if not name:
                continue
            href = game.find("a").get("href")
            games.append(Game(name, starttime=utc_time, links=[Link(href)]))
        return games

    def get_link(self, url):
        
        r = requests.get(url).text
        re_iframe = re.findall(r'iframe.+?src="(.+?)"', r)[0]

        r_iframe = requests.get(re_iframe, headers={"Referer": url}).text
        re_iframe2 = re.findall(r'iframe.+?src="(.+?)"', r_iframe)[0]

        r_iframe2 = requests.get(re_iframe2, headers={"Referer": re_iframe}).text
        re_packed = re.findall(r"(eval\(function\(p,a,c,k,e,d\).+?{}\)\))", r_iframe2)[0]
        deobfus_packed = jsunpack.unpack(re_packed)
        m3u8 = re.findall(r'var src="(.+?)"', deobfus_packed)[0]
        return Link(m3u8, headers={"Referer": re_iframe2, "User-Agent": self.user_agent})


