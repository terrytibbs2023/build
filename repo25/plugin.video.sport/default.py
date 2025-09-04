import sys
import xbmcplugin
import xbmcgui
import xbmc
import urllib.parse

addon_handle = int(sys.argv[1])
base_url = sys.argv[0]
args = urllib.parse.parse_qs(sys.argv[2][1:]) if len(sys.argv) > 2 else {}

# Only show menu if we're at the root
if not args:
    xbmcplugin.setContent(addon_handle, 'movies')
    xbmc.executebuiltin('Container.SetViewMode(501)')  # Fanart view

    list_item = xbmcgui.ListItem(label="Latest Movies")
    list_item.setArt({
        'thumb': "https://archive.org/download/iconlarge/iconlarge.png",
        'icon': "https://archive.org/download/iconlarge/iconlarge.png",
        'fanart': "https://archive.org/download/iconlarge/iconlarge.png"
    })
    list_item.setInfo('video', {
        'title': "Latest Movies",
        'plot': "A curated list of the latest Netflix releases.",
        'genre': "Drama, Action",
        'year': "2025",
        'rating': "8.5",
        'studio': "Netflix",
        'duration': 7200
    })
    list_item.setProperty("IsPlayable", "false")

    url = "plugin://plugin.video.fen/?list_name=Netflix%20Movies&list_type=user_lists&mode=trakt.list.build_trakt_list&slug=netflix-movies&user=garycrawfordgc"
    xbmcplugin.addDirectoryItem(handle=addon_handle, url=url, listitem=list_item, isFolder=True)

    xbmcplugin.endOfDirectory(addon_handle)
else:
    # Optional: handle subpaths or fallback
    xbmcplugin.endOfDirectory(addon_handle)

