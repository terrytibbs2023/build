import urllib,xbmcplugin,xbmcgui,xbmcaddon,xbmcvfs,traceback,os,time,_Edit,re,requests,base64,sys,xbmc,random,string,hashlib,resolveurl
from bs4 import BeautifulSoup
from xml.etree.ElementTree import ElementTree
import urllib.parse
import urllib.request

import base64
import urllib.parse as urllib_parse

try:
    import json
except:
    import simplejson as json
  
resolve_url=[]
g_ignoreSetResolved=['matchid:']

class NoRedirection(urllib.request.HTTPErrorProcessor):
   def http_response(self, request, response):
       return response
   https_response = http_response


AddonID   = 'plugin.video.Rising.Tides'
addon = _Edit.addon
addon_version = addon.getAddonInfo('version')
profile = xbmcvfs.translatePath(addon.getAddonInfo('profile'))
fanart = xbmcvfs.translatePath(os.path.join('special://home/addons/' + AddonID , 'fanart.jpg'))        
icon = xbmcvfs.translatePath(os.path.join('special://home/addons/' + AddonID, 'icon.png'))
artpath = xbmcvfs.translatePath(os.path.join('special://home/addons/' + AddonID + '/resources/art/'))
thumbpath = xbmcvfs.translatePath(os.path.join('special://home/addons/' + AddonID + '/resources/thumbs/'))
dialog1 = xbmcgui.Dialog()      
selfAddon = xbmcaddon.Addon(id=AddonID)
home = xbmcvfs.translatePath(addon.getAddonInfo('path'))
favorites = os.path.join(profile, 'favorites')
history = os.path.join(profile, 'history')
REV = os.path.join(profile, 'list_revision')
icon = os.path.join(home, 'icon.png')
FANART = os.path.join(home, 'fanart.jpg')
source_file = os.path.join(profile, 'source_file')
functions_dir = profile
debug = 'true' #addon.getSetting('debug')
if os.path.exists(favorites)==True:
    FAV = open(favorites).read()
else: FAV = []
if os.path.exists(source_file)==True:
    SOURCES = open(source_file).read()
else: SOURCES = []


def addon_log(string):
    if debug == 'true':
        xbmc.log("[addon.live.RisingTides Lists-%s]: %s" %(addon_version, string))

class SafeString(str):
    def title(self):
        return self

    def capitalize(self):
        return self

def OPEN_URL(url):
    req.add_header('User-Agent', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.0.3) Gecko/2008092417 Firefox/3.0.3')
    response = requests.get(url)
    link=response.text
    return link

def scrape():
    html = OPEN_URL('https://soccerhighlightshd.com/')
    r='<a alt="(.+?)" .+? data-src="(.+?)" .+? href="(.+?)">'
    match = re.compile ( r , re.DOTALL).findall (html)
    for name,image,url in match:
        addDir1('[B][COLOR white]%s[/COLOR][/B]'%name,url,34,image,FANART,'')

def HIGHLIGHTS_LINKS(name,url):
    xbmc.log('GETLINKS: %s'%url)
    links=OPEN_URL(url)
    links= links.split("<div style='width:100%;height:0px;position:relative;padding-bottom:56.250%;margin-bottom:30px'>")
    xbmc.log('LINK LEN: %s'%len(links))
    for link in links:
        r = '<iframe src="(.+?)"'
        match = re.compile(r,re.DOTALL).findall(link)
        for url in match:
            if'veuclips' in url:
                url=url.replace('goal91','player')
                addDir1(name,url,36,'','','' )
            if'ok.ru' in url:
                addDir1(name,url,65,'','','' )
            else:
                addDir1(name,url,36,'','','' )

def PLAYLINKS(name,url,iconimage):
        ok=True
        liz=xbmcgui.ListItem(name); liz.setInfo( type="Video", infoLabels={ "Title": name } )
        liz.setArt({'icon':iconimage,'thumb':iconimage})

        ok=xbmcplugin.addDirectoryItem(handle=int(sys.argv[1]),url=url,listitem=liz)
        liz.setPath(url)
        xbmcplugin.setResolvedUrl(int(sys.argv[1]), True, liz)

def CHECKLINKS(name,url,iconimage):
        if resolveurl.HostedMediaFile(url).valid_url():
            url = resolveurl.HostedMediaFile(url).resolve()     
            PLAYLINKS(name,url,iconimage)
        elif liveresolver.isValid(url)==True:
            url=liveresolver.resolve(url)
            PLAYLINKS(name,url,iconimage)
        else:
            PLAYLINKS(name,url,iconimage)
       
def PLAYSTREAM(name,url,iconimage):
        link=resolveurl.resolve(str(url))
        resolve(name,link)
        if (xbmc.Player().isPlaying() == 0):
            quit()
        else:
            return
    
def resolve(name,url):
    if 'm3u8' in url or 'mp4' in url:
        xbmc.Player().play(url,xbmcgui.ListItem(name))

def makeRequest(url, headers=None):
        try:
            if headers is None:
                headers = {'User-agent' : 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:19.0) Gecko/20100101 Firefox/19.0'}
            req = requests.get(url,headers=headers)
            data = req.text
            data = data.replace("<link>.<link>","<link>http://Ignoreme</link>")
            data = data.replace("<link","<url").replace("</link","</url")
            return data
        except Exception as e:
            addon_log('URL: '+url)
            if hasattr(e, 'code'):
                addon_log('We failed with error code - %s.' % e.code)
                xbmc.executebuiltin("XBMC.Notification(RisingTides,We failed with error code - "+str(e.code)+",10000,"+icon+")")
            elif hasattr(e, 'reason'):
                addon_log('We failed to reach a server.')
                addon_log('Reason: %s' %e.reason)
                xbmc.executebuiltin("XBMC.Notification(RisingTides,We failed to reach a server. - "+str(e.reason)+",10000,"+icon+")")

               
def SKindex():
    addon_log("SKindex")
    getData(_Edit.MainBase,'')
    xbmcplugin.endOfDirectory(int(sys.argv[1]))

def play(url,name,pdialogue=None):
        from resources.root import resolvers
        import xbmcgui
        
        url = url.strip()

        url = resolvers.resolve(url)

        if url.endswith('m3u8'):
            from resources.root import iptv
            iptv.listm3u(url)
        else:
            liz = xbmcgui.ListItem(name)
            liz.setArt({'icon':iconimage,'thumb':iconimage})

            liz.setInfo(type='Video', infoLabels={'Title':name})
            liz.setProperty("IsPlayable","true")
            liz.setPath(url)
            
            if url.endswith('.ts'):
                url = 'plugin://plugin.video.f4mTester/?url='+urllib.parse.quote_plus(url)+'&amp;streamtype=SIMPLE'
            elif url.endswith('.m3u8'):
                url = 'plugin://plugin.video.f4mTester/?url='+urllib.parse.quote_plus(url)+'&amp;streamtype=HLS'
            elif url.endswith('.f4m'):
                url = 'plugin://plugin.video.f4mTester/?url='+urllib.parse.quote_plus(url)

            '''
            elif '.mpegts' in i.string:                                         
                f4m = 'plugin://plugin.video.f4mTester/?url='+urllib.parse.quote_plus(i.string)+'&amp;streamtype=TSDOWNLOADER'
            '''
            if url.lower().startswith('plugin') and 'youtube' not in  url.lower():
                from resources.modules import CustomPlayer
                xbmc.executebuiltin('XBMC.PlayMedia('+url+')') 
                player = CustomPlayer.MyXBMCPlayer()
                if (xbmc.Player().isPlaying() == 0):
                    quit()
                try:
                   
                        if player.urlplayed:
                            print('yes played')
                            return
                        if time.time()-beforestart>4: return False
                except: pass

                print('returning now')
                return False

            from resources.modules import  CustomPlayer
            import time

            player = CustomPlayer.MyXBMCPlayer()
            player.pdialogue=pdialogue
            start = time.time() 
            print('going to play')
            import time
            beforestart=time.time()
            player.play( url, liz)
            if (xbmc.Player().isPlaying() == 0):
                quit()
            try:
                while player.is_active:
                    xbmc.sleep(400)
                   
                    if player.urlplayed:
                        print('yes played')
                        return
                    if time.time()-beforestart>4: return False
            except: pass
            print('not played',url)
            xbmc.Player().stop()
            return

def regex_from_to(text, from_string, to_string, excluding=True):
    import re,string
    if excluding:
        try: r = re.search("(?i)" + from_string + "([\S\s]+?)" + to_string, text).group(1)
        except: r = ''
    else:
        try: r = re.search("(?i)(" + from_string + "[\S\s]+?" + to_string + ")", text).group(1)
        except: r = ''
    return r

def regex_get_all(text, start_with, end_with):
    import re,string
    r = re.findall("(?i)(" + start_with + "[\S\s]+?" + end_with + ")", text)
    return r

logfile    = xbmcvfs.translatePath(os.path.join('special://home/addons/plugin.video.Rising.Tides', 'log.txt'))


def getSources():
        if os.path.exists(favorites) == True:
            addDir('Favorites','url',4,os.path.join(home, 'resources', 'favorite.png'),FANART,'','','','')
        if addon.getSetting("browse_xml_database") == "true":
            addDir('XML Database','http://xbmcplus.xb.funpic.de/www-data/filesystem/',15,icon,FANART,'','','','')
        if addon.getSetting("browse_community") == "true":
            addDir('Community Files','community_files',16,icon,FANART,'','','','')
        if os.path.exists(history) == True:
            addDir('Search History','history',25,os.path.join(home, 'resources', 'favorite.png'),FANART,'','','','')
        if addon.getSetting("searchyt") == "true":
            addDir('Search:Youtube','youtube',25,icon,FANART,'','','','')
        if addon.getSetting("searchDM") == "true":
            addDir('Search:dailymotion','dmotion',25,icon,FANART,'','','','')
        if addon.getSetting("PulsarM") == "true":
            addDir('Pulsar:IMDB','IMDBidplay',27,icon,FANART,'','','','')            
        if os.path.exists(source_file)==True:
            sources = json.loads(open(source_file,"r").read())
            if len(sources) > 1:
                for i in sources:
                    if isinstance(i, list):
                        addDir(i[0].encode('utf-8'),i[1].encode('utf-8'),1,icon,FANART,'','','','','source')
                    else:
                        thumb = icon
                        fanart = FANART
                        desc = ''
                        date = ''
                        credits = ''
                        genre = ''
                        if i.has_key('thumbnail'):
                            thumb = i['thumbnail']
                        if i.has_key('fanart'):
                            fanart = i['fanart']
                        if i.has_key('description'):
                            desc = i['description']
                        if i.has_key('date'):
                            date = i['date']
                        if i.has_key('genre'):
                            genre = i['genre']
                        if i.has_key('credits'):
                            credits = i['credits']
                        addDir(i['title'].encode('utf-8'),i['url'].encode('utf-8'),1,thumb,fanart,desc,genre,date,credits,'source')

            else:
                if len(sources) == 1:
                    if isinstance(sources[0], list):
                        getData(sources[0][1].encode('utf-8'),FANART)
                    else:
                        getData(sources[0]['url'], sources[0]['fanart'])

def getSoup(url,data=None):
        if url != None :
            if url.startswith('http://') or url.startswith('https://'):
                data = makeRequest(url)
                if re.search("#EXTM3U",data) or 'm3u' in url: 
                    print('found m3u data',data)
                    return data
                
        elif data == None:
            if xbmcvfs.exists(url):
                if url.startswith("smb://") or url.startswith("nfs://"):
                    copy = xbmcvfs.copy(url, os.path.join(profile, 'temp', 'sorce_temp.txt'))
                    if copy:
                        data = open(os.path.join(profile, 'temp', 'sorce_temp.txt'), "r").read()
                        xbmcvfs.delete(os.path.join(profile, 'temp', 'sorce_temp.txt'))
                    else:
                        addon_log("failed to copy from smb:")
                else:
                    data = open(url, 'r').read()
                    if re.match("#EXTM3U",data)or 'm3u' in url: 
                        return data
            else:
                addon_log("Soup Data not found!")
                return
        return BeautifulSoup(data)

def getData(url,fanart):
    if str(url).startswith('plugin://'):
        try:
            parsed = urllib_parse.urlparse(url)
            params = dict(urllib_parse.parse_qsl(parsed.query))
            inner_url  = urllib_parse.unquote_plus(params.get('url', ''))
            inner_mode = params.get('mode', '')
            if inner_mode == '60':
                getPPVCategories(fanart)
                return
            elif inner_mode == '61':
                getPPVStreams(inner_url, fanart)
                return
            elif inner_mode == '62':
                getPPVCategories(fanart)
                return
            elif inner_mode == '64':
                getCDNChannels(inner_url, fanart)
                return
        except Exception as e:
            xbmc.log(f'[getData] plugin:// dispatch error: {e}', xbmc.LOGERROR)
        return

    SetViewLayout = "List"
     
    soup = getSoup(url)
    
    if isinstance(soup,BeautifulSoup):
        if len(soup('layoutype')) > 0:
            SetViewLayout = "Thumbnail"         

        if len(soup('channels')) > 0:
            channels = soup('channel')
            for channel in channels:

                linkedUrl=''
                lcount=0
                try:
                    linkedUrl =  channel('externallink')[0].string
                    lcount=len(channel('externallink'))
                except: pass
                if lcount>1: linkedUrl=''

                name = channel('name')[0].string
                thumbnail = channel('thumbnail')[0].string
                if thumbnail == None:
                    thumbnail = ''

                try:
                    if not channel('fanart'):
                        if addon.getSetting('use_thumb') == "true":
                            fanArt = thumbnail
                        else:
                            fanArt = fanart
                    else:
                        fanArt = channel('fanart')[0].string
                    if fanArt == None:
                        raise
                except:
                    fanArt = fanart

                try:
                    desc = channel('info')[0].string
                    if desc == None:
                        raise
                except:
                    desc = ''

                try:
                    genre = channel('genre')[0].string
                    if genre == None:
                        raise
                except:
                    genre = ''

                try:
                    date = channel('date')[0].string
                    if date == None:
                        raise
                except:
                    date = ''

                try:
                    credits = channel('credits')[0].string
                    if credits == None:
                        raise
                except:
                    credits = ''

                try:
                    if linkedUrl=='':
                        addDir(name.encode('utf-8', 'ignore'),url.encode('utf-8'),2,thumbnail,fanArt,desc,genre,date,credits,True)
                    else:
                        addDir(name.encode('utf-8'),linkedUrl.encode('utf-8'),1,thumbnail,fanArt,desc,genre,date,None,'source')
                except:
                    addon_log('There was a problem adding directory from getData(): '+name.encode('utf-8', 'ignore'))
        else:
            addon_log('No Channels: getItems')
            getItems(soup('item'),fanart)
    else:
        parse_m3u(soup)

    if SetViewLayout == "Thumbnail":
       SetViewThumbnail()

