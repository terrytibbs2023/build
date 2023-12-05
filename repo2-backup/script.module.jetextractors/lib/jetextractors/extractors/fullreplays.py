from typing import List
from bs4 import BeautifulSoup as bs
from requests.sessions import Session
from ..models.Extractor import Extractor
from ..models.Game import Game
from ..models.Link import Link


class FullReplays(Extractor):
    domains = ["www.fullreplays.com"]
    name = "FullReplays"
    
    def __init__(self):
        self.base_url = f"https://{self.domains[0]}"
        self.user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36'
        self.headers = {
            'User-Agent': self.user_agent,
            'Referer': self.base_url
        }
        self.session = Session()
        self.session.headers = self.headers

    def get_games(self) -> List[Game]:
        return self.get_games_page(self.base_url)
    
    def get_games_page(self, page: str) -> List[Game]:
        games = [Game("Links may take several seconds to populate!")]
        response = self.session.get(page).text
        soup = (bs(response, 'html.parser'))
        row = soup.find(class_='row vlog-posts row-eq-height')
        for article in row.find_all('article'):
            title = article.h2.text
            link = article.a['href']
            thumbnail = article.a.img['src']
            games.append(Game(title, links=[Link(link, is_links=True)], icon=thumbnail))
        pagination = soup.find(class_='next page-numbers')
        if pagination:
            next_page = pagination['href']
            games.append(Game("[COLORyellow]Next Page[/COLOR]", page=next_page))
        return games
    
    def get_links(self, url: str) -> List[Link]:
        links = []
        response = self.session.get(url).text
        soup = bs(response, 'html.parser')
        sources = soup.find_all(class_='frc-sources-wrap')
        for source in sources:
            host = source.find(class_='frc-vid-label').text.lower()
            for button in source.find_all(class_='vlog-button'):
                title = f'{button.text.strip()} - {host.capitalize()}'
                link = button['data-sc']
                if 'fviplions' in link:
                    continue
                links.append(Link(link, name=title, is_resolveurl=True))
        return links
    