#!/bin/bash

set -e

APP_DIR="$HOME/Documents/GitHub/build/KodiSettingsShortcut"
MANIFEST="$APP_DIR/app/src/main/AndroidManifest.xml"
BANNER_SRC="$HOME/Downloads/banner.png"
BANNER_DEST="$APP_DIR/app/src/main/res/drawable/banner.png"

echo "[+] Preparing banner injection for Android TV"

# Ensure drawable folder exists
mkdir -p "$(dirname "$BANNER_DEST")"

# Copy banner image
if [ -f "$BANNER_SRC" ]; then
    cp "$BANNER_SRC" "$BANNER_DEST"
    echo "[✓] Banner image copied"
else
    echo "[✗] Banner image not found at $BANNER_SRC"
    exit 1
fi

# Inject banner metadata into manifest
if grep -q 'com.google.android.tv.banner' "$MANIFEST"; then
    echo "[!] Banner metadata already present—skipping injection"
else
    sed -i '/<application /a \        <meta-data android:name="com.google.android.tv.banner" android:resource="@drawable/banner" />' "$MANIFEST"
    echo "[✓] Banner metadata injected into manifest"
fi

# Rebuild APK
cd "$APP_DIR"
./gradlew clean assembleDebug

APK="$APP_DIR/app/build/outputs/apk/debug/app-debug.apk"
if [ -f "$APK" ]; then
    cp "$APK" "$HOME/Downloads/KodiTools_TV.apk"
    echo "[✓] Kodi Tools TV APK ready: $HOME/Downloads/KodiTools_TV.apk"
else
    echo "[✗] Build failed—APK not found."
    exit 1
fi

