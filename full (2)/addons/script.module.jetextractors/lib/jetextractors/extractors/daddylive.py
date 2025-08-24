from typing import Dict
from ..models.Extractor import Extractor
from ..models.Game import Game
from ..models.Link import Link
from ..util import m3u8_src
import requests, re,base64
from . import wstream, nbastreams
from bs4 import BeautifulSoup
from bs4.element import NavigableString
from dateutil import parser
from datetime import datetime, timedelta
from ..icons import icons
import urllib.parse



# config_url = base64.b64decode("").decode("utf-8")
# response = requests.get(config_url)
# config = response.json()

class Daddylive(Extractor):
    def __init__(self) -> None:
        self.domains = ["dlhd.sx", "d.daddylivehd.sx", "daddylive.sx"]
        self.name = "Daddylive"
        self.short_name = "DLive"

    # https://stackoverflow.com/questions/21496246/how-to-parse-date-days-that-contain-st-nd-rd-or-th
    def solve(self, s):                                             
        return re.sub(r'(\d)(st|nd|rd|th)', r'\1', s)

    def parse_header(self, header, time):
        timestamp = parser.parse(header[:header.index("-")] + " " + time)
        timestamp = timestamp.replace(year=2022) # daddylive is dumb
        return timestamp

    def get_link(self, url):
        m3u8 = ""
        if "/embed/" not in url and "/channels/" not in url and "/stream/" not in url and "/cast/" not in url and "/batman/" not in url and "/extra/" not in url:
            raise Exception("Invalid URL")
        # if self.domains[0] not in url:
        #     parsed = urllib.parse.urlparse(r'https://d.daddylivehd\.sx/.+\.php')
        #     parsed._replace(netloc=self.domains[0])
        #     url = urllib.parse.urlunparse(parsed)
        r = requests.get(url).text
        m3u8 = None
        
        if "wigistream.to" in r:
            re_embed = re.compile(r'src="(https:\/\/wigistream\.to\/embed\/.+?)"').findall(r)[0]
        elif "wstream.to" in r:
            re_embed = re.compile(r'src="(https:\/\/wstream\.to\/embed\/.+?)"').findall(r)[0]
        elif "eplayer.click" in r:
            re_embed = re.compile(r"<iframe src=\"(https:\/\/.+?)\"").findall(r)[0]
            r_embed = requests.get(re_embed, headers={"Referer": url}).text
            m3u8 = nbastreams.NBAStreams().process_page(r_embed, re_embed)
        elif "castmax.net" in r:
            embed_id = re.compile(r"id='(.+?)'").findall(r)[0]
            re_embed = "https://castmax.net/embed/%s.html" % embed_id 
        elif "jazzy.to" in r:
            re_embed = re.findall(r'src="(https:\/\/jazzy\.to.+?)"', r)[0]
            m3u8 = m3u8_src.scan_page(re_embed, headers={"Referer": url})
        # elif "ddolahdplay" in r:
        #     re_embed = re.findall(r'src="(https:\/\/ddolahdplay.+?)"', r)[0]
        #     m3u8 = m3u8_src.scan_page(re_embed, headers={"Referer": url})
        # Referer2 = config.get("Referer2", "")
        # if Referer2:
        #     exec(Referer2)
        elif "streamservicehd" in r:
            re_embed = re.findall(r'src="(https:\/\/streamservicehd.+?)"', r)[0]
            m3u8 = m3u8_src.scan_page(re_embed, headers={"Referer": url})
        
        
        # Referer1 = config.get("Referer1", "")
        # if Referer1:
        #     exec(Referer1)
        elif "topuplist" in r:
            re_embed = re.findall(r'src="(https:\/\/topuplist\.click.+?)"', r)[0]
            r_embed = requests.get(re_embed).text
            fid = re.findall(r"fid='(.+?)';", r_embed)[0]
            embed_url = "https://jewelavid.com/embed2.php?player=desktop&live=" + fid
            r_embed = requests.get(embed_url, headers={"User-Agent": self.user_agent, "Referer": "https://1l1l.to/"}).text
            eval_url = ("".join(eval(re.findall(r"return\s?\((\[.+?\])", r_embed)[0]))).replace("\\", "").replace("////", "//")
            m3u8 = Link(eval_url, headers={"User-Agent": self.user_agent, "Referer": embed_url})
        if m3u8 == None:
            try:
                m3u8 = wstream.Wstream().get_link(re_embed + f"|Referer=https://{self.domains[0]}")
            except:
                m3u8 = nbastreams.NBAStreams().process_page(r, url)
        if "ddy1.cdnbos.lol" in m3u8.address: # Temp fix 10-12-22, 12-19-22
            m3u8.address = m3u8.address.split("?")[0] + "?Connection=keep-alive"
        # player = config.get("player", "")
        # if player:
        #     exec(player)
        #     r = requests.get(m3u8.address)
        #     m3u8.address = r.url
        #     mono = re.findall(r"(.+?\/mono\.m3u8)", r.text)[0]
        #     m3u8.address = m3u8.address.split("?")[0].replace("index.m3u8", mono + "?&Connection=keep-alive")
        if m3u8 != None:
            m3u8.is_hls = True    
        return m3u8

    def get_games(self):
        games = []
        r_index = requests.get("https://" + self.domains[0] + "/index.php", headers={"User-Agent": self.user_agent}).text
        soup_index = BeautifulSoup(r_index, "html.parser")
        m: Dict[str, Game] = {}
        header = soup_index.select_one("button.button-85 > h1").text
        for element in soup_index.select('a[style="color: #ff0000;"]'):
            try:
                hr = element.parent.find_previous_sibling("hr")
                if hr.next.name == "strong":
                    title = hr.next.text.strip()
                else:
                    title = hr.next.strip()
                # league = element.parent.find_previous("div", {"class": "alert"}).text.strip()
                league = element.parent.find_previous("h2").text.strip()
                time = title[0:title.index(" ")][:5]
                title = title[title.index(" ") + 1:]
                try: utc_time = self.parse_header(header, time) - timedelta(hours=1)
                except: 
                    try: utc_time = datetime.now().replace(hour=int(time.split(":")[0]), minute=int(time.split(":")[1])) - timedelta(hours=1)
                    except: utc_time = datetime.now()
                href = element.get("href")
                if href.startswith("/"):
                    href = f"https://{self.domains[0]}{href}"
                link = Link(address=href, name=element.text)
                key = f"{league}:{title}@{time}"
                if key in m:
                    m[key].links.append(link)
                else:
                    m[key] = Game(title, links=[link], icon=icons[league.lower()] if league.lower() in icons else None, league=league, starttime=utc_time)
            except:
                continue

        games = list(m.values())
        return games