def parse_m3u(data):
    content = data.rstrip()
    match = re.compile(r'#EXTINF:(.+?),(.*?)[\n\r]+([^\n]+)').findall(content)
    total = len(match)
    print( 'total m3u links',total)
    for other,channel_name,stream_url in match:
        if 'tvg-logo' in other:
            thumbnail = re_me(other,'tvg-logo=[\'"](.*?)[\'"]')
            if thumbnail:
                if thumbnail.startswith('http'):
                    thumbnail = thumbnail
                
                elif not addon.getSetting('logo-folderPath') == "":
                    logo_url = addon.getSetting('logo-folderPath')
                    thumbnail = logo_url + thumbnail

                else:
                    thumbnail = thumbnail            
        else:
            thumbnail = ''
        if 'type' in other:
            mode_type = re_me(other,'type=[\'"](.*?)[\'"]')
            if mode_type == 'yt-dl':
                stream_url = stream_url +"&mode=18"
            elif mode_type == 'regex':
                url = stream_url.split('&regexs=')
                regexs = parse_regex(getSoup('',data=url[1]))
                
                addLink(url[0], channel_name,thumbnail,'','','','','',None,regexs,total)
                continue
        addLink(stream_url, channel_name,thumbnail,'','','','','',None,'',total)
        
    xbmc.executebuiltin("Container.SetViewMode(50)")
    
def getChannelItems(name,url,fanart):
        soup = getSoup(url)
        channel_list = soup.find('channel', attrs={'name' : name.decode('utf-8')})
        items = channel_list('item')
        try:
            fanArt = channel_list('fanart')[0].string
            if fanArt == None:
                raise
        except:
            fanArt = fanart
        for channel in channel_list('subchannel'):
            name = channel('name')[0].string
            try:
                thumbnail = channel('thumbnail')[0].string
                if thumbnail == None:
                    raise
            except:
                thumbnail = ''
            try:
                if not channel('fanart'):
                    if addon.getSetting('use_thumb') == "true":
                        fanArt = thumbnail
                else:
                    fanArt = channel('fanart')[0].string
                if fanArt == None:
                    raise
            except:
                pass
            try:
                desc = channel('info')[0].string
                if desc == None:
                    raise
            except:
                desc = ''

            try:
                genre = channel('genre')[0].string
                if genre == None:
                    raise
            except:
                genre = ''

            try:
                date = channel('date')[0].string
                if date == None:
                    raise
            except:
                date = ''

            try:
                credits = channel('credits')[0].string
                if credits == None:
                    raise
            except:
                credits = ''

            try:
                addDir(name.encode('utf-8', 'ignore'),url.encode('utf-8'),3,thumbnail,fanArt,desc,genre,credits,date)
            except:
                addon_log('There was a problem adding directory - '+name.encode('utf-8', 'ignore'))
        getItems(items,fanArt)

def getSubChannelItems(name,url,fanart):
        soup = getSoup(url)
        channel_list = soup.find('subchannel', attrs={'name' : name.decode('utf-8')})
        items = channel_list('subitem')
        getItems(items,fanart)

def GetSublinks(name,url,iconimage,fanart):
    xbmc.log('I GOT HERE###############')
    List=[]; ListU=[]; c=0
    all_videos = regex_get_all(url, 'sublink:', '#')
    for a in all_videos:
        if 'LISTSOURCE:' in a:
            vurl = regex_from_to(a, 'LISTSOURCE:', '::')
            linename = regex_from_to(a, 'LISTNAME:', '::')
        else:
            vurl = a.replace('sublink:','').replace('#','')
            linename = name
        if len(vurl) > 10:
            c=c+1; List.append(linename); ListU.append(vurl)
 
    if c==1:
        try:
            liz=xbmcgui.ListItem(name); liz.setInfo( type="Video", infoLabels={ "Title": name } )
            liz.setArt({'icon':iconimage,'thumb':iconimage})
            ok=xbmcplugin.addDirectoryItem(handle=int(sys.argv[1]),url=ListU[0],listitem=liz)
            xbmc.Player().play(urlsolver(ListU[0]), liz)
        except:
            pass
    else:
         dialog=xbmcgui.Dialog()
         rNo=dialog.select('Select A Source', List)
         if rNo>=0:
             rName=name
             rURL=str(ListU[rNo])
             try:
                 xbmc.Player().play(urlsolver(rURL), xbmcgui.ListItem(rName))
             except:
                 xbmc.Player().play(rURL, xbmcgui.ListItem(rName))
               
def Search_m3u(data,Searchkey):
    content = data.rstrip()
    match = re.compile(r'#EXTINF:(.+?),(.*?)[\n\r]+([^\n]+)').findall(content)
    total = len(match)
    print('total m3u links',total)
    for other,channel_name,stream_url in match:
        if 'tvg-logo' in other:
            thumbnail = re_me(other,'tvg-logo=[\'"](.*?)[\'"]')
            if thumbnail:
                if thumbnail.startswith('http'):
                    thumbnail = thumbnail
                
                elif not addon.getSetting('logo-folderPath') == "":
                    logo_url = addon.getSetting('logo-folderPath')
                    thumbnail = logo_url + thumbnail

                else:
                    thumbnail = thumbnail            
        else:
            thumbnail = ''
        if 'type' in other:
            mode_type = re_me(other,'type=[\'"](.*?)[\'"]')
            if mode_type == 'yt-dl':
                stream_url = stream_url +"&mode=18"
            elif mode_type == 'regex':
                url = stream_url.split('&regexs=')
                regexs = parse_regex(getSoup('',data=url[1]))
                
                addLink(url[0], channel_name,thumbnail,'','','','','',None,regexs,total)
                continue
        addLink(stream_url, channel_name,thumbnail,'','','','','',None,'',total)

def FindFirstPattern(text,pattern):
    result = ""
    try:    
        matches = re.findall(pattern,text, flags=re.DOTALL)
        result = matches[0]
    except:
        result = ""

    return result
    
def getItems(items,fanart):
        total = len(items)
        addon_log('Total Items: %s' %total)
        for item in items:
            isXMLSource=False
            isJsonrpc = False
            try:
                name = item('title')[0].string
                
                if name is None:
                    name = 'unknown?'
            except:
                addon_log('Name Error')
                name = ''


            try:
                if item('epg'):
                    if item.epg_url:
                        addon_log('Get EPG Regex')
                        epg_url = item.epg_url.string
                        epg_regex = item.epg_regex.string
                        epg_name = get_epg(epg_url, epg_regex)
                        if epg_name:
                            name += ' - ' + epg_name
                    elif item('epg')[0].string > 1:
                        name += getepg(item('epg')[0].string)
                else:
                    pass
            except:
                addon_log('EPG Error')
            try:
                url = []
                if len(item('url')) >0:
                    for i in item('url'):
                        if not i.string == None:
                            url.append(i.string)

                if len(item('inputstream')) >0:
                    for i in item('inputstream'):
                        if not i.string == None:
                            url.append(i.string)

                elif len(item('sportsdevil')) >0:
                    for i in item('sportsdevil'):
                        if not i.string == None:
                            sportsdevil = 'plugin://plugin.video.SportsDevil/?mode=1&amp;item=catcher%3dstreams%26url=' +i.string
                            referer = item('referer')[0].string
                            if referer:
                                sportsdevil = sportsdevil + '%26referer=' +referer
                            url.append(sportsdevil)

                elif len(item('p2p')) >0:
                    for i in item('p2p'):
                        if not i.string == None:
                            if 'sop://' in i:
                                sop = 'plugin://plugin.video.p2p-streams/?url='+i.string +'&amp;mode=2&amp;' + 'name='+name 
                                url.append(sop) 
                            else:
                                p2p='plugin://plugin.video.p2p-streams/?url='+i.string +'&amp;mode=1&amp;' + 'name='+name 
                                url.append(p2p)
                elif len(item('vaughn')) >0:
                    for i in item('vaughn'):
                        if not i.string == None:
                            vaughn = 'plugin://plugin.stream.vaughnlive.tv/?mode=PlayLiveStream&amp;channel='+i.string
                            url.append(vaughn)
                elif len(item('ilive')) >0:
                    for i in item('ilive'):
                        if not i.string == None:
                            if not 'http' in i.string:
                                ilive = 'plugin://plugin.video.tbh.ilive/?url=http://www.streamlive.to/view/'+i.string+'&amp;link=99&amp;mode=iLivePlay'
                            else:
                                ilive = 'plugin://plugin.video.tbh.ilive/?url='+i.string+'&amp;link=99&amp;mode=iLivePlay'
                elif len(item('yt-dl')) >0:
                    for i in item('yt-dl'):
                        if not i.string == None:
                            ytdl = i.string + '&mode=18'
                            url.append(ytdl)
                elif len(item('utube')) >0:
                    for i in item('utube'):
                        if not i.string == None:
                            if len(i.string) == 11:
                                utube = 'plugin://plugin.video.youtube/play/?video_id='+ i.string 
                            elif i.string.startswith('PL') and not '&order=' in i.string :
                                utube = 'plugin://plugin.video.youtube/play/?&order=default&playlist_id=' + i.string
                            else:
                                utube = 'plugin://plugin.video.youtube/play/?playlist_id=' + i.string 
                    url.append(utube)
                elif len(item('imdb')) >0:
                    for i in item('imdb'):
                        if not i.string == None:
                            if addon.getSetting('genesisorpulsar') == '0':
                                imdb = 'plugin://plugin.video.genesis/?action=play&imdb='+i.string
                            else:
                                imdb = 'plugin://plugin.video.pulsar/movie/tt'+i.string+'/play'
                            url.append(imdb)                      
                elif len(item('f4m')) >0:
                        for i in item('f4m'):
                            if not i.string == None:
                                if '.f4m' in i.string:
                                    f4m = 'plugin://plugin.video.f4mTester/?url='+urllib.parse.quote_plus(i.string)
                                elif '.m3u8' in i.string:
                                    f4m = 'plugin://plugin.video.f4mTester/?url='+urllib.parse.quote_plus(i.string)+'&amp;streamtype=HLS'
                                    
                                else:
                                    f4m = 'plugin://plugin.video.f4mTester/?url='+urllib.parse.quote_plus(i.string)+'&amp;streamtype=SIMPLE'
                        url.append(f4m)
                elif len(item('ftv')) >0:
                    for i in item('ftv'):
                        if not i.string == None:
                            ftv = 'plugin://plugin.video.F.T.V/?name='+urllib.parse.quote(name) +'&url=' +i.string +'&mode=125&ch_fanart=na'
                        url.append(ftv)                        
                if len(url) < 1:
                    raise
            except Exception as e:
                addon_log('Error <link> element, Passing:'+name)#.decode(encoding='UTF-8'))#encode('utf-8', 'ignore'))
                continue
                
            isXMLSource=False

            try:
                isXMLSource = item('externallink')[0].string
            except: pass
            
            if isXMLSource:
                ext_url=[isXMLSource]
                isXMLSource=True
            else:
                isXMLSource=False
            try:
                isJsonrpc = item('jsonrpc')[0].string
            except: pass
            if isJsonrpc:
                ext_url=[isJsonrpc]
                isJsonrpc=True
            else:
                isJsonrpc=False            
            try:
                thumbnail = item('thumbnail')[0].string
                if thumbnail == None:
                    raise
            except:
                thumbnail = ''
            try:
                if not item('fanart'):
                    if addon.getSetting('use_thumb') == "true":
                        fanArt = thumbnail
                    else:
                        fanArt = fanart
                else:
                    fanArt = item('fanart')[0].string
                if fanArt == None:
                    raise
            except:
                fanArt = fanart
            try:
                desc = item('info')[0].string
                if desc == None:
                    raise
            except:
                desc = ''

            try:
                genre = item('genre')[0].string
                if genre == None:
                    raise
            except:
                genre = ''

            try:
                date = item('date')[0].string
                if date == None:
                    raise
            except:
                date = ''

            regexs = None
            if item('regex'):
                try:
                    reg_item = item('regex')
                    regexs = parse_regex(reg_item)
                except:
                    pass            
           
            try:
                if len(url) > 1:
                    
                    alt = 0
                    playlist = []
                    for i in url:
                        if addon.getSetting('ask_playlist_items') == 'true':
                            if regexs:
                                playlist.append(i+'&regexs='+regexs)
                            elif  any(x in i for x in resolve_url) and  i.startswith('http'):
                                playlist.append(i+'&mode=19')                            
                        else:
                            playlist.append(i)
                    if addon.getSetting('add_playlist') == "false":                    
                            for i in url:
                                alt += 1
                                addLink(i,'%s) %s' %(alt, name.encode('utf-8', 'ignore')),thumbnail,fanArt,desc,genre,date,True,playlist,regexs,total)                            
                    else:
                        addLink('', name.encode('utf-8', 'ignore'),thumbnail,fanArt,desc,genre,date,True,playlist,regexs,total)
                else:
                    if isXMLSource:
                        addDir(name.encode('utf-8'),ext_url[0].encode('utf-8'),1,thumbnail,fanart,desc,genre,date,None,'source')
                    elif isJsonrpc:
                        addDir(name.encode('utf-8'),ext_url[0],53,thumbnail,fanart,desc,genre,date,None,'source')
                    elif url[0].find('sublink') > 0:
                        addDir(name.encode('utf-8'),url[0],30,thumbnail,fanart,'','','','')
                    else: 
                        addLink(url[0],name.encode('utf-8', 'ignore'),thumbnail,fanArt,desc,genre,date,True,None,regexs,total)
            except:
                addon_log('There was a problem adding item - '+name.encode('utf-8', 'ignore'))
        print('FINISH GET ITEMS *****')      

