# -*- coding: utf-8 -*-
import sys
from xbmc import getInfoLabel
from modules.router import routing

routing(sys)
if 'coalition' not in getInfoLabel('Container.PluginName'): sys.exit(1)

