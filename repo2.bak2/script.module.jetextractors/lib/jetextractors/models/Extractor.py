from typing import List
from .Game import Game
from .Link import Link
from .. import config

class Extractor:
    user_agent: str = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36"
    domains: List[str] = []
    domains_regex: bool = False
    name: str = None
    short_name: str = None
    shortener: bool = False
    subclasses = []
    disabled = False

    def __init_subclass__(cls, **kwargs) -> None:
        super().__init_subclass__(**kwargs)
        cls.subclasses.append(cls)

    def get_games(self) -> List[Game]:
        return []
    
    def get_games_page(self, page) -> List[Game]:
        return []
    
    def get_link(self, url: str) -> Link:
        if ".m3u8" in url or url.startswith("direct://"):
            return url
        return None
    
    def get_links(self, url: str) -> List[Link]:
        return []
    
    def get_config(self) -> dict:
        return config.get_config()
