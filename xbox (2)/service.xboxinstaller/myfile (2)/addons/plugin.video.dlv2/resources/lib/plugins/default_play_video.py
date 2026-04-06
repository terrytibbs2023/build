import sys
import xbmc
import xbmcgui
import xbmcplugin
from ..modules.tools import m
from ..plugin import Plugin


class default_play_video(Plugin):
    name = "default video playback"
    priority = 0
    
    def play_video(self, item: dict):
        link = item.get("link", "")
        if not link:
            sys.exit()
        if isinstance(link, list):
            link = m.get_multilink(link)
        title = item.get("title", "")
        thumbnail = item.get("thumbnail", m.addon_icon)
        summary = item.get("summary", title)
        
        liz = xbmcgui.ListItem(title)
        if item.get("infolabels"):
            liz.setInfo("video", item["infolabels"])
        else:
            liz.setInfo("video", {"title": title, "plot": summary})
        liz.setArt({"thumb": thumbnail, "icon": thumbnail, "poster": thumbnail})
        
        try:
            import resolveurl
            hmf = resolveurl.HostedMediaFile(link)
            if hmf.valid_url():
                link = hmf.resolve()
        except:
            pass
        
        liz.setPath(link)
        if item.get('is_playable'):
            xbmcplugin.setResolvedUrl(int(sys.argv[1]), True, liz)
        else:
            xbmc.Player().play(link, liz)
        return True
        