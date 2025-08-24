# -*- coding: utf-8 -*-


import re

from homelanderscrapers import parse_qs, urljoin, urlencode, quote_plus, unquote_plus
from homelanderscrapers.modules import cleantitle
from homelanderscrapers.modules import client
from homelanderscrapers.modules import debrid
from homelanderscrapers.modules import source_utils
from homelanderscrapers.modules import workers
from homelanderscrapers.modules import log_utils

from homelanderscrapers import custom_base_link
custom_base = custom_base_link(__name__)


class source:
    def __init__(self):
        self.priority = 0
        self.language = ['en']
        self.domain = ['torlock.com']
        self.base_link = 'https://torlock.com'
        self.search_link = '/all/torrents/%s.html?'


    def movie(self, imdb, title, localtitle, aliases, year):
        try:
            url = {'imdb': imdb, 'title': title, 'year': year}
            url = urlencode(url)
            return url
        except:
            return


    def tvshow(self, imdb, tvdb, tvshowtitle, localtvshowtitle, aliases, year):
        try:
            url = {'imdb': imdb, 'tvdb': tvdb, 'tvshowtitle': tvshowtitle, 'year': year}
            url = urlencode(url)
            return url
        except:
            return


    def episode(self, url, imdb, tvdb, title, premiered, season, episode):
        try:
            if url is None:
                return
            url = parse_qs(url)
            url = dict([(i, url[i][0]) if url[i] else (i, '') for i in url])
            url['title'], url['premiered'], url['season'], url['episode'] = title, premiered, season, episode
            url = urlencode(url)
            return url
        except:
            return


    def sources(self, url, hostDict, hostprDict):
        self.sources = []
        try:
            if url is None:
                return self.sources

            if debrid.status() is False:
                return self.sources

            data = parse_qs(url)
            data = dict([(i, data[i][0]) if data[i] else (i, '') for i in data])

            self.title = data['tvshowtitle'] if 'tvshowtitle' in data else data['title']
            self.title = self.title.replace('&', 'and').replace('Special Victims Unit', 'SVU')

            self.hdlr = 'S%02dE%02d' % (int(data['season']), int(data['episode'])) if 'tvshowtitle' in data else data['year']
            self.year = data['year']

            query = '%s %s' % (self.title, self.hdlr)
            query = re.sub('(\\\|/| -|:|;|\*|\?|"|\'|<|>|\|)', '', query)

            url = self.search_link % quote_plus(query)
            url = urljoin(self.base_link, url)
            # log_utils.log('url = %s' % url, log_utils.LOGDEBUG)

            try:
                r = client.request(url)
                links = re.findall('<a href=(/torrent/.+?)>', r, re.DOTALL)
                # log_utils.log('links = %s' % str(links), log_utils.LOGDEBUG)

                threads = []
                for link in links:
                    threads.append(workers.Thread(self.get_sources, link))
                [i.start() for i in threads]
                [i.join() for i in threads]
                return self.sources
            except:
                source_utils.scraper_error('ETTV')
                return self.sources

        except:
            source_utils.scraper_error('ETTV')
            return self.sources


    def get_sources(self, link):
        try:
            url = '%s%s' % (self.base_link, link)
            result = client.request(url)
            if 'magnet' not in result:
                raise Exception()

            url = 'magnet:%s' % (re.findall('a href="magnet:(.+?)"', result, re.DOTALL)[0])
            try: url = unquote(url).decode('utf8').replace('&amp;', '&')
            except: pass
            url = url.split('&tr=')[0]
            # log_utils.log('url = %s' % url, log_utils.LOGDEBUG)

            if url in str(self.sources):
                raise Exception()

            size_list = re.findall('<dt>SIZE</dt><dd>(.+?)<', result, re.DOTALL)

            if any(x in url.lower() for x in ['french', 'italian', 'spanish', 'truefrench', 'dublado', 'dubbed']):
                raise Exception()

            name = url.split('&dn=')[1]
            t = name.split(self.hdlr)[0].replace(self.year, '').replace('(', '').replace(')', '').replace('&', 'and').replace('+', ' ')

            if cleantitle.get(t) != cleantitle.get(self.title):
                raise Exception()

            if self.hdlr not in name:
                raise Exception()

            quality, info = source_utils.get_release_quality(name, url)

            for match in size_list:
                try:
                    size = re.findall('((?:\d+\,\d+\.\d+|\d+\.\d+|\d+\,\d+|\d+)\s*(?:GiB|MiB|GB|MB))', match)[0]
                    div = 1 if size.endswith('GB') else 1024
                    size = float(re.sub('[^0-9|/.|/,]', '', size.replace(',', '.'))) / div
                    size = '%.2f GB' % size
                    info.insert(0, size)
                    if size:
                        break
                except:
                    size = '0'
                    pass

            info = ' | '.join(info)

            self.sources.append({'source': 'torrent', 'quality': quality, 'language': 'en', 'url': url,
                                                'info': info, 'direct': False, 'debridonly': True, 'name': name})

        except:
            pass

    def resolve(self, url):
        return url
