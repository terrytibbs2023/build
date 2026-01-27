import xbmcgui
from..modules.tools import m
from ..plugin import Plugin


class Meta(Plugin):
    name = "meta"
    description = "prepare xbmc listitem"
    priority = 200

    def get_metadata(self, item):
        title = item.get("title", "")
        thumbnail = item.get("thumbnail", m.addon_icon)
        if not thumbnail:
            thumbnail = m.addon_icon
        fanart = item.get("fanart", m.addon_fanart)
        if not fanart:
            fanart = m.addon_fanart
        summary = item.get("summary", item.get("title", ''))
        list_item = xbmcgui.ListItem(title)
        list_item.setArt({"icon": thumbnail, "poster":thumbnail, "thumb": thumbnail, "fanart": fanart})
        list_item.setInfo(
            "video", {"plot": summary, "plotoutline": summary}
        )
        item["list_item"] = list_item
        return item
