#!/bin/bash

set -e

APP_NAME="KodiSettingsShortcut"
PACKAGE_NAME="com.kodi.settingsshortcut"
MAIN_ACTIVITY="MainActivity"
APK_OUTPUT="app/build/outputs/apk/debug/app-debug.apk"
KEYSTORE="$HOME/.android/debug.keystore"
KEY_ALIAS="androiddebugkey"
KEY_PASS="android"
STORE_PASS="android"
SDK_PATH="$HOME/Android/Sdk"

echo "[+] Creating project: $APP_NAME"
rm -rf "$APP_NAME"
mkdir -p "$APP_NAME/app/src/main/java/$PACKAGE_NAME"
mkdir -p "$APP_NAME/app/src/main/res/values"

cd "$APP_NAME"

echo "[+] Writing AndroidManifest.xml"
cat > app/src/main/AndroidManifest.xml <<EOF
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="$PACKAGE_NAME">

    <application android:label="Kodi Settings" android:theme="@android:style/Theme.NoDisplay">
        <activity android:name=".$MAIN_ACTIVITY">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
EOF

echo "[+] Writing $MAIN_ACTIVITY.java"
cat > app/src/main/java/$PACKAGE_NAME/$MAIN_ACTIVITY.java <<EOF
package $PACKAGE_NAME;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;

public class $MAIN_ACTIVITY extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = new Intent(android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
        intent.setData(Uri.parse("package:org.xbmc.kodi"));
        startActivity(intent);
        finish();
    }
}
EOF

echo "[+] Writing Gradle build files"
cat > build.gradle <<EOF
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.0.2'
    }
}
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
EOF

cat > app/build.gradle <<EOF
apply plugin: 'com.android.application'

android {
    compileSdkVersion 33
    defaultConfig {
        applicationId "$PACKAGE_NAME"
        minSdkVersion 21
        targetSdkVersion 33
        versionCode 1
        versionName "1.0"
    }
    buildTypes {
        debug {
            signingConfig signingConfigs.debug
        }
    }
}

dependencies {}
EOF

cat > gradle.properties <<EOF
org.gradle.jvmargs=-Xmx2048m
EOF

cat > local.properties <<EOF
sdk.dir=$SDK_PATH
EOF

cat > settings.gradle <<EOF
rootProject.name = "$APP_NAME"
include ':app'
EOF

echo "[+] Initializing Gradle wrapper"
gradle wrapper --gradle-version 8.0.2

echo "[+] Building APK"
./gradlew assembleDebug

if [ -f "$APK_OUTPUT" ]; then
    echo "[✓] APK built successfully: $APK_OUTPUT"
else
    echo "[✗] Build failed."
    exit 1
fi

echo "[+] Signing APK"
jarsigner -verbose -sigalg SHA256withRSA -digestalg SHA-256 \
    -keystore "$KEYSTORE" -storepass "$STORE_PASS" -keypass "$KEY_PASS" \
    "$APK_OUTPUT" "$KEY_ALIAS"

echo "[✓] APK signed and ready to install"