def parse_regex(reg_item):
                try:
                    regexs = {}
                    for i in reg_item:
                        regexs[i('name')[0].string] = {}
                        try:
                            regexs[i('name')[0].string]['expre'] = i('expres')[0].string
                            if not regexs[i('name')[0].string]['expre']:
                                regexs[i('name')[0].string]['expre']=''
                        except:
                            addon_log("Regex: -- No Referer --")
                        regexs[i('name')[0].string]['page'] = i('page')[0].string
                        try:
                            regexs[i('name')[0].string]['refer'] = i('referer')[0].string
                        except:
                            addon_log("Regex: -- No Referer --")
                        try:
                            regexs[i('name')[0].string]['connection'] = i('connection')[0].string
                        except:
                            addon_log("Regex: -- No connection --")

                        try:
                            regexs[i('name')[0].string]['notplayable'] = i('notplayable')[0].string
                        except:
                            addon_log("Regex: -- No notplayable --")
                            
                        try:
                            regexs[i('name')[0].string]['noredirect'] = i('noredirect')[0].string
                        except:
                            addon_log("Regex: -- No noredirect --")
                        try:
                            regexs[i('name')[0].string]['origin'] = i('origin')[0].string
                        except:
                            addon_log("Regex: -- No origin --")
                        try:
                            regexs[i('name')[0].string]['includeheaders'] = i('includeheaders')[0].string
                        except:
                            addon_log("Regex: -- No includeheaders --")                            
                            
                        try:
                            regexs[i('name')[0].string]['x-req'] = i('x-req')[0].string
                        except:
                            addon_log("Regex: -- No x-req --")
                        try:
                            regexs[i('name')[0].string]['x-forward'] = i('x-forward')[0].string
                        except:
                            addon_log("Regex: -- No x-forward --")

                        try:
                            regexs[i('name')[0].string]['agent'] = i('agent')[0].string
                        except:
                            addon_log("Regex: -- No User Agent --")
                        try:
                            regexs[i('name')[0].string]['post'] = i('post')[0].string
                        except:
                            addon_log("Regex: -- Not a post")
                        try:
                            regexs[i('name')[0].string]['rawpost'] = i('rawpost')[0].string
                        except:
                            addon_log("Regex: -- Not a rawpost")
                        try:
                            regexs[i('name')[0].string]['htmlunescape'] = i('htmlunescape')[0].string
                        except:
                            addon_log("Regex: -- Not a htmlunescape")


                        try:
                            regexs[i('name')[0].string]['readcookieonly'] = i('readcookieonly')[0].string
                        except:
                            addon_log("Regex: -- Not a readCookieOnly")
                        try:
                            regexs[i('name')[0].string]['cookiejar'] = i('cookiejar')[0].string
                            if not regexs[i('name')[0].string]['cookiejar']:
                                regexs[i('name')[0].string]['cookiejar']=''
                        except:
                            addon_log("Regex: -- Not a cookieJar")                          
                        try:
                            regexs[i('name')[0].string]['setcookie'] = i('setcookie')[0].string
                        except:
                            addon_log("Regex: -- Not a setcookie")
                        try:
                            regexs[i('name')[0].string]['appendcookie'] = i('appendcookie')[0].string
                        except:
                            addon_log("Regex: -- Not a appendcookie")
                                                    
                        try:
                            regexs[i('name')[0].string]['ignorecache'] = i('ignorecache')[0].string
                        except:
                            addon_log("Regex: -- no ignorecache")
                    regexs = urllib.parse.quote(repr(regexs))
                    return regexs
                except:
                    regexs = None
                    addon_log('regex Error: '+name.encode('utf-8', 'ignore'))

def getRegexParsed(regexs, url,cookieJar=None,forCookieJarOnly=False,recursiveCall=False,cachedPages={}, rawPost=False, cookie_jar_file=None):
        if not recursiveCall:
            regexs = eval(urllib.parse.unquote(regexs))
        doRegexs = re.compile('\$doregex\[([^\]]*)\]').findall(url)
        setresolved=True        
        for k in doRegexs:
            if k in regexs:
                m = regexs[k]
                cookieJarParam=False


                if  'cookiejar' in m:
                    cookieJarParam=m['cookiejar']
                    if  '$doregex' in cookieJarParam:
                        cookieJar=getRegexParsed(regexs, m['cookiejar'],cookieJar,True, True,cachedPages)
                        cookieJarParam=True
                    else:
                        cookieJarParam=True
                if cookieJarParam:
                    if cookieJar==None:
                        cookie_jar_file=None
                        if 'open[' in m['cookiejar']:
                            cookie_jar_file=m['cookiejar'].split('open[')[1].split(']')[0]
                            
                        cookieJar=getCookieJar(cookie_jar_file)
                        if cookie_jar_file:
                            saveCookieJar(cookieJar,cookie_jar_file)
                    elif 'save[' in m['cookiejar']:
                        cookie_jar_file=m['cookiejar'].split('save[')[1].split(']')[0]
                        complete_path=os.path.join(profile,cookie_jar_file)
                        print('complete_path',complete_path)
                        saveCookieJar(cookieJar,cookie_jar_file)
                if  m['page'] and '$doregex' in m['page']:
                    m['page']=getRegexParsed(regexs, m['page'],cookieJar,recursiveCall=True,cachedPages=cachedPages)

                if 'setcookie' in m and m['setcookie'] and '$doregex' in m['setcookie']:
                    m['setcookie']=getRegexParsed(regexs, m['setcookie'],cookieJar,recursiveCall=True,cachedPages=cachedPages)
                if 'appendcookie' in m and m['appendcookie'] and '$doregex' in m['appendcookie']:
                    m['appendcookie']=getRegexParsed(regexs, m['appendcookie'],cookieJar,recursiveCall=True,cachedPages=cachedPages)

                 
                if  'post' in m and '$doregex' in m['post']:
                    m['post']=getRegexParsed(regexs, m['post'],cookieJar,recursiveCall=True,cachedPages=cachedPages)
                    print('post is now',m['post'])

                if  'rawpost' in m and '$doregex' in m['rawpost']:
                    m['rawpost']=getRegexParsed(regexs, m['rawpost'],cookieJar,recursiveCall=True,cachedPages=cachedPages,rawPost=True)  
                if 'rawpost' in m and '$epoctime$' in m['rawpost']:
                    m['rawpost']=m['rawpost'].replace('$epoctime$',getEpocTime())
  
                if 'rawpost' in m and '$epoctime2$' in m['rawpost']:
                    m['rawpost']=m['rawpost'].replace('$epoctime2$',getEpocTime2())
                link=''
                if m['page'] and m['page'] in cachedPages and not 'ignorecache' in m and forCookieJarOnly==False :
                    link = cachedPages[m['page']]
                else:
                    if m['page'] and  not m['page']=='' and  m['page'].startswith('http'):
                        
                        if '$epoctime$' in m['page']:
                            m['page']=m['page'].replace('$epoctime$',getEpocTime())
                        if '$epoctime2$' in m['page']:
                            m['page']=m['page'].replace('$epoctime2$',getEpocTime2())
                        page_split=m['page'].split('|')
                        pageUrl=page_split[0]
                        header_in_page=None
                        if len(page_split)>1:
                            header_in_page=page_split[1]
                            
                        req = urllib.request.Request(pageUrl)
                        req.add_header('User-Agent', 'Mozilla/5.0 (Windows NT 6.1; rv:14.0) Gecko/20100101 Firefox/14.0.1')
                        if 'refer' in m:
                            req.add_header('Referer', m['refer'])
                        if 'agent' in m:
                            req.add_header('User-agent', m['agent'])
                        if 'x-req' in m:
                            req.add_header('X-Requested-With', m['x-req'])
                        if 'x-forward' in m:
                            req.add_header('X-Forwarded-For', m['x-forward'])
                        if 'setcookie' in m:
                            print('adding cookie',m['setcookie'])
                            req.add_header('Cookie', m['setcookie'])
                        if 'appendcookie' in m:
                            print('appending cookie to cookiejar',m['appendcookie'])
                            cookiestoApend=m['appendcookie']
                            cookiestoApend=cookiestoApend.split(';')
                            for h in cookiestoApend:
                                n,v=h.split('=')
                                w,n= n.split(':')
                                ck = cookielib.Cookie(version=0, name=n, value=v, port=None, port_specified=False, domain=w, domain_specified=False, domain_initial_dot=False, path='/', path_specified=True, secure=False, expires=None, discard=True, comment=None, comment_url=None, rest={'HttpOnly': None}, rfc2109=False)
                                cookieJar.set_cookie(ck)
                        if 'origin' in m:
                            req.add_header('Origin', m['origin'])
                        if header_in_page:
                            header_in_page=header_in_page.split('&')
                            for h in header_in_page:
                                n,v=h.split('=')
                                req.add_header(n,v)


                        if not cookieJar==None:
                            cookie_handler = urllib.request.HTTPCookieProcessor(cookieJar)
                            opener = urllib.request.build_opener(cookie_handler, urllib2.HTTPBasicAuthHandler(), urllib2.HTTPHandler())
                            opener = urllib.request.install_opener(opener)
                            if 'noredirect' in m:
                                opener2 = urllib.request.build_opener(NoRedirection)
                                opener = urllib.request.install_opener(opener2)
                                
                        if 'connection' in m:
                            print('..........................connection//////.',m['connection'])
                            from keepalive import HTTPHandler
                            keepalive_handler = HTTPHandler()
                            opener = urllib.request.build_opener(keepalive_handler)
                            urllib.request.install_opener(opener)
                        post=None

                        if 'post' in m:
                            postData=m['post']
                            if '$LiveStreamRecaptcha' in postData:
                                (captcha_challenge,catpcha_word)=processRecaptcha(m['page'])
                                if captcha_challenge:
                                    postData+='recaptcha_challenge_field:'+captcha_challenge+',recaptcha_response_field:'+catpcha_word
                            splitpost=postData.split(',');
                            post={}
                            for p in splitpost:
                                n=p.split(':')[0];
                                v=p.split(':')[1];
                                post[n]=v
                            post = urllib.urlencode(post)

                        if 'rawpost' in m:
                            post=m['rawpost']
                            if '$LiveStreamRecaptcha' in post:
                                (captcha_challenge,catpcha_word)=processRecaptcha(m['page'])
                                if captcha_challenge:
                                   post+='&recaptcha_challenge_field='+captcha_challenge+'&recaptcha_response_field='+catpcha_word
                        if post:
                            response = urllib.request.urlopen(req,post)
                        else:
                            response = urllib.request.urlopen(req)

                        link = response.read()
                        link=javascriptUnEscape(link)
                        if 'includeheaders' in m:
                            link+=str(response.headers.get('Set-Cookie'))

                        response.close()
                        cachedPages[m['page']] = link                        
                        if forCookieJarOnly:
                            return cookieJar
                        
                    elif m['page'] and  not m['page'].startswith('http'):
                        if m['page'].startswith('$pyFunction:'):
                            val=doEval(m['page'].split('$pyFunction:')[1],'',cookieJar )
                            if forCookieJarOnly:
                                return cookieJar
                            link=val
                        else:
                            link=m['page']
                if '$pyFunction:playmedia(' in m['expre'] or 'ActivateWindow'  in m['expre']   or  any(x in url for x in g_ignoreSetResolved):
                    setresolved=False
                if  '$doregex' in m['expre']:
                    m['expre']=getRegexParsed(regexs, m['expre'],cookieJar,recursiveCall=True,cachedPages=cachedPages)

                if not m['expre']=='':
                    if '$LiveStreamCaptcha' in m['expre']:
                        val=askCaptcha(m,link,cookieJar)
                        url = url.replace("$doregex[" + k + "]", val.encode('utf-8'))
                    elif m['expre'].startswith('$pyFunction:'):
                        val=doEval(m['expre'].split('$pyFunction:')[1],link,cookieJar )
                        if 'ActivateWindow' in m['expre']: return 

                        url = url.replace("$doregex[" + k + "]", val)
                    else:
                        if not link=='':
                            reg = re.compile(m['expre'].encode('utf-8')).search(link)
                            val=''
                            try:
                                val=reg.group(1).strip()
                            except: traceback.print_exc()
                        else:
                            val=m['expre']
                            
                        # Apply rawpost substitution (NEW CODE ADDED HERE)
                        if 'rawpost' in m and m['rawpost']:
                            # Handle sed-style substitution s/find/replace/flags
                            rawpost_cmd = m['rawpost']
                            if rawpost_cmd.startswith('s/'):
                                parts = rawpost_cmd.split('/')
                                if len(parts) >= 3:
                                    find_pattern = parts[1]
                                    replace_with = parts[2]
                                    # Apply the substitution globally (g flag)
                                    val = re.sub(find_pattern, replace_with, val)
                                    xbmc.log(f"Applied rawpost substitution: {val[:100]}...", xbmc.LOGDEBUG)
                        
                        if rawPost:
                            print('rawpost')
                            val=urllib.parse.quote_plus(val)
                        if 'htmlunescape' in m:
                            import HTMLParser
                            val=HTMLParser.HTMLParser().unescape(val)                     
                        url = url.replace("$doregex[" + k + "]", str(val))#.encode('utf-8'))
                else:           
                    url = url.replace("$doregex[" + k + "]",'')
        if '$epoctime$' in url:
            url=url.replace('$epoctime$',getEpocTime())
        if '$epoctime2$' in url:
            url=url.replace('$epoctime2$',getEpocTime2())

        if '$GUID$' in url:
            import uuid
            url=url.replace('$GUID$',str(uuid.uuid1()).upper())
        if '$get_cookies$' in url:
            url=url.replace('$get_cookies$',getCookiesString(cookieJar))   

        if recursiveCall:
            return url
        url = url.split('|')[0].replace('b\'','').replace('\'','')+'|'+url.split('|')[1].replace('&','&amp;')
        if url=="": 
            return
        else:
            return str(url),setresolved

