#!/bin/bash
set -euo pipefail

# --- CONFIG ---

APK_NAME="20.apk"
APK_DECOMPILE_DIR="20_decompiled"



# --- DOWNLOAD APK ---
echo "Downloading APK..."
wget -O "$APK_NAME" "$APK_URL"

# --- DECOMPILE APK ---
echo "Decompiling APK..."
rm -rf "$APK_DECOMPILE_DIR"
apktool d "$APK_NAME" -o "$APK_DECOMPILE_DIR" -f

echo "✅ APK unpacked to: $APK_DECOMPILE_DIR"

