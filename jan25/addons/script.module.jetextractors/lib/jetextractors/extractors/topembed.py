from ..models import *
import requests
from bs4 import BeautifulSoup
from ..util import m3u8_src
from ..icons import icons

class TopEmbed(JetExtractor):
    def __init__(self) -> None:
        self.domains = ["topembed.pw"]
        self.name = "TopEmbed"


    def get_items(self, params: Optional[dict] = None, progress: Optional[JetExtractorProgress] = None) -> List[JetItem]:
        items = []
        if self.progress_init(progress, items):
            return items

        LEAGUE_MAPPING = {
            "NBA": "NBA",
            "NFL": "NFL",
            "NHL": "NHL",
            "MLB": "MLB",
            "NCAA F": "NCAAF",
            "NCAA B": "NCAAB",
            "Soccer": "Soccer",
            "UFC": "UFC",
            "Boxing": "Boxing",
            "WWE": "WWE",
            "MMA": "MMA",
            "Tennis": "Tennis",
            "Golf": "Golf",
            "Rugby": "Rugby",
            "Cricket": "Cricket",
            "NASCAR": "NASCAR",
            "F1": "F1",
            "MotoGP": "MotoGP",
            "IndyCar": "IndyCar",
            "Supercross": "Supercross",
            "Darts": "Darts",
            "Snooker": "Snooker",
            "Table Tennis": "Table Tennis",
            "Volleyball": "Volleyball",
            "Handball": "Handball",
            "Basketball": "Basketball",
            "Hockey": "Hockey",
            "Baseball": "Baseball",
            "Football": "Soccer"
        }

        r = requests.get(f"https://{self.domains[0]}?all").text
        soup = BeautifulSoup(r, "html.parser")
        for game in soup.select("div.bg-white"):
            title1 = game.select_one("div.font-bold").text
            title2 = game.select_one("div.mb-2").text.replace("Info: ", "")

            leagues = title2.replace("Info: ", "")
            for key, value in LEAGUE_MAPPING.items():
                if key in leagues:
                    leagues = value
                    break

            title = f"{title1} - {title2}"
            links = []
            for channel in game.select("div.mb-4 > div > input"):
                l = channel.get("value")
                if not l.startswith("https"):
                    continue
                link = JetLink(l)
                if "/channel/" in l:
                    link.name = l.split("/")[-1]
                links.append(link)
            items.append(JetItem(icon=icons[leagues.lower()] if leagues.lower() in icons else None,league=leagues.upper(),title=title, links=links))
        
        r = requests.get(f"https://{self.domains[0]}?show_tv=true").text
        soup = BeautifulSoup(r, "html.parser")
        for channel in soup.select("tbody > tr"):
            title = channel.select_one("td").text
            l = channel.select_one("input").get("value")
            link = JetLink(l, name=l.split("/")[-1])
            items.append(JetItem(title, [link]))
        return items


    def get_link(self, url: JetLink) -> JetLink:
        r = requests.get(url.address, headers={"Referer": f"https://{self.domains[0]}/"}).text
        m3u8 = m3u8_src.scan(r)
        return JetLink(m3u8, headers={"Referer": f"https://{self.domains[0]}/", "Origin": f"https://{self.domains[0]}"}, inputstream=JetInputstreamFFmpegDirect.default())
