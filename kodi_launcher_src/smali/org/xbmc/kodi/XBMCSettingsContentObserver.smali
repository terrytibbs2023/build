.class public Lorg/xbmc/kodi/XBMCSettingsContentObserver;
.super Landroid/database/ContentObserver;
.source "XBMCSettingsContentObserver.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "Kodi"


# instance fields
.field context:Landroid/content/Context;

.field previousVolume:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/os/Handler;)V
    .locals 0

    .line 21
    invoke-direct {p0, p2}, Landroid/database/ContentObserver;-><init>(Landroid/os/Handler;)V

    .line 22
    iput-object p1, p0, Lorg/xbmc/kodi/XBMCSettingsContentObserver;->context:Landroid/content/Context;

    const-string p2, "audio"

    .line 24
    invoke-virtual {p1, p2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/media/AudioManager;

    const/4 p2, 0x3

    .line 25
    invoke-virtual {p1, p2}, Landroid/media/AudioManager;->getStreamVolume(I)I

    move-result p1

    iput p1, p0, Lorg/xbmc/kodi/XBMCSettingsContentObserver;->previousVolume:I

    return-void
.end method


# virtual methods
.method native _onVolumeChanged(I)V
.end method

.method public onChange(Z)V
    .locals 1

    const/4 v0, 0x0

    .line 34
    invoke-virtual {p0, p1, v0}, Lorg/xbmc/kodi/XBMCSettingsContentObserver;->onChange(ZLandroid/net/Uri;)V

    return-void
.end method

.method public onChange(ZLandroid/net/Uri;)V
    .locals 1

    .line 40
    invoke-super {p0, p1}, Landroid/database/ContentObserver;->onChange(Z)V

    .line 42
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "XBMCSettingsContentObserver: Setting changed: "

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "Kodi"

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string p1, "content://settings/system/volume_music_speaker"

    .line 45
    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/net/Uri;->compareTo(Landroid/net/Uri;)I

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "content://settings/system/volume_music_hdmi"

    .line 46
    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/net/Uri;->compareTo(Landroid/net/Uri;)I

    move-result p1

    if-nez p1, :cond_1

    .line 49
    :cond_0
    iget-object p1, p0, Lorg/xbmc/kodi/XBMCSettingsContentObserver;->context:Landroid/content/Context;

    const-string p2, "audio"

    .line 50
    invoke-virtual {p1, p2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/media/AudioManager;

    const/4 p2, 0x3

    .line 51
    invoke-virtual {p1, p2}, Landroid/media/AudioManager;->getStreamVolume(I)I

    move-result p1

    .line 53
    iget p2, p0, Lorg/xbmc/kodi/XBMCSettingsContentObserver;->previousVolume:I

    if-eq p1, p2, :cond_1

    .line 57
    :try_start_0
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCSettingsContentObserver;->_onVolumeChanged(I)V

    .line 58
    iput p1, p0, Lorg/xbmc/kodi/XBMCSettingsContentObserver;->previousVolume:I
    :try_end_0
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const-string p1, "XBMCSettingsContentObserver: Native not registered"

    .line 62
    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    :goto_0
    return-void
.end method
