import sys
import re
import json
import base64
import traceback
from datetime import datetime, date
import time
from urllib.parse import quote_plus, unquote_plus, urljoin, urlparse
from typing import List, Optional, Dict
import xbmc
import xbmcgui
import xbmcplugin
import requests
from requests import Response
from bs4 import BeautifulSoup
from tzlocal import get_localzone
import pytz
from ..plugin import Plugin
from ..util.common import ownAddon
from ..modules.tools import m


class proxydt(datetime):

    @classmethod
    def strptime(cls, date_string, _format):
        return datetime(*(time.strptime(date_string, _format)[:6]))


datetime = proxydt


class Ddlv(Plugin):
    name = "Daddy"
    priority = 10
    
    def __init__(self):
        self.base_url = 'https://daddylive.dad'
        self.user_agent = 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36'
        self.schedule_url = urljoin(self.base_url, '/schedule/schedule-generated.php')
        self.channels_url = f'{self.base_url}/24-7-channels.php'
        self.addon_icon = ownAddon.getAddonInfo('icon')
        self.addon_fanart = ownAddon.getAddonInfo('fanart')
    
    def get(self, url: str, referer: str='') -> Response:
        headers = {"User-Agent": self.user_agent, "Referer": f'{self.base_url}/', "Origin": f'{self.base_url}/'}
        if referer:
            headers['Referer'] = headers['Origin'] = referer
        try:
            return requests.get(url, headers=headers, timeout=10)
        except:
            return requests.get(url, headers=headers, timeout=10, verify=False)
        
    def get_list(self, url: str) -> Optional[Dict]:
        if not url.startswith('ddlv'):
            return
            
        if url.startswith('ddlv/channels'):
            return self.get(self.channels_url).text
            
        if url == 'ddlv':
            response = self.get(self.schedule_url)
            schedule = response.json()
            return json.dumps(schedule)
        elif url.startswith('ddlv/cats/'):
            return unquote_plus(url.replace('ddlv/cats/', ''))
        elif url.startswith('ddlv/events/'):
            return unquote_plus(url.replace('ddlv/events/', ''))
    
    
    def parse_list(self, url: str, response: str) -> Optional[List[Dict[str, str]]]:
        if not url.startswith('ddlv'):
            return
            
        itemlist = []
        title = ''
        link = ''
        
        if url == 'ddlv/channels':
            password = m.get_setting('adult_pw')
            soup = BeautifulSoup(response, 'html.parser')
            channels = []
            for a in soup.find_all('a')[8:]:
                title = a.text
                link = json.dumps([[title, f"{self.base_url}{a['href'].replace('/stream/', '/cast/')}"]])
                if '18+' in title and password != 'xxXXxx':
                    continue
                if not link in channels:
                    channels.append(link)
                    itemlist.append(
                        {
                            'type': 'item',
                            'title': title,
                            'link': link,
                            'summary': title
                        }
                    )
            return itemlist
            
        response = json.loads(response)
        
        if url.startswith('ddlv/events/'):
            for event in response:
                title = event.get('event', '')
                start_time = event.get('time', '')
                try:
                    title = f'{self.convert_utc_time_to_local(start_time)} - {title}' if start_time else title
                except:
                    title = f'{start_time} - {title}' if start_time else title
                    
                all_channels = []
                channels = event.get('channels')
                for channel in channels:
                    if isinstance(channel, dict):
                        all_channels.append([channel.get('channel_name'), urljoin(self.base_url, f"/cast/stream-{channel.get('channel_id')}.php")])
                channels2 = event.get('channels2')
                for channel in channels2:
                    if isinstance(channel, dict):
                        all_channels.append([channel.get('channel_name'), urljoin(self.base_url, f"/cast/bet.php?id=bet{channel.get('channel_id')}")])
                    
                link = json.dumps(all_channels)
                itemlist.append(
                    {
                        'type': 'item',
                        'title': title,
                        'link': link,
                        'summary': title
                    }
                )
            return itemlist
        
        itemlist.append(
            {
                'type': 'dir',
                'title': 'Channels',
                'link': 'ddlv/channels',
                'summary': title
            }
        )
        
        for key in response.keys():
            if url == 'ddlv':
                title = key.split(' -')[0]
                link = f'ddlv/cats/{quote_plus(json.dumps(response[key]))}'
            elif url.startswith('ddlv/cats/'):
                title = key.rstrip('</span>')
                link = f'ddlv/events/{quote_plus(json.dumps(response[key]))}'
                
            itemlist.append(
                {
                    'type': 'dir',
                    'title': title,
                    'link': link,
                    'summary': title
                }
            )
        return itemlist


    def play_video(self, item: str) -> Optional[bool]:
        if not self.base_url in str(item):
            return
            
        url = json.loads(item['link'])
        title = item['title']
        thumbnail = m.addon_icon
        if isinstance(url, list):
            if len(url) > 1:
                url = self.get_multilink(url)
                if not url:
                    sys.exit()
            else:
                url = url[0][1]
        try:
            response = self.get(url)
            soup = BeautifulSoup(response.text, 'html.parser')
            iframe = soup.find('iframe', attrs={'id': 'thatframe'})
            if iframe is None:
                url = url.replace('/cast/', '/stream/')
                response = self.get(url)
                soup = BeautifulSoup(response.text, 'html.parser')
                iframe = soup.find('iframe', attrs={'id': 'thatframe'})
            url2 = iframe['src']
            
            
            if 'wikisport.best' in url2:
                print(url2)
                
                match =  re.search(r'/.+?(\d+)\.php', url2)
                url3 = f"https://stellarthread.com/wiki.php?player=mobile&live=t{match.group(1)}"
                response = self.get(url3, referer=url2)
                match = re.search(r'return\((\[.*?\])\.join', response.text, re.S)
                raw_list = match.group(1)
                elements = json.loads(raw_list)
                m3u8 = ''.join(elements).replace('////', '//')
                m3u8 = f'{m3u8}|Referer=https://stellarthread.com&Origin=https://stellarthread.com&User-Agent={self.user_agent}'
                
            else:
                response = self.get(url2)
                channel_key = re.search(r'const\s+CHANNEL_KEY\s*=\s*"([^"]+)"', response.text).group(1)
                bundle = re.search(r'const\s+XJZ\s*=\s*"([^"]+)"', response.text).group(1)
                parts = json.loads(base64.b64decode(bundle).decode("utf-8"))
                for k, v in parts.items():
                    parts[k] = base64.b64decode(v).decode("utf-8")
                bx = [40, 60, 61, 33, 103, 57, 33, 57]
                sc = ''.join(chr(b ^ 73) for b in bx)
                host = "https://top2new.newkso.ru/"
                auth_url = (
                    f'{host}{sc}'
                    f'?channel_id={quote_plus(channel_key)}&'
                    f'ts={quote_plus(parts["b_ts"])}&'
                    f'rnd={quote_plus(parts["b_rnd"])}&'
                    f'sig={quote_plus(parts["b_sig"])}'
                )
                self.get(auth_url, referer=url2)
                
                server_lookup_url = f"https://{urlparse(url2).netloc}/server_lookup.php?channel_id={channel_key}"
                response = self.get(server_lookup_url, referer=url2).json()
                server_key = response['server_key']
                if server_key == "top1/cdn":
                    m3u8 = f"https://top1.newkso.ru/top1/cdn/{channel_key}/mono.m3u8"
                else:
                    m3u8 = f"https://{server_key}new.newkso.ru/{server_key}/{channel_key}/mono.m3u8"
                
                referer = f'https://{urlparse(url2).netloc}'
                m3u8 = f'{m3u8}|Referer={referer}/&Origin={referer}&Connection=Keep-Alive&User-Agent={self.user_agent}'
            
            liz = xbmcgui.ListItem(title, path=m3u8)
            liz.setInfo('video', {'plot': title})
            liz.setArt({'icon': thumbnail, 'thumb': thumbnail, 'poster': thumbnail})
            liz.setProperty('inputstream', 'inputstream.ffmpegdirect')
            liz.setMimeType('application/x-mpegURL')
            liz.setProperty('inputstream.ffmpegdirect.is_realtime_stream', 'true')
            liz.setProperty('inputstream.ffmpegdirect.stre    am_mode', 'timeshift')
            liz.setProperty('inputstream.ffmpegdirect.manifest_type', 'hls')
            
            xbmcplugin.setResolvedUrl(int(sys.argv[1]), True, liz)
            xbmc.Player().play(m3u8, listitem=liz)
            return True
        except Exception:
            m.ok(f'Error loading stream:\n{traceback.format_exc()}')
    
    def get_multilink(self, lists, lists2=None, trailers=None):
        labels = []
        links = []
        counter = 1
        if lists2 is not None:
            for _list in lists2:
                lists.append(_list)
        for _list in lists:
            if isinstance(_list, list) and len(_list) == 2:
                if len(lists) == 1:
                    return _list[1]
                labels.append(_list[0])
                links.append(_list[1])
            elif isinstance(_list, str):
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
        if isinstance(lists[ret], str) and lists[ret].endswith(')'):
            link = lists[ret].split('(')[0].strip()
            return link
        elif isinstance(lists[ret], list):
            return lists[ret][1]
        return lists[ret]
    
    def convert_utc_time_to_local(self, utc_time_str):
        today = date.today()
        datetime_str = f"{today} {utc_time_str}"
        utc_datetime = datetime.strptime(datetime_str, "%Y-%m-%d %H:%M")
        utc_datetime = utc_datetime.replace(tzinfo=pytz.utc)
        local_tz = get_localzone()
        local_time = utc_datetime.astimezone(local_tz)
        return local_time.strftime("%I:%M %p").lstrip('0')
    