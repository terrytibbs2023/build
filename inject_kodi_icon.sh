#!/bin/bash

set -e

APP_DIR="$HOME/Documents/GitHub/build/KodiSettingsShortcut"
ICON_SRC="$HOME/Pictures/Copilot_20250916_081648.png"
ICON_NAME="ic_launcher.png"

echo "[+] Injecting Kodi Tools icon and label"

# Create mipmap folders
for dpi in mdpi hdpi xhdpi xxhdpi xxxhdpi; do
    mkdir -p "$APP_DIR/app/src/main/res/mipmap-$dpi"
    cp "$ICON_SRC" "$APP_DIR/app/src/main/res/mipmap-$dpi/$ICON_NAME"
done

# Create strings.xml with app name
mkdir -p "$APP_DIR/app/src/main/res/values"
cat > "$APP_DIR/app/src/main/res/values/strings.xml" <<EOF
<resources>
    <string name="app_name">Kodi Tools</string>
</resources>
EOF

# Patch AndroidManifest.xml
MANIFEST="$APP_DIR/app/src/main/AndroidManifest.xml"
sed -i 's/android:label="[^"]*"/android:label="@string\/app_name"/' "$MANIFEST"
sed -i '/<application / s|>| android:icon="@mipmap/ic_launcher">|' "$MANIFEST"

echo "[+] Rebuilding APK"
cd "$APP_DIR"
./gradlew clean assembleDebug

APK="$APP_DIR/app/build/outputs/apk/debug/app-debug.apk"
if [ -f "$APK" ]; then
    cp "$APK" "$HOME/Downloads/KodiTools.apk"
    echo "[✓] Kodi Tools APK ready: $HOME/Downloads/KodiTools.apk"
else
    echo "[✗] Build failed—APK not found."
    exit 1
fi

