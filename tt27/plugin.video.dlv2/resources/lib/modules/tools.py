import xbmc
import xbmcvfs
import xbmcgui
import xbmcaddon
import xbmcplugin
import json
import sys
import requests
from bs4 import BeautifulSoup
from urllib.parse import quote_plus


class Myaddon:
    def __init__(self):
        self.addon = xbmcaddon.Addon()
        self.addon_info = self.addon.getAddonInfo
        self.addon_id = self.addon_info('id')
        self.addon_name = self.addon_info('name')
        self.addon_data = xbmcvfs.translatePath(self.addon_info('profile'))
        self.downloads_path = self.addon_data + 'downloads/'
        self.addon_path = xbmcvfs.translatePath(self.addon_info('path'))
        self.addon_icon = self.addon_info('icon')
        self.addon_fanart = self.addon_info('fanart')
        self.addon_version = self.addon_info('version')
        self.get_setting = self.addon.getSetting
        self.get_setting_bool = self.addon.getSettingBool
        self.set_setting = self.addon.setSetting
        self.lists_path = self.addon_path + 'lists/'
        self.cache_file = self.addon_data + 'cache.db'
        self.kodi_ver = float(xbmc.getInfoLabel("System.BuildVersion")[:4])
        self.user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36'
        self.headers = {"User-Agent": self.user_agent}
    
    def log(self, message: str):
        return xbmc.log(message, xbmc.LOGINFO)
    
    def color_text(self, color: str, txt: str):
        return(f'[B][COLOR {color}]{txt}[/COLOR][/B]')
    
    #---Request and Other Various Methods---#
    
    def get_page(self, page):
        if page.startswith('http'):
            return requests.get(page, headers=self.headers).text
        return None
    
    def write_html(self, file_path: str, url: str) -> None:
        response = requests.get(url).text
        soup = BeautifulSoup(response, features='html.parser')
        with open(file_path, 'w', encoding='utf-8', errors='ignore') as f:
            f.write(soup.prettify())
    
    def read_json(self, file_path: str):
        if not xbmcvfs.exists(file_path):
            self.write_json(file_path, {'items': []})
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            return json.loads(f.read())

    def write_json(self, file_path: str, items):
        with open(file_path, 'w', encoding='utf-8', errors='ignore') as f:
            f.write(json.dumps(items, indent=4))
    
    def create_directory(self, file_path: str):
        if not xbmcvfs.exists(file_path):
            xbmcvfs.mkdirs(file_path)
    
    def get_soup(self, url: str, referer: str = '') -> BeautifulSoup:
        if referer:
            self.headers['Referer'] = referer
        response = requests.get(url, headers=self.headers).text
        return BeautifulSoup(response, 'html.parser')
    
    def ok(self, message: str):
        dialog = xbmcgui.Dialog()
        return dialog.ok(self.addon_name, message)
    
    def textview(self, message: str, heading: str=""):
        if not heading:
            heading = self.addon_name
        dialog = xbmcgui.Dialog()
        return dialog.textviewer(heading, message)
    
    def get_multilink(self, lists, lists2=None, trailers=None):
        labels = []
        links = []
        counter = 1
        if lists2 is not None:
            for _list in lists2:
                lists.append(_list)
        for _list in lists:
            if type(_list) == list and len(_list) == 2:
                if len(lists) == 1:
                    return _list[1]
                labels.append(_list[0])
                links.append(_list[1])
            elif type(_list) == str:
                if len(lists) == 1:
                    return _list
                if _list.strip().endswith(')'):
                    labels.append(_list.split('(')[-1].replace(')', ''))
                    links.append(_list.rsplit('(')[0].strip())
                else:
                    labels.append('Link ' + str(counter))
                    links.append(_list)
            else:
                return
            counter += 1
        if trailers is not None:
            for name, link in trailers:
                labels.append(name)
                links.append(link)             
        dialog = xbmcgui.Dialog()
        ret = dialog.select('Choose a Link', labels)
        if ret == -1:
            return
        if type(lists[ret]) == str and lists[ret].endswith(')'):
            link = lists[ret].split('(')[0].strip()
            return link
        elif type(lists[ret]) == list:
            return lists[ret][1]
        return lists[ret]
  
    def from_keyboard(self, default_text='', header='Search'):
        kb = xbmc.Keyboard(default_text, header, False)
        kb.doModal()
        if (kb.isConfirmed()):
            return kb.getText()
        return None
    
    #---Add Directory Method---#

    def add_dir(self, name, url, mode, icon, fanart, description, name2 = '', page='', foldername='', context_menu=None, infolabels=None, cast=None, hls=False, media_type='', _id='', season_number='', episode_number='', isFolder=True, nolink=False):
        u=sys.argv[0]+'?name='+quote_plus(name)+'&url='+quote_plus(url)+'&mode='+str(mode)+'&icon='+quote_plus(icon) +'&fanart='+quote_plus(fanart)+'&description='+quote_plus(description)+'&name2='+quote_plus(name2)+'&page='+str(page)+'&foldername='+quote_plus(foldername)+'&mediatype='+quote_plus(media_type)+'&_id='+str(_id)+'&season_number='+str(season_number)+'&episode_number='+str(episode_number)
        liz=xbmcgui.ListItem(name)
        liz.setArt({'fanart': fanart, 'icon': icon, 'thumb': icon, 'poster': icon})
        if infolabels:
            liz.setInfo('video', infolabels)
        else:
            liz.setInfo('video', {'title': name, 'plot': description})
        if cast:
            liz.setCast(cast)
        if context_menu:
            liz.addContextMenuItems(context_menu)
        if hls is True:
            liz.setProperty('inputstream', 'inputstream.adaptive')
            liz.setProperty('inputstream.adaptive.manifest_type', 'hls')
            liz.setMimeType('application/vnd.apple.mpegurl')
            liz.setContentLookup(False) 
        if isFolder is False and nolink is False:
            liz.setProperty('IsPlayable', 'true')
        xbmcplugin.addDirectoryItem(handle=int(sys.argv[1]), url=u,listitem=liz, isFolder=isFolder)

m = Myaddon()