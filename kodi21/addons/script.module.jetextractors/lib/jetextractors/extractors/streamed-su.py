from typing import List
import requests, re, random
from bs4 import BeautifulSoup
from dateutil.parser import parse
from datetime import timedelta, datetime

from ..util import find_iframes

from ..models.Extractor import Extractor
from ..models.Game import Game
from ..models.Link import Link
categories = ["basketball","american-football","baseball","motor-sports","rugby","cricket","afl","football",
              "hockey","fight","tennis","golf","darts","other"]

class Streamedsu(Extractor):
    def __init__(self) -> None:
        self.domains = ["streamed.su"]
        self.categories = categories
        self.name = "Streamedsu"
        # self.short_name = ""



    def get_games(self):
        games = []
        for category in self.categories:
            category_url = f"https://{self.domains[0]}/category/{category}"
            r = requests.get(category_url)

            soup = BeautifulSoup(r.text, "html.parser")
            target = soup.find('div', class_='w-full md:w-1/2 !w-full')

            if target:
                for a in target.find_all('a'):
                    h1 = a.find('h1')
                   
                    if h1:
                        title = h1.get('title', '')
                        href = a.get('href', '')
                        if href.startswith("/"):
                            href = f"https://{self.domains[0]}" + href
                        time_div_1 = a.find('div', class_='font-bold text-red-500')
                        time_1 = time_div_1.text.strip() if time_div_1 else None 

                       
                        if not time_1:
                            time_div_2 = a.find('div', class_='')
                            time_2 = time_div_2.text.strip() if time_div_2 else None 
                        else:
                            time_2 = None  

                        
                        if time_1 or time_2:
                            time = time_1 if time_1 else time_2
                            combined_title = f"{time}  {title}"
                        else:
                            combined_title = title
                        utc_time = None
                        if time != "":
                            try:
                                utc_time = parse(time) + timedelta(hours=0)
                            except:
                                try:
                                    utc_time1 = datetime.strptime(time, "%H:%M %p ET - %m/%d/%Y") + timedelta(hours=0)
                                except:
                                    pass
                         

                        league = category
                        if league is "basketball":league = "nba"
                        if league is "american-football":league = "nfl"
                        if league is "baseball":league = "mlb"
                        if league is "hockey":league = "nhl"
                        if league is "football":league = "soccer"
                            
                        combined_title = f"  {title}" if time else title
                        # utc_time1="[COLORblue]"+utc_time+"[/COLOR]"
                        games.append(Game(league=league.upper(),title=combined_title, links=[Link(address=href, is_links=True)], starttime=utc_time))

        return games

    def get_links(self, url: str):
        links = []
        r = requests.get(url).text
        soup = BeautifulSoup(r, "html.parser")
        for link in soup.select("div.w-full > a"):
            parts = link.get("href").split("/")
            rand = random.randint(1, 3)
            links.append(Link(f"https://inst{rand}.ignores.top/js/{parts[2]}/{parts[3]}/playlist.m3u8", is_direct=True, headers={"Referer": "https://vipstreams.in/", "Origin": "https://vipstreams.in"}))
        return links