def playmedia(media_url):
    try:
        import  CustomPlayer
        player = CustomPlayer.MyXBMCPlayer()
        listitem = xbmcgui.ListItem( label = str(name), path=media_url )
        listitem.setArt({'icon':"DefaultVideo.png",'thumb':xbmc.getInfoImage( "ListItem.Thumb") })
        player.play( media_url,listitem)
        xbmc.sleep(1000)
        while player.is_active:
            xbmc.sleep(200)
    except:
        traceback.print_exc()
    return ''

  
def getUrl(url, cookieJar=None,post=None, timeout=20, headers=None):
    cookie_handler = urllib.parse.HTTPCookieProcessor(cookieJar)
    opener = urllib.parse.build_opener(cookie_handler, urllib2.HTTPBasicAuthHandler(), urllib2.HTTPHandler())
    req = urllib.parse.Request(url)
    req.add_header('User-Agent','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36')
    if headers:
        for h,hv in headers:
            req.add_header(h,hv)

    response = opener.open(req,post,timeout=timeout)
    link=response.read()
    response.close()
    return link

 
def playmedia(media_url):
    try:
        import  CustomPlayer
        player = CustomPlayer.MyXBMCPlayer()
        listitem = xbmcgui.ListItem( label = str(name), path=media_url )
        listitem.setArt({'icon':"DefaultVideo.png",'thumb':xbmc.getInfoImage( "ListItem.Thumb") })
        player.play( media_url,listitem)
        xbmc.sleep(1000)
        while player.is_active:
            xbmc.sleep(200)
    except:
        traceback.print_exc()
    return ''

 
def javascriptUnEscape(data):
    js=re.findall('unescape\(\'(.*?)\'',data.decode('utf-8'))
    print('js',js)
    if (not js==None) and len(js)>0:
        for j in js:
            data=data.replace(j ,urllib.parse.unquote(j))
    return data
iid=0

def get_params():
        param=[]
        paramstring=sys.argv[2]
        if len(paramstring)>=2:
            params=sys.argv[2]
            cleanedparams=params.replace('?','')
            if (params[len(params)-1]=='/'):
                params=params[0:len(params)-2]
            pairsofparams=cleanedparams.split('&')
            param={}
            for i in range(len(pairsofparams)):
                splitparams={}
                splitparams=pairsofparams[i].split('=')
                if (len(splitparams))==2:
                    param[splitparams[0]]=splitparams[1]
        return param

def urlsolver(url):
    if addon.getSetting('Updatecommonresolvers') == 'true':
        l = os.path.join(home,'resolverers.py')
        if xbmcvfs.exists(l):
            os.remove(l)

        genesis_url = 'https://raw.githubusercontent.com/lambda81/lambda-addons/master/plugin.video.genesis/commonresolvers.py'
        th= urllib.request.urlretrieve(genesis_url,l)
        addon.setSetting('Updatecommonresolvers', 'false')
    try:
        import resolverers
    except Exception:
        xbmc.executebuiltin("XBMC.Notification(RisingTides,Please enable Update Commonresolvers to Play in Settings. - ,10000)")

    resolved=resolverers.get(url).result
    if url == resolved or resolved is None:
        xbmc.executebuiltin("XBMC.Notification(RisingTides,Using resolveurl module.. - ,5000)")
        import resolveurl
        host = resolveurl.HostedMediaFile(url)
        if host:
            resolver = resolveurl.resolve(url)
            resolved = resolver
    if resolved :
        if isinstance(resolved,list):
            for k in resolved:
                quality = addon.getSetting('quality')
                if k['quality'] == 'HD'  :
                    resolver = k['url']
                    break
                elif k['quality'] == 'SD' :
                    resolver = k['url']
                elif k['quality'] == '1080p' and addon.getSetting('1080pquality') == 'true' :
                    resolver = k['url']
                    break
        else:
            resolver = resolved
    return resolver


def play_playlist(name, mu_playlist):
        import urlparse
        if addon.getSetting('ask_playlist_items') == 'true':
            names = []
            for i in mu_playlist:
                d_name=urlparse.urlparse(i).netloc
                if d_name == '':
                    names.append(name)
                else:
                    names.append(d_name)
            dialog = xbmcgui.Dialog()
            index = dialog.select('Choose a video source', names)
            if index >= 0:
                if "&mode=19" in mu_playlist[index]:
                    xbmc.Player().play(urlsolver(mu_playlist[index].replace('&mode=19','')))
                elif "$doregex" in mu_playlist[index] :

                    sepate = mu_playlist[index].split('&regexs=')

                    url,setresolved = getRegexParsed(sepate[1], sepate[0])
                    xbmc.Player().play(url)
                else:
                    url = mu_playlist[index]
                    xbmc.Player().play(url)
        else:
            playlist = xbmc.PlayList(1)
            playlist.clear()
            item = 0
            for i in mu_playlist:
                item += 1
                info = xbmcgui.ListItem('%s) %s' %(str(item),name))
                playlist.add(i, info)
                xbmc.executebuiltin('playlist.playoffset(video,0)')


def addDir(name,url,mode,iconimage,fanart,description,genre,date,credits,showcontext=False):
        
        u=sys.argv[0]+"?url="+urllib.parse.quote_plus(url)+"&mode="+str(mode)+"&name="+urllib.parse.quote_plus(name)+"&iconimage="+urllib.parse.quote_plus(iconimage)+"&fanart="+urllib.parse.quote_plus(fanart)
        ok=True
        if date == '':
            date = None
        else:
            description += '\n\nDate: %s' %date
        liz=xbmcgui.ListItem(name)
        liz.setArt({"icon":iconimage, "thumb":iconimage})
        liz.setInfo(type="Video", infoLabels={ "Title": name, "Plot": description, "Genre": genre, "dateadded": date, "credits": credits })
        liz.setProperty("Fanart_Image", fanart)
        if showcontext:
            contextMenu = []
            if showcontext == 'source':
                if name.decode(encoding='UTF-8') in str(SOURCES):
                    contextMenu.append(('Remove from Sources','XBMC.RunPlugin(%s?mode=8&name=%s)' %(sys.argv[0], urllib.parse.quote_plus(name))))
            elif showcontext == 'download':
                contextMenu.append(('Download','XBMC.RunPlugin(%s?url=%s&mode=9&name=%s)'
                                    %(sys.argv[0], urllib.parse.quote_plus(url), urllib.parse.quote_plus(name))))
            elif showcontext == 'fav':
                contextMenu.append(('Remove from Add-on Favorites','XBMC.RunPlugin(%s?mode=6&name=%s)'
                                    %(sys.argv[0], urllib.parse.quote_plus(name))))
                                    
            if not name in FAV:
                contextMenu.append(('Add to Add-on Favorites','XBMC.RunPlugin(%s?mode=5&name=%s&url=%s&iconimage=%s&fanart=%s&fav_mode=%s)'
                         %(sys.argv[0], urllib.parse.quote_plus(name), urllib.parse.quote_plus(url), urllib.parse.quote_plus(iconimage), urllib.parse.quote_plus(fanart), mode)))
            liz.addContextMenuItems(contextMenu)
        ok=xbmcplugin.addDirectoryItem(handle=int(sys.argv[1]),url=u,listitem=liz,isFolder=True)
        
        return ok

def addDir1(name,url,mode,iconimage,fanart,description):
    u=sys.argv[0]+"?url="+url+"&mode="+str(mode)+"&name="+urllib.parse.quote_plus(name)+"&iconimage="+urllib.parse.quote_plus(iconimage)+"&description="+urllib.parse.quote_plus(description)
    ok=True
    liz=xbmcgui.ListItem(name)
    liz.setArt({"icon":"DefaultFolder.png", "thumb":iconimage})

    liz.setInfo( type="Video", infoLabels={"Title": name,"Plot":description})
    liz.setProperty('fanart_image', fanart)
    if mode==102 or mode==9999:
        liz.setProperty("IsPlayable","true")
        ok=xbmcplugin.addDirectoryItem(handle=int(sys.argv[1]),url=u,listitem=liz,isFolder=False)
    else:
        ok=xbmcplugin.addDirectoryItem(handle=int(sys.argv[1]),url=u,listitem=liz,isFolder=True)
    return ok
    xbmcplugin.endOfDirectory

def addDir2(name,url,mode,iconimage,fanart,channelid=''):
        u=sys.argv[0]+"?url="+urllib.parse.quote_plus(url)+"&mode="+str(mode)+"&name="+urllib.parse.quote_plus(name)+"&channelid="+str(channelid)+"&iconimage="+urllib.parse.quote_plus(iconimage)
        ok=True
        liz=xbmcgui.ListItem(name)
        liz.setArt({"icon":"DefaultFolder.png", "thumb":iconimage})

        liz.setInfo( type="Video", infoLabels={ "Title": name, 'plot': channelid } )
        liz.setProperty('fanart_image', fanart)
        ok=xbmcplugin.addDirectoryItem(handle=int(sys.argv[1]),url=u,listitem=liz,isFolder=True)
        return ok

def sendJSON( command):
    data = ''
    try:
        data = xbmc.executeJSONRPC(uni(command))
    except UnicodeEncodeError:
        data = xbmc.executeJSONRPC(ascii(command))

    return uni(data)

def SetViewThumbnail():
    skin_used = xbmc.getSkinDir()
    if skin_used == 'skin.confluence':
        xbmc.executebuiltin('Container.SetViewMode(500)')
    elif skin_used == 'skin.aeon.nox':
        xbmc.executebuiltin('Container.SetViewMode(511)') 
    else:
        xbmc.executebuiltin('Container.SetViewMode(500)')
    
def pluginquerybyJSON(url):
    json_query = uni('{"jsonrpc":"2.0","method":"Files.GetDirectory","params":{"directory":"%s","media":"video","properties":["thumbnail","title","year","dateadded","fanart","rating","season","episode","studio"]},"id":1}') %url

    json_folder_detail = json.loads(sendJSON(json_query))
    for i in json_folder_detail['result']['files'] :
        url = i['file']
        name = removeNonAscii(i['label'])
        thumbnail = removeNonAscii(i['thumbnail'])
        try:
            fanart = removeNonAscii(i['fanart'])
        except Exception:
            fanart = ''
        try:
            date = i['year']
        except Exception:
            date = ''
        try:
            episode = i['episode']
            season = i['season']
            if episode == -1 or season == -1:
                description = ''
            else:
                description = '[COLOR yellow] S' + str(season)+'[/COLOR][COLOR hotpink] E' + str(episode) +'[/COLOR]'
        except Exception:
            description = ''
        try:
            studio = i['studio']
            if studio:
                description += '\n Studio:[COLOR steelblue] ' + studio[0] + '[/COLOR]'
        except Exception:
            studio = ''

        if i['filetype'] == 'file':
            addLink(url,name,thumbnail,fanart,description,'',date,'',None,'',total=len(json_folder_detail['result']['files']))
        else:
            addDir(name,url,53,thumbnail,fanart,description,'',date,'')

