###########################################
#     GIVE CREDIT WHERE CREDIT IS DUE     #
#                                         #
#      T4ILS AND JETJET                   #
###########################################



from typing import List, Callable, Tuple



from .util.find_iframes import find_iframes
from .util.keys import Keys
from .models.Extractor import Extractor
from concurrent.futures import ThreadPoolExecutor
from urllib.parse import urlparse
import re, time
from .models.Game import Game

from .models.Link import Link
from .models.ExtractorSearchProgress import ExtractorSearchProgress

def get_extractors() -> List[Extractor]:
    from . import extractors

    classes = Extractor.subclasses
    extractor_list = []
    for extractor in classes:
        extractor_list.append(extractor())
    return extractor_list

def get_extractor(name: str) -> Extractor:
    for extractor in get_extractors():
        if extractor.name == name:
            return extractor

def find_extractor(url: str) -> Extractor:
    url_domain = urlparse(url).netloc
    res = None
    for e in get_extractors():
        if not e.domains_regex:
            for domain in e.domains:
                if url_domain in domain:
                    res = e
                    break
        else:
            for domain in e.domains:
                if re.match(domain, url_domain) != None:
                    res = e
                    break
        if res != None: break
    return res

# (extractor, filter, callback)
def __get_games(t: Tuple[Extractor, Callable[[Game], bool], Callable[[int], None]]):
    start_time = time.time()
    e = t[0]
    f = t[1]
    try:
        games = list(filter(f, e.get_games()))
        for game in games:
            game.extractor = e.name
        t[2](len(games))
        return games
    except:
        t[2](0)
        return []

def search_extractors(query: str, exclude: List[str] = [], include: List[str] = [], progress: Callable[[ExtractorSearchProgress], None] = None) -> List[Link]:
    query = query.lower()
    res: List[Game] = []
    extractors = get_extractors()
    mods = []
    
    prog = ExtractorSearchProgress()
    def callback(c: int):
        prog.done += 1
        prog.links += c
        if progress != None:
            progress(prog)
    for e in extractors:
        if e.disabled: continue
        if e.name in exclude: continue
        if len(include) > 0 and e.name not in include: continue
        mods.append((e, lambda x: query in x.title.lower() or query in (x.league.lower() if x.league is not None else ""), callback))
    prog.total = len(mods)
    with ThreadPoolExecutor() as executor:
        results = executor.map(__get_games, mods)
        for result in results:
            res.extend(result)
    return res

def iframe_extractor(url: str) -> List[Link]:
    iframes = [Link(u) if not isinstance(u, Link) else u for u in find_iframes(url, "", [], [])]
    for iframe in iframes:
        if "|" in iframe.address and iframe.headers != {}:
            iframe.address = iframe.address.split("|")[0]
        if "?auth" in iframe.address and "premium" in iframe.address:
            iframe.address = iframe.address.split("?auth")[0]
    return iframes

def add_key(link: Link) -> Link:
    if "mlb.com" in link.address:
        key = Keys.get_key(Keys.mlb)
        link.headers = {}
        link.headers["User-Agent"] = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36"
        link.headers["Authorization"] = "Bearer " + key
    return link
