#!/bin/bash

set -e

APP_NAME="Kodi Launcher"
PACKAGE_NAME="com.essex.kodilauncher"
MAIN_ACTIVITY="MainActivity"
ICON_PATH="/home/ecr/Pictures/banner.png"
BUILD_DIR="$HOME/kodi_launcher_build"
KEYSTORE="$BUILD_DIR/debug.keystore"
APK_NAME="KodiLauncher.apk"

# ✅ Check dependencies
for cmd in javac java zipalign apksigner; do
  command -v $cmd >/dev/null || { echo "$cmd not found. Install it."; exit 1; }
done

# ✅ Setup build structure
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"/{src,res,bin,gen,lib,assets}
mkdir -p "$BUILD_DIR/res/mipmap-xxxhdpi"

# ✅ Copy icon
cp "$ICON_PATH" "$BUILD_DIR/res/mipmap-xxxhdpi/ic_launcher.png"

# ✅ AndroidManifest.xml
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

# ✅ MainActivity.java
mkdir -p "$BUILD_DIR/src/$PACKAGE_NAME"
cat > "$BUILD_DIR/src/$PACKAGE_NAME/$MAIN_ACTIVITY.java" <<EOF
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

# ✅ Compile
javac -source 1.8 -target 1.8 -bootclasspath \$(dirname \$(dirname \$(readlink -f \$(which android))))/platforms/android-29/android.jar \
    -d "$BUILD_DIR/bin" "$BUILD_DIR/src/$PACKAGE_NAME/$MAIN_ACTIVITY.java"

# ✅ Package classes
cd "$BUILD_DIR/bin"
jar cf classes.jar *

# ✅ Generate keystore if missing
if [ ! -f "$KEYSTORE" ]; then
  keytool -genkey -v -keystore "$KEYSTORE" -storepass android -keypass android \
    -alias debugkey -keyalg RSA -keysize 2048 -validity 10000 -dname "CN=Kodi Launcher, OU=Essex, O=Console Repair, L=Watford, S=Herts, C=GB"
fi

# ✅ Build APK
cd "$BUILD_DIR"
aapt package -f -m -F base.apk -M AndroidManifest.xml -S res -I \
  \$(dirname \$(dirname \$(readlink -f \$(which android))))/platforms/android-29/android.jar

aapt add base.apk classes.jar

# ✅ Align and sign
zipalign -f 4 base.apk "$APK_NAME"
apksigner sign --ks "$KEYSTORE" --ks-pass pass:android --key-pass pass:android --out "$APK_NAME" "$APK_NAME"

echo "✅ APK built: $BUILD_DIR/$APK_NAME"