def addLink(url,name,iconimage,fanart,description,genre,date,showcontext,playlist,regexs,total,setCookie=""):
        contextMenu =[]
        try:
            name = name.encode('utf-8')
        except: pass
        ok = True
       
        if regexs: 
            mode = '14'
           
            contextMenu.append(('[COLOR white]!!Download Currently Playing!![/COLOR]','XBMC.RunPlugin(%s?url=%s&mode=21&name=%s)'
                                    %(sys.argv[0], urllib.parse.quote_plus(url), urllib.parse.quote_plus(name))))           
        elif  any(x in url for x in resolve_url) and  url.startswith('http'):
            mode = '19'
          
            contextMenu.append(('[COLOR white]!!Download Currently Playing!![/COLOR]','XBMC.RunPlugin(%s?url=%s&mode=21&name=%s)'
                                    %(sys.argv[0], urllib.parse.quote_plus(url), urllib.parse.quote_plus(name))))           
        elif url.endswith('&mode=18'):
            url=url.replace('&mode=18','')
            mode = '18' 
          
            contextMenu.append(('[COLOR white]!!Download!![/COLOR]','XBMC.RunPlugin(%s?url=%s&mode=23&name=%s)'
                                    %(sys.argv[0], urllib.parse.quote_plus(url), urllib.parse.quote_plus(name)))) 
            if addon.getSetting('dlaudioonly') == 'true':
                contextMenu.append(('!!Download [COLOR seablue]Audio!![/COLOR]','XBMC.RunPlugin(%s?url=%s&mode=24&name=%s)'
                                        %(sys.argv[0], urllib.parse.quote_plus(url), urllib.parse.quote_plus(name))))                                     
        elif url.startswith('magnet:?xt=') or '.torrent' in url:
          
            if '&' in url and not '&amp;' in url :
                url = url.replace('&','&amp;')
            url = 'plugin://plugin.video.pulsar/play?uri=' + url
            mode = '14'
                     
        else: 
            mode = '14'
      
            contextMenu.append(('[COLOR white]!!Download Currently Playing!![/COLOR]','XBMC.RunPlugin(%s?url=%s&mode=21&name=%s)'
                                    %(sys.argv[0], urllib.parse.quote_plus(url), urllib.parse.quote_plus(name))))           
        u=sys.argv[0]+"?"
        play_list = False
      
        if playlist:
            if addon.getSetting('add_playlist') == "false":
                u += "url="+urllib.parse.quote_plus(url)+"&mode="+mode
            else:
                u += "mode=13&name=%s&playlist=%s" %(urllib.parse.quote_plus(name), urllib.parse.quote_plus(str(playlist).replace(',','||')))
                name = name + '[COLOR magenta] (' + str(len(playlist)) + ' items )[/COLOR]'
                play_list = True
        else:
            u += "url="+urllib.parse.quote_plus(url)+"&mode="+mode
        if regexs:
            u += "&regexs="+regexs
        if not setCookie == '':
            u += "&setCookie="+urllib.parse.quote_plus(setCookie)
  
        if date == '':
            date = None
        else:
            description += '\n\nDate: %s' %date
        liz=xbmcgui.ListItem(name)
        liz.setArt({"icon":"DefaultFolder.png", "thumb":iconimage})

        liz.setInfo(type="Video", infoLabels={ "Title": name, "Plot": description, "Genre": genre, "dateadded": date })
        liz.setProperty("Fanart_Image", fanart)
        
        if (not play_list) and not any(x in url for x in g_ignoreSetResolved):
            if regexs:
                if '$pyFunction:playmedia(' not in urllib.parse.unquote_plus(regexs) and 'notplayable' not in urllib.parse.unquote_plus(regexs)  :
                    liz.setProperty('IsPlayable', 'true')
            else:
                liz.setProperty('IsPlayable', 'true')
        else:
            addon_log( 'NOT setting isplayable'+url)
       
        if showcontext:
            contextMenu = []
            if showcontext == 'fav':
                contextMenu.append(
                    ('Remove from Add-on Favorites','XBMC.RunPlugin(%s?mode=6&name=%s)'
                     %(sys.argv[0], urllib.parse.quote_plus(name)))
                     )
            elif not name in FAV:
                fav_params = (
                    '%s?mode=5&name=%s&url=%s&iconimage=%s&fanart=%s&fav_mode=0'
                    %(sys.argv[0], urllib.parse.quote_plus(name), urllib.parse.quote_plus(url), urllib.parse.quote_plus(iconimage), urllib.parse.quote_plus(fanart))
                    )
                if playlist:
                    fav_params += 'playlist='+urllib.parse.quote_plus(str(playlist).replace(',','||'))
                if regexs:
                    fav_params += "&regexs="+regexs
                contextMenu.append(('Add to Add-on Favorites','XBMC.RunPlugin(%s)' %fav_params))
            liz.addContextMenuItems(contextMenu)
       
        if not playlist is None:
            if addon.getSetting('add_playlist') == "false":
                playlist_name = name.split(') ')[1]
                contextMenu_ = [
                    ('Play '+playlist_name+' PlayList','XBMC.RunPlugin(%s?mode=13&name=%s&playlist=%s)'
                     %(sys.argv[0], urllib.parse.quote_plus(playlist_name), urllib.parse.quote_plus(str(playlist).replace(',','||'))))
                     ]
                liz.addContextMenuItems(contextMenu_)
        ok=xbmcplugin.addDirectoryItem(handle=int(sys.argv[1]),url=u,listitem=liz,totalItems=total)
        return ok







def base64_decode(encoded_str):
    # Add padding if needed
    padding = len(encoded_str) % 4
    if padding != 0:
        encoded_str += '=' * (4 - padding)
    
    try:
        decoded_bytes = base64.b64decode(encoded_str)
        return decoded_bytes.decode('utf-8')
    except (base64.binascii.Error, UnicodeDecodeError) as e:
        xbmc.log(f"Error decoding Base64 string: {e}", xbmc.LOGERROR)
        return None

def parse_query(query):
    # Parse URL query string
    params = {}
    if query:
        for pair in query.split('&'):
            if '=' in pair:
                key, value = pair.split('=', 1)
                params[key] = urllib_parse.unquote_plus(value)
    return params



import base64

def base64_decode(encoded_str):
    try:
        # Add padding if needed
        padding = 4 - len(encoded_str) % 4
        if padding != 4:
            encoded_str += "=" * padding
        
        decoded_bytes = base64.b64decode(encoded_str)
        return decoded_bytes.decode('utf-8')
    except Exception as e:
        import xbmc
        xbmc.log(f"Base64 decode error: {str(e)}", xbmc.LOGERROR)
        return None

def execute_regex(regex_def):
    import xbmc, re
    import urllib.request
    import urllib.parse
    
    try:
        page_url = regex_def.get('page', '')
        expres = regex_def.get('expre', '')
        referer = regex_def.get('refer', '')
        rawpost = regex_def.get('rawpost', '')  # Get rawpost parameter
        
        xbmc.log(f"Executing regex: page={page_url}, expres={expres[:50]}...", xbmc.LOGDEBUG)
        
        if not page_url or not expres:
            xbmc.log(f"Missing page or expres in regex definition", xbmc.LOGERROR)
            return None
        
        # Fetch the page
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
            'Referer': referer if referer else page_url
        }
        
        req = urllib.request.Request(page_url, headers=headers)
        response = urllib.request.urlopen(req)
        page_content = response.read().decode('utf-8')
        xbmc.log(f"Fetched page, length: {len(page_content)}", xbmc.LOGDEBUG)
        
        # Apply the regex
        match = re.search(expres, page_content, re.DOTALL)
        if match:
            result = match.group(1)  # Get first capture group
            xbmc.log(f"Regex matched! Result: {result[:50]}...", xbmc.LOGDEBUG)
            
            # Apply rawpost substitution if present
            if rawpost and rawpost.startswith('s/'):
                xbmc.log(f"Applying rawpost: {rawpost}", xbmc.LOGDEBUG)
                parts = rawpost.split('/')
                if len(parts) >= 3:
                    find_pattern = parts[1]
                    replace_with = parts[2]
                    # Apply the substitution globally
                    result = re.sub(find_pattern, replace_with, result)
                    xbmc.log(f"Result after rawpost: {result[:50]}...", xbmc.LOGDEBUG)
            
            return result
        else:
            xbmc.log(f"Regex did not match page content", xbmc.LOGDEBUG)
            # Debug: log a snippet of the page
            xbmc.log(f"Page snippet: {page_content[:500]}", xbmc.LOGDEBUG)
            return None
            
    except Exception as e:
        xbmc.log(f"Error executing regex: {str(e)}", xbmc.LOGERROR)
        return None
        
def check_for_update():
    try:
        import urllib.request
        addon = xbmcaddon.Addon()
        current_version = addon.getAddonInfo('version')
        
        req = urllib.request.Request('https://mullafabz.xyz/version.txt')
        req.add_header('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36')
        with urllib.request.urlopen(req, timeout=5) as r:
            latest_version = r.read().decode().strip()
        
        if latest_version != current_version:
            dialog = xbmcgui.Dialog()
            update = dialog.yesno(
                'Update Required',
                'Version [COLOR yellow]' + latest_version + '[/COLOR] is required.\nYou have [COLOR red]' + current_version + '[/COLOR].\n\nUpdate now to continue?'
            )
            if update:
                import threading, zipfile
                zip_url = 'https://mullafabz.xyz/Plugins/K19/Plugins/plugin.video.Rising.Tides/plugin.video.Rising.Tides-' + latest_version + '.zip'
                tmp_zip = xbmcvfs.translatePath('special://temp/plugin.video.Rising.Tides-' + latest_version + '.zip')
                addons_path = xbmcvfs.translatePath('special://home/addons/')

                def do_update():
                    try:
                        xbmc.log('[update] Starting download from: ' + zip_url, xbmc.LOGDEBUG)
                        xbmcgui.Dialog().notification('Updating', 'Downloading v' + latest_version + '...', xbmcgui.NOTIFICATION_INFO, 10000)
                        req2 = urllib.request.Request(zip_url)
                        req2.add_header('User-Agent', 'Mozilla/5.0')
                        with urllib.request.urlopen(req2, timeout=30) as r:
                            data = r.read()
                        xbmc.log('[update] Downloaded ' + str(len(data)) + ' bytes', xbmc.LOGDEBUG)
                        with open(tmp_zip, 'wb') as f:
                            f.write(data)
                        with zipfile.ZipFile(tmp_zip, 'r') as z:
                            z.extractall(addons_path)
                        xbmc.log('[update] Extraction complete', xbmc.LOGDEBUG)
                        xbmc.executebuiltin('UpdateLocalAddons')
                        xbmc.sleep(2000)
                        xbmc.executebuiltin('NotifyAll(xbmc,onAddonChanged)')
                        xbmc.sleep(500)
                        xbmcgui.Dialog().notification('Done', 'v' + latest_version + ' installed!', xbmcgui.NOTIFICATION_INFO, 3000)
                        xbmc.sleep(1000)
                        xbmc.executebuiltin('RunAddon(plugin.video.Rising.Tides)')
                    except Exception as e:
                        xbmc.log('[update] Error: ' + str(e), xbmc.LOGERROR)
                        xbmcgui.Dialog().notification('Update Failed', str(e), xbmcgui.NOTIFICATION_ERROR, 5000)

                t = threading.Thread(target=do_update)
                t.daemon = False
                t.start()
                t.join()

            else:
                xbmcgui.Dialog().ok(
                    'Update Required',
                    'You must update to version [COLOR yellow]' + latest_version + '[/COLOR] to use this addon.'
                )

            xbmcplugin.endOfDirectory(int(sys.argv[1]), succeeded=False)
            return

    except Exception as e:
        xbmc.log('[check_for_update] Error: ' + str(e), xbmc.LOGERROR)



