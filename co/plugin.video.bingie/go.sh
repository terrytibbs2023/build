#!/bin/bash

echo "🔧 Disabling 'Tools' menu from Bingie addon..."

# Confirm we're inside the addon folder
if [ ! -f "addon.xml" ]; then
    echo "❌ This script must be run from inside plugin.video.bingie"
    exit 1
fi

# Remove Tools entry from bingie.py
BINGIE_FILE="resources/lib/bingie.py"
if [ -f "$BINGIE_FILE" ]; then
    grep -q "addDirectoryItem.*Tools" "$BINGIE_FILE" && sed -i '/addDirectoryItem.*Tools/d' "$BINGIE_FILE" && echo "🧹 Removed Tools entry from bingie.py"
else
    echo "⚠️ bingie.py not found at $BINGIE_FILE"
fi

# Comment out tools() method in navigation.py
NAV_FILE="resources/lib/modules/navigation.py"
if [ -f "$NAV_FILE" ]; then
    grep -q "def tools" "$NAV_FILE" && sed -i '/def tools/,/self.end_directory()/s/^/# /' "$NAV_FILE" && echo "🧼 Commented out tools() method in navigation.py"
else
    echo "❌ navigation.py not found at $NAV_FILE"
fi

# Remove routing for mode=navigator.tools
if [ -f "$NAV_FILE" ]; then
    grep -q "elif mode == 'navigator.tools'" "$NAV_FILE" && sed -i "/elif mode == 'navigator.tools'/d" "$NAV_FILE" && sed -i "/navigator.tools()/d" "$NAV_FILE" && echo "🚫 Removed mode=navigator.tools routing from navigation.py"
fi

# Optional: Remove Tools from favourites.xml
FAV_FILE="$HOME/.kodi/userdata/favourites.xml"
if [ -f "$FAV_FILE" ]; then
    grep -q 'name="Tools"' "$FAV_FILE" && sed -i '/name="Tools"/d' "$FAV_FILE" && echo "🧹 Removed Tools from favourites.xml"
fi

echo "✅ 'Tools' menu disabled. Rezip and reinstall the addon to apply changes."

