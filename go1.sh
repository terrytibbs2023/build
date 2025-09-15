#!/bin/bash
set -e

# === CONFIG ===
APP_NAME="Kodi Launcher"
PACKAGE_NAME="com.essex.kodilauncher"
MAIN_ACTIVITY="MainActivity"
ICON_PATH="/home/ecr/Pictures/banner.png"
BUILD_DIR="$HOME/kodi_launcher_build"
KEYSTORE="$BUILD_DIR/debug.keystore"
APK_NAME="KodiLauncher.apk"
ANDROID_JAR="$HOME/Android/platforms/android-29/android.jar"
ZIPALIGN="$HOME/Android/build-tools/34.0.0/zipalign"

# === DEPENDENCY CHECKS ===
for cmd in javac java aapt apksigner keytool; do
  command -v $cmd >/dev/null || { echo "❌ $cmd not found. Install it."; exit 1; }
done

if [ ! -f "$ANDROID_JAR" ]; then
  echo "❌ android.jar not found at $ANDROID_JAR"
  exit 1
fi

if [ ! -x "$ZIPALIGN" ]; then
  echo "❌ zipalign not found at $ZIPALIGN"
  exit 1
fi

# === CLEAN BUILD DIR ===
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"/{src,res,bin,gen,lib,assets}
mkdir -p "$BUILD_DIR/res/mipmap-xxxhdpi"

# === COPY ICON ===
cp "$ICON_PATH" "$BUILD_DIR/res/mipmap-xxxhdpi/ic_launcher.png"

# === MANIFEST ===
cat > "$BUILD_DIR/AndroidManifest.xml" <<EOF
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="$PACKAGE_NAME"
    android:versionCode="1"
    android:versionName="1.0">
    <application android:label="$APP_NAME"
        android:icon="@mipmap/ic_launcher"
        android:theme="@android:style/Theme.NoDisplay">
        <activity android:name=".$MAIN_ACTIVITY"
            android:exported="true"
            android:launchMode="singleTask"
            android:taskAffinity="">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
EOF

# === JAVA SOURCE ===
SRC_DIR="$BUILD_DIR/src"
PKG_DIR="$SRC_DIR/$(echo $PACKAGE_NAME | tr '.' '/')"
mkdir -p "$PKG_DIR"

cat > "$PKG_DIR/$MAIN_ACTIVITY.java" <<EOF
package $PACKAGE_NAME;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;

public class $MAIN_ACTIVITY extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setData(Uri.parse("kodi://settings"));
        startActivity(intent);
        finish();
    }
}
EOF

# === COMPILE JAVA ===
javac -source 1.8 -target 1.8 -bootclasspath "$ANDROID_JAR" \
    -d "$BUILD_DIR/bin" "$PKG_DIR/$MAIN_ACTIVITY.java"

# === VERIFY CLASS FILE ===
CLASS_FILE="$BUILD_DIR/bin/$MAIN_ACTIVITY.class"
if [ ! -f "$CLASS_FILE" ]; then
  echo "❌ Compilation failed: $MAIN_ACTIVITY.class not found"
  exit 1
fi

# === PACKAGE CLASSES ===
cd "$BUILD_DIR/bin"
jar cf classes.jar "$MAIN_ACTIVITY.class"

# === GENERATE KEYSTORE ===
if [ ! -f "$KEYSTORE" ]; then
  keytool -genkey -v -keystore "$KEYSTORE" -storepass android -keypass android \
    -alias debugkey -keyalg RSA -keysize 2048 -validity 10000 \
    -dname "CN=Kodi Launcher, OU=Essex, O=Console Repair, L=Watford, S=Herts, C=GB"
fi

# === BUILD APK ===
cd "$BUILD_DIR"
aapt package -f -m -F base.apk -M AndroidManifest.xml -S res -I "$ANDROID_JAR"
aapt add base.apk classes.jar

# === ALIGN AND SIGN ===
"$ZIPALIGN" -f 4 base.apk "$APK_NAME"
apksigner sign --ks "$KEYSTORE" --ks-pass pass:android --key-pass pass:android --out "$APK_NAME" "$APK_NAME"

echo "✅ APK built successfully: $BUILD_DIR/$APK_NAME"