def playsetresolved2(url, name, iconimage, setresolved=True):
    import ast
    import json
    import binascii

    xbmc.log(f"=== PLAYSETRESOLVED2 CALLED ===", xbmc.LOGDEBUG)
    xbmc.log(f"Original URL: {url}", xbmc.LOGDEBUG)
    xbmc.log(f"Name: {name}", xbmc.LOGDEBUG)

    def hex_decode(hex_string):
        try:
            hex_string = hex_string.strip('"\'')
            return binascii.unhexlify(hex_string).decode('utf-8')
        except Exception as e:
            xbmc.log(f"Hex decoding error: {str(e)}", xbmc.LOGDEBUG)
            return hex_string

    liz = xbmcgui.ListItem(label=name if name else '')
    if iconimage:
        liz.setArt({'icon': iconimage, 'thumb': iconimage})

    regexs_data = {}
    if len(sys.argv) > 2:
        params = dict(urllib_parse.parse_qsl(sys.argv[2][1:]))
        xbmc.log(f"All parameters keys: {list(params.keys())}", xbmc.LOGDEBUG)

        if 'regexs' in params:
            regexs_str = params['regexs']
            try:
                regexs_data = ast.literal_eval(regexs_str)
                xbmc.log(f"Successfully parsed regexs data", xbmc.LOGDEBUG)
            except Exception as e:
                xbmc.log(f"Error parsing regexs: {str(e)}", xbmc.LOGERROR)

    if url and '$doregex[' in str(url):
        xbmc.log(f"Processing $doregex patterns in URL", xbmc.LOGDEBUG)
        regex_patterns = re.findall(r'\$doregex\[([^\]]+)\]', url)

        for regex_name in regex_patterns:
            regex_result = None

            if regex_name in regexs_data:
                regex_def = regexs_data[regex_name]

                if regex_def.get('page') and '$doregex[' in regex_def.get('page'):
                    nested_patterns = re.findall(r'\$doregex\[([^\]]+)\]', regex_def['page'])
                    for nested_name in nested_patterns:
                        if nested_name in regexs_data:
                            nested_result = execute_regex(regexs_data[nested_name])
                            if nested_result:
                                regex_def['page'] = regex_def['page'].replace(f'$doregex[{nested_name}]', nested_result)

                regex_result = execute_regex(regex_def)

            if regex_result:
                pattern_to_replace = f'$doregex[{regex_name}]'
                hex_pattern = re.compile(r'^[0-9a-fA-F]+$')
                if hex_pattern.match(regex_result):
                    decoded_result = hex_decode(regex_result)
                    url = url.replace(pattern_to_replace, decoded_result)
                else:
                    url = url.replace(pattern_to_replace, regex_result)
            else:
                xbmc.log(f"Could not execute regex: {regex_name}", xbmc.LOGERROR)

    # ------------------------------------------------------------------
    # Streamed.pk API category redirect — opens as a directory listing
    # ------------------------------------------------------------------
    if 'streamed.pk/api/matches/' in str(url):
        xbmc.log(f"Detected streamed category URL, activating window", xbmc.LOGDEBUG)
        plugin_url = 'plugin://plugin.video.Rising.Tides/?url=' + urllib_parse.quote_plus(url) + '&mode=60'

        def delayed_activate():
            xbmc.executebuiltin('Dialog.Close(all,true)')
            xbmc.sleep(300)
            xbmc.executebuiltin(f'ActivateWindow(Videos,{plugin_url},return)')

        import threading
        threading.Thread(target=delayed_activate, daemon=True).start()
        xbmcplugin.endOfDirectory(int(sys.argv[1]), succeeded=False, updateListing=False, cacheToDisc=False)
        return

    # ------------------------------------------------------------------
    # PPV.to all categories redirect
    # ------------------------------------------------------------------
    if 'api.ppv.to/api/streams' in str(url):
        xbmc.log(f"Detected PPV.to streams URL, activating categories window", xbmc.LOGDEBUG)
        plugin_url = 'plugin://plugin.video.Rising.Tides/?url=' + urllib_parse.quote_plus(url) + '&mode=62'

        def _ppv_activate():
            xbmc.executebuiltin('Dialog.Close(all,true)')
            xbmc.sleep(300)
            xbmc.executebuiltin(f'ActivateWindow(Videos,{plugin_url},return)')

        import threading
        threading.Thread(target=_ppv_activate, daemon=True).start()
        xbmcplugin.endOfDirectory(int(sys.argv[1]), succeeded=False, updateListing=False, cacheToDisc=False)
        return

    # ------------------------------------------------------------------
    # PPV.to specific category redirect (ppvcategory:Basketball etc.)
    # ------------------------------------------------------------------
    if str(url).startswith('ppvcategory:'):
        category = str(url)[len('ppvcategory:'):]
        xbmc.log(f"Detected PPV category: {category}", xbmc.LOGDEBUG)
        plugin_url = 'plugin://plugin.video.Rising.Tides/?url=' + urllib_parse.quote_plus(category) + '&mode=61'

        def _ppvcat_activate():
            xbmc.executebuiltin('Dialog.Close(all,true)')
            xbmc.sleep(300)
            xbmc.executebuiltin(f'ActivateWindow(Videos,{plugin_url},return)')

        import threading
        threading.Thread(target=_ppvcat_activate, daemon=True).start()
        xbmcplugin.endOfDirectory(int(sys.argv[1]), succeeded=False, updateListing=False, cacheToDisc=False)
        return

    # ------------------------------------------------------------------
    # PPV.to specific game redirect (ppvfilter:game etc.)
    # ------------------------------------------------------------------
    if str(url).startswith('ppvfilter:'):
        filter_str = str(url)[len('ppvfilter:'):]
        getPPVFiltered(filter_str, FANART)
        return

    # ------------------------------------------------------------------
    # cdnchannels: format — fetch and list CDN channels
    # ------------------------------------------------------------------
    if str(url).startswith('cdnchannels:'):
        json_url = str(url)[len('cdnchannels:'):]
        plugin_url = 'plugin://plugin.video.Rising.Tides/?url=' + urllib_parse.quote_plus(json_url) + '&mode=64'
        def _cdn_activate():
            xbmc.executebuiltin('Dialog.Close(all,true)')
            xbmc.sleep(300)
            xbmc.executebuiltin(f'ActivateWindow(Videos,{plugin_url},return)')
        import threading
        threading.Thread(target=_cdn_activate, daemon=True).start()
        xbmcplugin.endOfDirectory(int(sys.argv[1]), succeeded=False, updateListing=False, cacheToDisc=False)
        return
    # ------------------------------------------------------------------
    # sources: format — fetch streams per source and show grouped picker
    # ------------------------------------------------------------------
    if str(url).startswith('sources:'):
        import json, urllib.request
        from collections import OrderedDict
        sources = json.loads(url[len('sources:'):])
        ua = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'
        grouped = OrderedDict()
        for src_obj in sources:
            src = src_obj['source']
            sid = src_obj['id']
            try:
                req = urllib.request.Request('https://streamed.pk/api/stream/' + src + '/' + sid)
                req.add_header('User-Agent', ua)
                with urllib.request.urlopen(req, timeout=8) as r:
                    streams = json.loads(r.read().decode())
            except:
                streams = []
            for s in streams:
                if src not in grouped:
                    grouped[src] = []
                grouped[src].append((sid, s))

        labels = []
        links = []
        for src, src_streams in grouped.items():
            labels.append('[COLOR cyan]── ' + src.upper() + ' ──[/COLOR]')
            links.append(None)
            for sid, s in src_streams:
                stream_no = s.get('streamNo', 1)
                hd = s.get('hd', False)
                viewers = s.get('viewers', 0)
                hd_tag = '[COLOR yellow][HD][/COLOR]' if hd else '[COLOR gray][SD][/COLOR]'
                viewers_tag = (' [COLOR red]' + str(viewers) + ' viewers[/COLOR]') if viewers > 0 else ''
                label = '  [COLOR white][B]Stream ' + str(stream_no) + '[/B][/COLOR] ' + hd_tag + viewers_tag
                base = 'https://cdn.damitv.live/iptv-proxy/streamed/play?source=' + src + '&id=' + sid + '&streamNo=' + str(stream_no)
                labels.append(label)
                links.append(base + '|User-Agent=' + ua)

        if not links:
            xbmcgui.Dialog().notification('No Streams', 'No streams available', xbmcgui.NOTIFICATION_WARNING)
            xbmcplugin.endOfDirectory(int(sys.argv[1]), succeeded=False)
            return

        idx = xbmcgui.Dialog().select('Select Stream', labels)
        if idx < 0 or links[idx] is None:
            xbmcplugin.endOfDirectory(int(sys.argv[1]), succeeded=False)
            return

        playsetresolved2(links[idx], name, iconimage, setresolved)
        return

    # ------------------------------------------------------------------
    # Streamed.pk streams API — fetch real streams and show picker
    # ------------------------------------------------------------------
    if 'streamed.pk/api/stream/' in str(url).split('|')[0]:
        import json, urllib.request
        ua = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'
        req = urllib.request.Request(str(url).split('|')[0])
        req.add_header('User-Agent', ua)
        with urllib.request.urlopen(req, timeout=8) as r:
            streams = json.loads(r.read().decode())

        from collections import OrderedDict
        grouped = OrderedDict()
        for s in streams:
            src = s.get('source', 'admin')
            if src not in grouped:
                grouped[src] = []
            grouped[src].append(s)

        labels = []
        links = []
        for src, src_streams in grouped.items():
            labels.append('[COLOR cyan]── ' + src.upper() + ' ──[/COLOR]')
            links.append(None)
            for s in src_streams:
                sid = s.get('id', '')
                stream_no = s.get('streamNo', 1)
                hd = s.get('hd', False)
                viewers = s.get('viewers', 0)
                hd_tag = '[COLOR yellow][HD][/COLOR]' if hd else '[COLOR gray][SD][/COLOR]'
                viewers_tag = (' [COLOR red]' + str(viewers) + ' viewers[/COLOR]') if viewers > 0 else ''
                label = '  [COLOR white][B]Stream ' + str(stream_no) + '[/B][/COLOR] ' + hd_tag + viewers_tag
                base = 'https://cdn.damitv.live/iptv-proxy/streamed/play?source=' + src + '&id=' + sid + '&streamNo=' + str(stream_no)
                labels.append(label)
                links.append(base + '|User-Agent=' + ua)

        if not links:
            xbmcgui.Dialog().notification('No Streams', 'No streams available', xbmcgui.NOTIFICATION_WARNING)
            xbmcplugin.endOfDirectory(int(sys.argv[1]), succeeded=False)
            return

        dialog = xbmcgui.Dialog()
        idx = dialog.select('Select Stream', labels)
        if idx < 0 or links[idx] is None:
            xbmcplugin.endOfDirectory(int(sys.argv[1]), succeeded=False)
            return

        url = links[idx]
        # falls through to playback below

    # ------------------------------------------------------------------
    # matchid: format — fetch match, show stream picker, play via proxy
    # ------------------------------------------------------------------
    if str(url).startswith('matchid:'):
        import json, urllib.request, threading
        from collections import OrderedDict
        match_id = url[len('matchid:'):]
        ua = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'

        xbmc.executebuiltin('ActivateWindow(busydialognocancel)')

        grouped = OrderedDict()
        lock = threading.Lock()

        def fetch_source(src):
            try:
                req = urllib.request.Request('https://streamed.pk/api/stream/' + src + '/' + match_id)
                req.add_header('User-Agent', ua)
                with urllib.request.urlopen(req, timeout=3) as r:
                    streams = json.loads(r.read().decode())
                with lock:
                    for s in streams:
                        if src not in grouped:
                            grouped[src] = []
                        grouped[src].append((match_id, s))
            except:
                pass

        threads = [threading.Thread(target=fetch_source, args=(src,)) for src in ['admin', 'delta', 'echo', 'golf']]
        for t in threads:
            t.start()
        for t in threads:
            t.join()

        if not grouped:
            try:
                req = urllib.request.Request('https://streamed.pk/api/matches/all')
                req.add_header('User-Agent', ua)
                with urllib.request.urlopen(req, timeout=10) as r:
                    all_matches = json.loads(r.read().decode())
                match = next((m for m in all_matches if m.get('id') == match_id), None)
                if match:
                    for src_obj in match.get('sources', []):
                        src = src_obj['source']
                        sid = src_obj['id']
                        try:
                            req = urllib.request.Request('https://streamed.pk/api/stream/' + src + '/' + sid)
                            req.add_header('User-Agent', ua)
                            with urllib.request.urlopen(req, timeout=5) as r:
                                streams = json.loads(r.read().decode())
                            for s in streams:
                                if src not in grouped:
                                    grouped[src] = []
                                grouped[src].append((sid, s))
                        except:
                            continue
            except:
                pass

        xbmc.executebuiltin('Dialog.Close(busydialognocancel)')
        xbmc.log('[matchid] grouped sources: ' + str(list(grouped.keys())), xbmc.LOGDEBUG)

        if not grouped:
            xbmcgui.Dialog().notification('No Streams', 'No streams found', xbmcgui.NOTIFICATION_WARNING, 3000)
            return

        labels = []
        links = []
        for src, src_streams in grouped.items():
            labels.append('[COLOR cyan]── ' + src.upper() + ' ──[/COLOR]')
            links.append(None)
            for sid, s in src_streams:
                stream_no = s.get('streamNo', 1)
                hd = s.get('hd', False)
                viewers = s.get('viewers', 0)
                hd_tag = '[COLOR yellow][HD][/COLOR]' if hd else '[COLOR gray][SD][/COLOR]'
                viewers_tag = (' [COLOR red]' + str(viewers) + ' viewers[/COLOR]') if viewers > 0 else ''
                label = '  [COLOR white][B]Stream ' + str(stream_no) + '[/B][/COLOR] ' + hd_tag + viewers_tag
                base = 'https://cdn.damitv.live/iptv-proxy/streamed/play?source=' + src + '&id=' + sid + '&streamNo=' + str(stream_no)
                labels.append(label)
                links.append(base + '|User-Agent=' + ua)

        if not links:
            xbmcgui.Dialog().notification('No Streams', 'No streams available', xbmcgui.NOTIFICATION_WARNING)
            return

        idx = xbmcgui.Dialog().select('Select Stream', labels)
        if idx < 0 or links[idx] is None:
            return

        selected_url = links[idx]
        play_liz = xbmcgui.ListItem(label=name if name else '')
        play_liz.setMimeType('application/vnd.apple.mpegurl')
        play_liz.setContentLookup(False)
        play_liz.setProperty('inputstream', 'inputstream.adaptive')
        play_liz.setProperty('inputstream.adaptive.manifest_type', 'hls')
        play_liz.setProperty('inputstream.adaptive.stream_headers', 'User-Agent=' + ua)
        play_liz.setPath(selected_url)
        xbmc.executebuiltin('Playlist.Clear')
        xbmc.sleep(100)
        xbmc.Player().play(selected_url, play_liz)
        return

    # ------------------------------------------------------------------
    # Sublink / LISTNAME format — show source picker dialog
    # ------------------------------------------------------------------
    if str(url).startswith('sublink:') or str(url).startswith('LISTNAME:'):
        xbmc.log(f"Detected sublink format, showing source picker", xbmc.LOGDEBUG)
        parts = [part.strip() for part in str(url).split('#') if part.strip()]
        links = []
        labels = []
        for part in parts:
            if 'LISTNAME:' in part and 'LISTSOURCE:' in part:
                label_match = re.search(r'LISTNAME:(.*?)::LISTSOURCE:(.*?)::', part, re.DOTALL)
                if label_match:
                    labels.append(label_match.group(1).strip())
                    links.append(label_match.group(2).strip())
            else:
                url_part = part.replace('sublink:', '')
                links.append(url_part)
                labels.append(str(len(links)))

        if not links:
            return
        if len(links) == 1:
            playsetresolved2(links[0], name, iconimage, setresolved)
        else:
            dialog = xbmcgui.Dialog()
            idx = dialog.select('Select A Source', labels)
            if idx >= 0:
                playsetresolved2(links[idx], name, iconimage, setresolved)
        return

    xbmc.log(f"Checking for hex encoding in URL: {url[:100]}...", xbmc.LOGDEBUG)

    url_str = str(url)
    if '|' in url_str:
        url_before_pipe = url_str.split('|')[0].strip()
        headers_part = '|' + '|'.join(url_str.split('|')[1:])
    else:
        url_before_pipe = url_str.strip()
        headers_part = ''

    hex_pattern = re.compile(r'^[0-9a-fA-F]+$')
    if hex_pattern.match(url_before_pipe):
        try:
            decoded_url = hex_decode(url_before_pipe)
            url = decoded_url + headers_part if headers_part else decoded_url
        except Exception as e:
            xbmc.log(f"Failed to hex decode: {str(e)}", xbmc.LOGERROR)
    else:
        hex_matches = re.findall(r'([0-9a-fA-F]{20,})', url_before_pipe)
        for hex_match in hex_matches:
            if len(hex_match) > 30:
                try:
                    decoded_part = hex_decode(hex_match)
                    if '://' in decoded_part:
                        url_before_pipe = url_before_pipe.replace(hex_match, decoded_part)
                        url = url_before_pipe + headers_part if headers_part else url_before_pipe
                        break
                except Exception as e:
                    xbmc.log(f"Failed to decode hex substring: {str(e)}", xbmc.LOGDEBUG)

    headers = {}
    headers_part = ""

    if '|' in str(url):
        url_parts = str(url).split('|')
        if len(url_parts) > 1:
            url_without_headers = url_parts[0]
            headers_str = '|'.join(url_parts[1:])

            xbmc.log(f"URL without headers: {url_without_headers}", xbmc.LOGDEBUG)
            xbmc.log(f"Headers string: {headers_str}", xbmc.LOGDEBUG)

            for pair in headers_str.split('&'):
                if '=' in pair:
                    try:
                        key, value = pair.split('=', 1)
                        headers[key.strip()] = value.strip()
                    except Exception as e:
                        xbmc.log(f"Error parsing header: {str(e)}", xbmc.LOGERROR)

            headers_part = '|' + headers_str
            url = url_without_headers

    # ------------------------------------------------------------------
    # Branch 0: DamiTV proxy rewrite
    # ------------------------------------------------------------------
    if 'cdn.damitv.live' in url:
        url = url.strip()
        import urllib.parse as _uparse
        url = _uparse.unquote(url).replace(' ', '%20')
        user_agent = headers.pop('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36')
        direct_url = url + '|User-Agent=' + user_agent
        liz.setMimeType('application/vnd.apple.mpegurl')
        liz.setContentLookup(False)
        liz.setProperty('inputstream', 'inputstream.adaptive')
        liz.setProperty('inputstream.adaptive.manifest_type', 'hls')
        liz.setProperty('inputstream.adaptive.stream_headers', 'User-Agent=' + user_agent)
        liz.setPath(direct_url)
        xbmcplugin.setResolvedUrl(int(sys.argv[1]), True, liz)
        return

    # ------------------------------------------------------------------
    # Branch 1: ClearKey DASH (key_id + optional key_val)
    # ------------------------------------------------------------------
    if 'key_id' in headers and ('key_val' in headers or ':' in headers.get('key_id', '')):
        key_id  = headers.pop('key_id')
        key_val = headers.pop('key_val', '')

        if ':' in key_id:
            drm_legacy = 'org.w3.clearkey|{}'.format(key_id)
        else:
            drm_legacy = 'org.w3.clearkey|{}:{}'.format(key_id, key_val)

        xbmc.log(f"[ClearKey] Setting drm_legacy: {drm_legacy}", xbmc.LOGDEBUG)

        remaining_headers = '&'.join(['{}={}'.format(k, v) for k, v in headers.items()])

        liz.setMimeType('application/dash+xml')
        liz.setContentLookup(False)
        liz.setProperty('inputstream',                       'inputstream.adaptive')
        liz.setProperty('inputstream.adaptive.drm_legacy',  drm_legacy)
        if remaining_headers:
            liz.setProperty('inputstream.adaptive.stream_headers',   remaining_headers)
            liz.setProperty('inputstream.adaptive.manifest_headers', remaining_headers)
        liz.setProperty('inputstream.adaptive.initial_stream_select', '2')
        liz.setPath(url)

        xbmcplugin.setResolvedUrl(int(sys.argv[1]), True, liz)
        return

    # ------------------------------------------------------------------
    # Branch 2: AES-128 HLS with Bearer-auth license server
    # ------------------------------------------------------------------
    if 'license_url' in headers and 'license_auth' in headers:
        import urllib.request as _ureq
        import urllib.parse   as _upar

        license_url  = headers.pop('license_url')
        license_auth = headers.pop('license_auth')
        license_url = license_url.replace('%26', '&')

        try:
            req = _ureq.Request(license_url)
            req.add_header('authorization', license_auth)
            req.add_header('User-Agent', 'Mozilla/5.0')
            with _ureq.urlopen(req, timeout=10) as resp:
                key_bytes = resp.read()
            key_hex = key_bytes.hex()
        except Exception as e:
            xbmc.log(f"[AES128] Key fetch failed: {str(e)}", xbmc.LOGERROR)
            xbmcplugin.setResolvedUrl(int(sys.argv[1]), False, liz)
            return

        drm_legacy = 'org.w3.clearkey|{}:{}'.format(key_hex[:32], key_hex)
        liz.setMimeType('application/vnd.apple.mpegurl')
        liz.setContentLookup(False)
        liz.setProperty('inputstream', 'inputstream.adaptive')
        liz.setProperty('inputstream.adaptive.drm_legacy', drm_legacy)
        liz.setPath(url)
        xbmcplugin.setResolvedUrl(int(sys.argv[1]), True, liz)
        return

    # ------------------------------------------------------------------
    # Remaining branches (JSON/DRM, Base64, generic HLS/DASH)
    # ------------------------------------------------------------------
    xbmc.log(f"Checking for JSON/DRM data in URL", xbmc.LOGDEBUG)

    json_processed = False
    if ('manifestUrl' in str(url) and 'clearkey' in str(url)) or ('"manifestUrl"' in str(url) and '"clearkey"' in str(url)):
        try:
            json_match = re.search(r'\{[^{}]*(?:\{[^{}]*\}[^{}]*)*\}', str(url))
            if json_match:
                json_str = json_match.group(0)
                data = json.loads(json_str)
                manifest_url = data.get('manifestUrl', '')
                clearkey_str = data.get('clearkey', '{}')

                if manifest_url and clearkey_str:
                    clearkey_str = clearkey_str.replace('\\"', '"').replace('\\u0026', '&')
                    clearkey_data = json.loads(clearkey_str)

                    if clearkey_data and isinstance(clearkey_data, dict):
                        key_id = list(clearkey_data.keys())[0]
                        key_value = clearkey_data[key_id]
                        license_key = f"{key_id}:{key_value}"

                        url = manifest_url + (headers_part if headers_part else '')
                        liz.setProperty('inputstream.adaptive.license_type', 'com.widevine.alpha')
                        liz.setProperty('inputstream.adaptive.license_key', f'{license_key}|R{{SSM}}')
                        json_processed = True

        except Exception as e:
            xbmc.log(f"Error processing JSON DRM data: {str(e)}", xbmc.LOGERROR)

    if not json_processed and 'aHR0cHM6Ly9'.lower() in str(url).lower() and not ('manifestUrl' in str(url) or '.mpd' in str(url).lower()):
        xbmc.log(f"FOUND Base64 prefix! Starting decoding...", xbmc.LOGDEBUG)

        url_lower = str(url).lower()
        base64_start = url_lower.find('ahr0chm6ly9')

        if base64_start != -1:
            encoded_str = str(url)[base64_start:]
            pipe_pos = encoded_str.find('|')
            if pipe_pos != -1:
                encoded_str = encoded_str[:pipe_pos]

            decoded_url = base64_decode(encoded_str)
            if decoded_url:
                url = decoded_url + headers_part if headers_part else decoded_url
    else:
        xbmc.log(f"No Base64 prefix found or URL is DASH manifest", xbmc.LOGDEBUG)

    if '|' in str(url) and not headers:
        url_parts = str(url).split('|')
        url = url_parts[0]

        if len(url_parts) > 1:
            headers_str = '|'.join(url_parts[1:])
            for pair in headers_str.split('&'):
                if '|' in pair:
                    for sub_pair in pair.split('|'):
                        if '=' in sub_pair:
                            try:
                                key, value = sub_pair.split('=', 1)
                                headers[key.strip()] = value.strip()
                            except Exception as e:
                                xbmc.log(f"Error parsing header sub-pair '{sub_pair}': {str(e)}", xbmc.LOGERROR)
                elif '=' in pair:
                    try:
                        key, value = pair.split('=', 1)
                        headers[key.strip()] = value.strip()
                    except Exception as e:
                        xbmc.log(f"Error parsing header pair '{pair}': {str(e)}", xbmc.LOGERROR)

    # Build header string and apply to ISA properties
    header_string = ''
    if headers:
        header_string = '&'.join([f'{k}={v}' for k, v in headers.items()])
        liz.setProperty('inputstream.adaptive.stream_headers',   header_string)
        liz.setProperty('inputstream.adaptive.manifest_headers', header_string)
        xbmc.log(f"Set headers: {header_string}", xbmc.LOGDEBUG)

    url_lower = str(url).lower()
    if '.mpd' in url_lower or 'format=mpd' in url_lower:
        liz.setMimeType('application/dash+xml')
        liz.setContentLookup(False)
        liz.setProperty('inputstream', 'inputstream.adaptive')
        liz.setProperty('inputstream.adaptive.manifest_type', 'mpd')
        xbmc.log(f"Detected DASH stream", xbmc.LOGDEBUG)
    elif '.m3u8' in url_lower:
        liz.setMimeType('application/vnd.apple.mpegurl')
        liz.setContentLookup(False)
        liz.setProperty('inputstream', 'inputstream.adaptive')
        liz.setProperty('inputstream.adaptive.manifest_type', 'hls')
        xbmc.log(f"Detected HLS stream (.m3u8)", xbmc.LOGDEBUG)
    else:
        liz.setMimeType('application/vnd.apple.mpegurl')
        liz.setContentLookup(False)
        xbmc.log(f"Detected HLS stream - using native player", xbmc.LOGDEBUG)

    if '|' in str(url):
        url = str(url).split('|')[0]

    final_url = url + '|' + header_string if header_string else url
    liz.setPath(final_url)

    xbmc.log(f"Final URL: {final_url}", xbmc.LOGDEBUG)
    xbmc.log(f"Headers dictionary: {headers}", xbmc.LOGDEBUG)
    xbmc.log(f"Header string: {header_string}", xbmc.LOGDEBUG)

    if not setresolved:
        xbmc.Player().play(url)
    else:
        xbmcplugin.setResolvedUrl(int(sys.argv[1]), True, liz)

