import xbmc
import xbmcgui
import xbmcaddon

addon = xbmcaddon.Addon()
accepted = addon.getSettingBool("accepted")

message = (
    "Unfortunately, a lot of things have changed all at once.\n\n"
    "Fen, which was the main engine, is gone, and RealDebrid has also started blocking streams.\n\n"
    "If you’re not already on the new version, please ask how to install it.\n\n"
    "If the Bingie interface feels slow on your device, go to Settings and switch to Lite mode.\n\n"
    "From now on, we’ll be using TorBox instead of RealDebrid. "
    "It’s around £2.50 per month and can be paid monthly.\n\n"
)

if not accepted:
    dialog = xbmcgui.Dialog()
    dialog.textviewer("Major Changes", message)

    yes = dialog.yesno("Did You Read That", "Did you read that? its VERY Important!")

    if yes:
        addon.setSettingBool("accepted", True)

