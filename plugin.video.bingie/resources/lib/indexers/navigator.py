import xbmcplugin, xbmcgui, sys, urllib.parse
from resources.lib.modules import control

class navigator:
    def __init__(self):
        self.handle = int(sys.argv[1])

    def add(self, params, label, icon='default.png'):
        url = sys.argv[0] + '?' + urllib.parse.urlencode(params)
        li = xbmcgui.ListItem(label=label)
        li.setArt({'icon': icon, 'thumb': icon})
        xbmcplugin.addDirectoryItem(handle=self.handle, url=url, listitem=li, isFolder=True)

    def end_directory(self):
        xbmcplugin.endOfDirectory(self.handle)

    def root(self):
        self.add({'mode': 'navigator.movies'}, 'Movies', 'icon_movies.png')
        self.add({'mode': 'navigator.tvshows'}, 'TV Shows', 'icon_tv.png')
        self.add({'mode': 'navigator.search'}, 'Search', 'icon_search.png')
        self.end_directory()

    def movies(self):
        self.add({'mode': 'movie_folder'}, 'Popular Movies', 'icon_movies.png')
        self.add({'mode': 'movie_debrid'}, 'Debrid Movies', 'icon_movies.png')
        self.end_directory()

    def tvshows(self):
        self.add({'mode': 'tv_folder'}, 'Popular TV Shows', 'icon_tv.png')
        self.add({'mode': 'tv_debrid'}, 'Debrid TV Shows', 'icon_tv.png')
        self.end_directory()

    def search(self):
        self.add({'mode': 'search_movies'}, 'Search Movies', 'icon_search.png')
        self.add({'mode': 'search_tvshows'}, 'Search TV Shows', 'icon_search.png')
        self.end_directory()

