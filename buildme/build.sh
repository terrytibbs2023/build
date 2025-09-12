#!/bin/bash
set -euo pipefail

# --- CONFIGURATION ---
APK_URL="https://github.com/terrytibbs2023/build/blob/main/20.apk?raw=true"
APK_NAME="20.apk"
APK_DECOMPILE_DIR="20_decompiled"
MODIFIED_APK="20_modified.apk"
ZIP_ADD_DIR="./zipadd"

KEYSTORE="my-release-key.jks"
KEY_ALIAS="my-key"
KEY_PASSWORD="password123"

ANDROID_SDK_DIR="$HOME/android-sdk"
BUILD_TOOLS_VERSION="34.0.0"
CMDLINE_TOOLS_ZIP="commandlinetools-linux-9477386_latest.zip"
SDKMANAGER_BIN="$ANDROID_SDK_DIR/cmdline-tools/latest/bin/sdkmanager"
APKSIGNER="$ANDROID_SDK_DIR/build-tools/$BUILD_TOOLS_VERSION/apksigner"

# --- LOGGING ---
log() { echo -e "\033[1;32m[$(date '+%H:%M:%S')]\033[0m $1"; }

# --- DEPENDENCY CHECK ---
log "Checking system dependencies..."
for cmd in apktool zip unzip wget keytool xmlstarlet; do
  if ! command -v "$cmd" &>/dev/null; then
    log "Installing missing dependency: $cmd"
    sudo apt update && sudo apt install -y "$cmd"
  fi
done

# --- INSTALL AND CONFIGURE ANDROID SDK ---
if [ ! -x "$APKSIGNER" ]; then
  log "Setting up Android SDK and apksigner..."
  mkdir -p "$ANDROID_SDK_DIR"
  cd "$ANDROID_SDK_DIR"
  rm -rf cmdline-tools build-tools platform-tools
  wget -q "https://dl.google.com/android/repository/$CMDLINE_TOOLS_ZIP" -O sdk.zip
  unzip -q sdk.zip -d cmdline-tools
  mkdir -p cmdline-tools/latest
  mv cmdline-tools/cmdline-tools/* cmdline-tools/latest/
  rm -f sdk.zip
  yes | "$SDKMANAGER_BIN" --sdk_root="$ANDROID_SDK_DIR" "platform-tools" "build-tools;$BUILD_TOOLS_VERSION"
fi



# --- REBUILD APK ---
log "Rebuilding APK..."
apktool b "$APK_DECOMPILE_DIR" -o "$MODIFIED_APK"

# --- GENERATE KEYSTORE IF NEEDED ---
if [ ! -f "$KEYSTORE" ]; then
  log "Creating keystore..."
  keytool -genkey -v -keystore "$KEYSTORE" -alias "$KEY_ALIAS" \
    -keyalg RSA -keysize 2048 -validity 10000 \
    -storepass "$KEY_PASSWORD" -keypass "$KEY_PASSWORD" \
    -dname "CN=APK Builder, OU=Dev, O=Company, L=City, S=State, C=US"
fi

# --- SIGN APK ---
log "Signing APK..."
"$APKSIGNER" sign --ks "$KEYSTORE" --ks-key-alias "$KEY_ALIAS" \
  --ks-pass pass:"$KEY_PASSWORD" --key-pass pass:"$KEY_PASSWORD" \
  "$MODIFIED_APK"

# --- VERIFY SIGNATURE ---
log "Verifying APK signature..."
"$APKSIGNER" verify "$MODIFIED_APK" && log "✅ APK signature verified."

log "🎉 Done! Your signed APK is ready: $MODIFIED_APK"

