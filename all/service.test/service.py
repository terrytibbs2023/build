import xbmc
import xbmcgui
import xbmcaddon

addon = xbmcaddon.Addon()
accepted = addon.getSettingBool("accepted")

if not accepted:
    dialog = xbmcgui.Dialog()
    yes = dialog.yesno("Major Changes", "Unfortunately, a lot of things have changed all at once. Fen, which was the main engine, is gone, and RealDebrid has also started blocking streams. If you’re not already on the new version, please ask how to install it. If the Bingie interface feels slow on your device, go to Settings and switch to Lite mode. From now on, we’ll be using TorBox instead of Real‑Debrid. It’s around £2.50 per month and can be paid monthly. Press Yes to hide this message permanently.")

    if yes:
        addon.setSettingBool("accepted", True)