# Add this function to default.py

def getStreamedCategory(url, fanart):
    import json, urllib.request, urllib.parse, time, datetime

    try:
        req = urllib.request.Request(url)
        req.add_header('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36')
        req.add_header('Referer', 'https://streamed.pk/')
        with urllib.request.urlopen(req, timeout=10) as r:
            data = json.loads(r.read().decode('utf-8'))
    except Exception as e:
        xbmc.log(f"[getStreamedCategory] Error fetching {url}: {e}", xbmc.LOGERROR)
        xbmcgui.Dialog().notification('StreamedPK', f'Error: {e}', xbmcgui.NOTIFICATION_ERROR, 5000)
        xbmcplugin.endOfDirectory(int(sys.argv[1]))
        return

    now_ms = int(time.time() * 1000)

    for match in data:
        try:
            title   = match.get('title', 'Unknown')
            match_id = match.get('id', '')
            date_ms = match.get('date', 0)
            poster  = match.get('poster', '')
            sources = match.get('sources', [])
            popular = match.get('popular', False)

            if not sources or not match_id:
                continue

            if date_ms:
                dt = datetime.datetime.utcfromtimestamp(date_ms / 1000)
                time_str = dt.strftime('%H:%M UTC')
                is_live = abs(date_ms - now_ms) < 3 * 3600 * 1000
                if is_live:
                    label = f'[COLOR red][B]● LIVE[/B][/COLOR] [COLOR white][B]{title}[/B][/COLOR]'
                elif date_ms > now_ms:
                    label = f'[COLOR cyan]{time_str}[/COLOR] [COLOR white][B]{title}[/B][/COLOR]'
                else:
                    label = f'[COLOR gray]{time_str}[/COLOR] [COLOR white]{title}[/COLOR]'
            else:
                label = f'[COLOR white][B]{title}[/B][/COLOR]'

            if popular:
                label = f'[COLOR gold]★[/COLOR] {label}'

            thumbnail = f'https://streamed.pk{poster}' if poster else ''

            params = urllib.parse.urlencode({'url': 'matchid:' + match_id, 'mode': '14'})
            plugin_url = sys.argv[0] + '?' + params

            liz = xbmcgui.ListItem(label)
            liz.setArt({'thumb': thumbnail, 'fanart': fanart})
            liz.setInfo('video', {'title': label})
            liz.setProperty('IsPlayable', 'true')

            xbmcplugin.addDirectoryItem(int(sys.argv[1]), plugin_url, liz, isFolder=False)

        except Exception as e:
            xbmc.log(f"[getStreamedCategory] Error processing match: {e}", xbmc.LOGERROR)
            continue

    xbmcplugin.endOfDirectory(int(sys.argv[1]))

def getPPVStreams(category, fanart):
    import json, urllib.request, datetime
    ua = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'
    try:
        req = urllib.request.Request('https://api.ppv.to/api/streams')
        req.add_header('User-Agent', ua)
        with urllib.request.urlopen(req, timeout=10) as r:
            data = json.loads(r.read().decode('utf-8'))
    except Exception as e:
        xbmc.log(f'[getPPVStreams] Error: {e}', xbmc.LOGERROR)
        xbmcplugin.endOfDirectory(int(sys.argv[1]))
        return

    # Find the matching category object
    cat_obj = next((c for c in data.get('streams', []) if c.get('category') == category), None)
    if not cat_obj:
        xbmc.log(f'[getPPVStreams] Category "{category}" not found', xbmc.LOGERROR)
        xbmcplugin.endOfDirectory(int(sys.argv[1]))
        return

    streams = cat_obj.get('streams', [])
    total = len(streams)

    for s in streams:
        try:
            title     = s.get('name', 'Unknown')
            tag       = s.get('tag', '')
            iframe    = s.get('iframe', '')
            poster    = s.get('poster', '')
            viewers   = s.get('viewers', '0')
            starts_at = s.get('starts_at', 0)

            if not iframe:
                continue

            if starts_at:
                dt       = datetime.datetime.utcfromtimestamp(starts_at)
                time_str = dt.strftime('%H:%M UTC')
                date_str = dt.strftime('%a %d %b')
            else:
                time_str = ''
                date_str = ''

            label = ''
            if time_str:
                label += f'[COLOR cyan][B]{time_str}[/B][/COLOR] - '
            label += f'[COLOR white][B]{title}[/B][/COLOR]'
            if date_str:
                label += f' [COLOR cyan][B]{date_str}[/B][/COLOR]'
            if tag:
                label += f' [COLOR yellow][B][{tag}][/B][/COLOR]'
            if str(viewers) != '0':
                label += f' [COLOR orange][B]{viewers} viewers[/B][/COLOR]'

            play_url = 'https://cdn.damitv.live/ppv-extract/play?url=' + urllib.parse.quote(iframe, safe='') + '|User-Agent=' + ua

            liz = xbmcgui.ListItem(label)
            liz.setArt({'thumb': poster, 'fanart': fanart})
            liz.setInfo('video', {'title': label})
            liz.setProperty('IsPlayable', 'true')

            params = urllib.parse.urlencode({'url': play_url, 'mode': '14'})
            plugin_url = sys.argv[0] + '?' + params

            xbmcplugin.addDirectoryItem(int(sys.argv[1]), plugin_url, liz, isFolder=False, totalItems=total)

            # Also add substreams if any
            for sub in s.get('substreams', []):
                sub_iframe = sub.get('iframe', '')
                sub_tag    = sub.get('tag', '')
                if not sub_iframe:
                    continue
                sub_label = f'[COLOR cyan]{time_str}[/COLOR] - ' if time_str else ''
                sub_label += f'[COLOR pink][B]{title}[/B][/COLOR]'
                if date_str:
                    sub_label += f' [COLOR cyan]{date_str}[/COLOR]'
                sub_label += f' [COLOR yellow][{sub_tag}][/COLOR]'

                sub_play_url = 'https://cdn.damitv.live/ppv-extract/play?url=' + urllib.parse.quote(sub_iframe, safe='') + '|User-Agent=' + ua
                sub_liz = xbmcgui.ListItem(sub_label)
                sub_liz.setArt({'thumb': poster, 'fanart': fanart})
                sub_liz.setInfo('video', {'title': sub_label})
                sub_liz.setProperty('IsPlayable', 'true')
                sub_params = urllib.parse.urlencode({'url': sub_play_url, 'mode': '14'})
                xbmcplugin.addDirectoryItem(int(sys.argv[1]), sys.argv[0] + '?' + sub_params, sub_liz, isFolder=False, totalItems=total)

        except Exception as e:
            xbmc.log(f'[getPPVStreams] Error on stream: {e}', xbmc.LOGERROR)
            continue

    xbmcplugin.endOfDirectory(int(sys.argv[1]))

