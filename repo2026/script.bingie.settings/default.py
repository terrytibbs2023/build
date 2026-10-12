import xbmcgui
import xbmcaddon
import os

class BingieSettings(xbmcgui.WindowXML):
    def __init__(self, *args, **kwargs):
        # We don't need to add much logic here; the XML handles the clicks
        super(BingieSettings, self).__init__(*args, **kwargs)

    def onInit(self):
        # Focus the list defined in your XML (id="9000")
        self.setFocusId(9000)

if __name__ == '__main__':
    addon = xbmcaddon.Addon()
    path = addon.getAddonInfo('path')
    # This matches the XML file name in resources/skins/default/1080i/
    ui = BingieSettings('BingieSettings.xml', path, 'default', '1080i')
    ui.doModal()
    del ui