def getPPVCategories(fanart):
    import json, urllib.request
    try:
        req = urllib.request.Request('https://api.ppv.to/api/streams')
        req.add_header('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36')
        with urllib.request.urlopen(req, timeout=10) as r:
            data = json.loads(r.read().decode('utf-8'))
    except Exception as e:
        xbmc.log(f'[getPPVCategories] Error: {e}', xbmc.LOGERROR)
        xbmcplugin.endOfDirectory(int(sys.argv[1]))
        return

    for cat_obj in data.get('streams', []):
        cat = cat_obj.get('category', '')
        count = len(cat_obj.get('streams', []))
        if not cat:
            continue
        label = f'[COLOR cyan][B]{cat}[/B][/COLOR] [COLOR gray]({count})[/COLOR]'
        params = urllib.parse.urlencode({'url': cat, 'mode': '61'})
        plugin_url = sys.argv[0] + '?' + params
        liz = xbmcgui.ListItem(label)
        liz.setArt({'thumb': icon, 'fanart': fanart})
        liz.setInfo('video', {'title': cat})
        xbmcplugin.addDirectoryItem(int(sys.argv[1]), plugin_url, liz, isFolder=True)

    xbmcplugin.endOfDirectory(int(sys.argv[1]))

def getCDNChannels(url, fanart):
    import json, urllib.request
    ua = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'
    try:
        req = urllib.request.Request(url)
        req.add_header('User-Agent', ua)
        with urllib.request.urlopen(req, timeout=10) as r:
            raw = r.read().decode('utf-8')
    except Exception as e:
        xbmc.log(f'[getCDNChannels] Error: {e}', xbmc.LOGERROR)
        xbmcplugin.endOfDirectory(int(sys.argv[1]))
        return

    # Handle both JSON array and JSONL (one object per line)
    channels = []
    raw = raw.strip()
    try:
        parsed = json.loads(raw)
        if isinstance(parsed, list):
            channels = parsed
        else:
            # Top-level object with a channels array
            channels = parsed.get('channels', parsed.get('streams', [parsed]))
    except json.JSONDecodeError:
        for line in raw.splitlines():
            line = line.strip().rstrip(',')
            if line:
                try:
                    channels.append(json.loads(line))
                except:
                    continue

    total = len(channels)
    for ch in channels:
        try:
            name       = ch.get('name', 'Unknown').strip()
            logo       = ch.get('logo', '')
            default_url = ch.get('defaultUrl', '')
            qualities  = ch.get('qualities', [])
            country    = ch.get('country', {})
            flag       = country.get('flag', '')

            if not default_url and not qualities:
                continue

            # Build label
            country_code = country.get('code', '').upper()
            if country_code:
                label = f'[COLOR orange][B][{country_code}][/B][/COLOR] [COLOR white][B]{name}[/B][/COLOR]'
            else:
                label = f'[COLOR white][B]{name}[/B][/COLOR]'

            # If multiple qualities, build sublinks picker
            if len(qualities) > 1:
                sublink_parts = []
                for q in qualities:
                    q_label = q.get('quality', 'Stream')
                    q_url   = q.get('url', '')
                    if q_url:
                        sublink_parts.append(
                            f'LISTNAME:[COLOR white][B]{q_label}[/B][/COLOR]::LISTSOURCE:{q_url}|User-Agent={ua}::'
                        )
                play_url = '#'.join(sublink_parts)
            else:
                play_url = (qualities[0].get('url', default_url) if qualities else default_url) + '|User-Agent=' + ua

            liz = xbmcgui.ListItem(label)
            liz.setArt({'thumb': logo if logo else icon, 'fanart': fanart})
            liz.setInfo('video', {'title': label})
            liz.setProperty('IsPlayable', 'true')

            params = urllib.parse.urlencode({'url': play_url, 'mode': '14'})
            plugin_url = sys.argv[0] + '?' + params

            xbmcplugin.addDirectoryItem(int(sys.argv[1]), plugin_url, liz, isFolder=False, totalItems=total)

        except Exception as e:
            xbmc.log(f'[getCDNChannels] Error on channel: {e}', xbmc.LOGERROR)
            continue

    xbmcplugin.endOfDirectory(int(sys.argv[1]))

def getPPVFiltered(filter_str, fanart):
    import json, urllib.request
    ua = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'
    try:
        req = urllib.request.Request('https://api.ppv.to/api/streams')
        req.add_header('User-Agent', ua)
        with urllib.request.urlopen(req, timeout=10) as r:
            data = json.loads(r.read().decode('utf-8'))
    except Exception as e:
        xbmc.log(f'[getPPVFiltered] Error: {e}', xbmc.LOGERROR)
        xbmcgui.Dialog().notification('PPV', f'Error: {e}', xbmcgui.NOTIFICATION_ERROR, 3000)
        return

    matched = []
    for cat_obj in data.get('streams', []):
        for s in cat_obj.get('streams', []):
            uri  = s.get('uri_name', '')
            name = s.get('name', '')
            if filter_str.lower() in uri.lower() or filter_str.lower() in name.lower():
                matched.append(s)

    if not matched:
        xbmcgui.Dialog().notification('PPV', 'No streams found', xbmcgui.NOTIFICATION_WARNING, 3000)
        return

    if len(matched) == 1:
        chosen = matched[0]
    else:
        labels = []
        for s in matched:
            label = s.get('name', 'Unknown')
            tag = s.get('tag', '')
            viewers = s.get('viewers', '0')
            if tag:
                label += f' [{tag}]'
            if str(viewers) != '0':
                label += f' - {viewers} viewers'
            labels.append(label)
        idx = xbmcgui.Dialog().select('Select Event', labels)
        if idx < 0:
            return
        chosen = matched[idx]

    iframe = chosen.get('iframe', '')
    if not iframe:
        xbmcgui.Dialog().notification('PPV', 'No stream URL', xbmcgui.NOTIFICATION_WARNING, 3000)
        return

    direct_url = 'https://cdn.damitv.live/ppv-extract/play?url=' + urllib.parse.quote(iframe, safe='') + '|User-Agent=' + ua
    play_liz = xbmcgui.ListItem(label=chosen.get('name', ''))
    play_liz.setArt({'thumb': chosen.get('poster', '')})
    play_liz.setMimeType('application/vnd.apple.mpegurl')
    play_liz.setContentLookup(False)
    play_liz.setProperty('inputstream', 'inputstream.adaptive')
    play_liz.setProperty('inputstream.adaptive.manifest_type', 'hls')
    play_liz.setProperty('inputstream.adaptive.stream_headers', 'User-Agent=' + ua)
    play_liz.setPath(direct_url)
    xbmc.executebuiltin('Playlist.Clear')
    xbmc.sleep(100)
    xbmc.Player().play(direct_url, play_liz)

#17
def playsetresolved(url,name,iconimage,setresolved=True):
    if setresolved:
        liz = xbmcgui.ListItem(name)
        liz.setArt({"thumb":iconimage})

        liz.setInfo(type='Video', infoLabels={'Title':name})
        liz.setProperty("IsPlayable","true")
        liz.setPath(str(url))
        xbmcplugin.setResolvedUrl(int(sys.argv[1]), True, liz)
        #xbmc.Player().play(url, liz)
    else:
        xbmc.executebuiltin('XBMC.RunPlugin('+url+')')      

xbmcplugin.setContent(int(sys.argv[1]), 'movies')

try:
    xbmcplugin.addSortMethod(int(sys.argv[1]), xbmcplugin.SORT_METHOD_UNSORTED)
except:
    pass
try:
    xbmcplugin.addSortMethod(int(sys.argv[1]), xbmcplugin.SORT_METHOD_LABEL)
except:
    pass
try:
    xbmcplugin.addSortMethod(int(sys.argv[1]), xbmcplugin.SORT_METHOD_DATE)
except:
    pass
try:
    xbmcplugin.addSortMethod(int(sys.argv[1]), xbmcplugin.SORT_METHOD_GENRE)
except:
    pass

params=get_params()

url=None
name=None
mode=None
playlist=None
iconimage=None
fanart=FANART
playlist=None
fav_mode=None
regexs=None

try:
    url=urllib.parse.unquote_plus(params["url"])#.decode('utf-8')
except:
    pass
try:
    name=urllib.parse.unquote_plus(params["name"])
except:
    pass
try:
    iconimage=urllib.parse.unquote_plus(params["iconimage"])
except:
    pass
try:
    fanart=urllib.parse.unquote_plus(params["fanart"])
except:
    pass
try:
    mode=int(params["mode"])
except:
    pass
try:
    playlist=eval(urllib.parse.unquote_plus(params["playlist"]).replace('||',','))
except:
    pass
try:
    fav_mode=int(params["fav_mode"])
except:
    pass
try:
    regexs=params["regexs"]
except:
    pass
try:        
    channelid=urllib.parse.unquote_plus(params["channelid"])      
except:     
    pass

addon_log("Mode: "+str(mode))
if not url is None:
    addon_log("URL: "+str(url.encode('utf-8')))
addon_log("Name: "+str(name))

if mode==None:
    addon_log("Index")
    check_for_update()  # ← ADD THIS
    SKindex()   

elif mode==1:
    addon_log("getData mode1")
    getData(url,fanart)
    xbmcplugin.endOfDirectory(int(sys.argv[1]))

elif mode==2:
    addon_log("getChannelItems mode2")
    getChannelItems(name,url,fanart)
    xbmcplugin.endOfDirectory(int(sys.argv[1]))

elif mode==3:
    getSubChannelItems(name,url,fanart)
    xbmcplugin.endOfDirectory(int(sys.argv[1]))


elif mode==4:
    addon_log("geturl mode4")
    get(url)
    xbmcplugin.endOfDirectory(int(sys.argv[1]))

elif mode==10:
    play(url,name)

elif mode==11:
    addSource(url)

elif mode==13:
    addon_log("play_playlist")
    play_playlist(name, playlist)

elif mode==14:
    playsetresolved2(url, name, iconimage, setresolved=True)
    xbmcplugin.endOfDirectory(int(sys.argv[1]))

elif mode==17:
    addon_log("getRegexParsed")
    url,setresolved = getRegexParsed(regexs, url)
    if url:
        playsetresolved(url,name,iconimage,setresolved)
    else:
        xbmc.executebuiltin("XBMC.Notification(RisingTides ,Failed to extract regex. - "+"this"+",4000,"+icon+")")
    
elif mode==27:
    addon_log("Using IMDB id to play in Pulsar")
    pulsarIMDB=search(url)
    xbmc.Player().play(pulsarIMDB)

elif mode==30:
    GetSublinks(name,url,iconimage,fanart)

elif mode==33:
    scrape()
    xbmcplugin.endOfDirectory(int(sys.argv[1]))

elif mode==34:
    HIGHLIGHTS_LINKS(name,url)
    xbmcplugin.endOfDirectory(int(sys.argv[1]))

elif mode==36:
    PLAYSTREAM(name,url,iconimage)
    xbmcplugin.endOfDirectory(int(sys.argv[1]))

elif mode==40:
    SearchChannels()
    SetViewThumbnail()
    xbmcplugin.endOfDirectory(int(sys.argv[1]))

elif mode==53:
    addon_log("Requesting JSON-RPC Items")
    pluginquerybyJSON(url)
    xbmcplugin.endOfDirectory(int(sys.argv[1]))

elif mode==60:
    getStreamedCategory(url, fanart)

elif mode==61:
    getPPVStreams(url, fanart)

elif mode==62:
    getPPVCategories(fanart)

elif mode==63:
    getPPVFiltered(url, fanart)
    xbmcplugin.setResolvedUrl(int(sys.argv[1]), False, xbmcgui.ListItem())

elif mode==64:
    getCDNChannels(url, fanart)

elif mode==65:
    CHECKLINKS(name,url,iconimage)
    xbmcplugin.endOfDirectory(int(sys.argv[1]))

elif mode==9999:
    import xbmcgui,xbmcplugin
    from resources.root import resolvers
    url = resolvers.resolve(url)
    liz = xbmcgui.ListItem(name)
    liz.setArt({"icon":iconimage, "thumb":iconimage})

    liz.setInfo(type='Video', infoLabels='')
    liz.setProperty("IsPlayable","true")
    liz.setPath(url)
    xbmcplugin.setResolvedUrl(int(sys.argv[1]), True, liz)