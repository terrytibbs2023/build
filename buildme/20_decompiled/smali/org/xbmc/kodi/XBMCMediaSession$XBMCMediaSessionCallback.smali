.class Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;
.super Landroid/media/session/MediaSession$Callback;
.source "XBMCMediaSession.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/xbmc/kodi/XBMCMediaSession;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "XBMCMediaSessionCallback"
.end annotation


# instance fields
.field final synthetic this$0:Lorg/xbmc/kodi/XBMCMediaSession;


# direct methods
.method private constructor <init>(Lorg/xbmc/kodi/XBMCMediaSession;)V
    .locals 0

    .line 37
    iput-object p1, p0, Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;->this$0:Lorg/xbmc/kodi/XBMCMediaSession;

    invoke-direct {p0}, Landroid/media/session/MediaSession$Callback;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lorg/xbmc/kodi/XBMCMediaSession;Lorg/xbmc/kodi/XBMCMediaSession$1;)V
    .locals 0

    .line 37
    invoke-direct {p0, p1}, Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;-><init>(Lorg/xbmc/kodi/XBMCMediaSession;)V

    return-void
.end method


# virtual methods
.method public onFastForward()V
    .locals 2

    const-string v0, "Kodi"

    const-string v1, "XBMCMediaSession.onFastForward: "

    .line 75
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 76
    invoke-super {p0}, Landroid/media/session/MediaSession$Callback;->onFastForward()V

    .line 77
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;->this$0:Lorg/xbmc/kodi/XBMCMediaSession;

    invoke-virtual {v0}, Lorg/xbmc/kodi/XBMCMediaSession;->_onForwardRequested()V

    return-void
.end method

.method public onMediaButtonEvent(Landroid/content/Intent;)Z
    .locals 2

    const-string v0, "Kodi"

    const-string v1, "XBMCMediaSession.onMediaButtonEvent: "

    .line 107
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 108
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;->this$0:Lorg/xbmc/kodi/XBMCMediaSession;

    invoke-virtual {v0, p1}, Lorg/xbmc/kodi/XBMCMediaSession;->_onMediaButtonEvent(Landroid/content/Intent;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 109
    invoke-super {p0, p1}, Landroid/media/session/MediaSession$Callback;->onMediaButtonEvent(Landroid/content/Intent;)Z

    move-result p1

    return p1

    :cond_0
    const/4 p1, 0x1

    return p1
.end method

.method public onPause()V
    .locals 2

    const-string v0, "Kodi"

    const-string v1, "XBMCMediaSession.onPause: "

    .line 51
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 52
    invoke-super {p0}, Landroid/media/session/MediaSession$Callback;->onPause()V

    .line 53
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;->this$0:Lorg/xbmc/kodi/XBMCMediaSession;

    invoke-virtual {v0}, Lorg/xbmc/kodi/XBMCMediaSession;->_onPauseRequested()V

    return-void
.end method

.method public onPlay()V
    .locals 2

    const-string v0, "Kodi"

    const-string v1, "XBMCMediaSession.onPlay: "

    .line 43
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 44
    invoke-super {p0}, Landroid/media/session/MediaSession$Callback;->onPlay()V

    .line 45
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;->this$0:Lorg/xbmc/kodi/XBMCMediaSession;

    invoke-virtual {v0}, Lorg/xbmc/kodi/XBMCMediaSession;->_onPlayRequested()V

    return-void
.end method

.method public onRewind()V
    .locals 2

    const-string v0, "Kodi"

    const-string v1, "XBMCMediaSession.onRewind: "

    .line 83
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 84
    invoke-super {p0}, Landroid/media/session/MediaSession$Callback;->onRewind()V

    .line 85
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;->this$0:Lorg/xbmc/kodi/XBMCMediaSession;

    invoke-virtual {v0}, Lorg/xbmc/kodi/XBMCMediaSession;->_onRewindRequested()V

    return-void
.end method

.method public onSeekTo(J)V
    .locals 2

    const-string v0, "Kodi"

    const-string v1, "XBMCMediaSession.onSeekTo: "

    .line 99
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 100
    invoke-super {p0, p1, p2}, Landroid/media/session/MediaSession$Callback;->onSeekTo(J)V

    .line 101
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;->this$0:Lorg/xbmc/kodi/XBMCMediaSession;

    invoke-virtual {v0, p1, p2}, Lorg/xbmc/kodi/XBMCMediaSession;->_onSeekRequested(J)V

    return-void
.end method

.method public onSkipToNext()V
    .locals 2

    const-string v0, "Kodi"

    const-string v1, "XBMCMediaSession.onSkipToNext: "

    .line 59
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 60
    invoke-super {p0}, Landroid/media/session/MediaSession$Callback;->onSkipToNext()V

    .line 61
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;->this$0:Lorg/xbmc/kodi/XBMCMediaSession;

    invoke-virtual {v0}, Lorg/xbmc/kodi/XBMCMediaSession;->_onNextRequested()V

    return-void
.end method

.method public onSkipToPrevious()V
    .locals 2

    const-string v0, "Kodi"

    const-string v1, "XBMCMediaSession.onSkipToPrevious: "

    .line 67
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 68
    invoke-super {p0}, Landroid/media/session/MediaSession$Callback;->onSkipToPrevious()V

    .line 69
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;->this$0:Lorg/xbmc/kodi/XBMCMediaSession;

    invoke-virtual {v0}, Lorg/xbmc/kodi/XBMCMediaSession;->_onPreviousRequested()V

    return-void
.end method

.method public onStop()V
    .locals 2

    const-string v0, "Kodi"

    const-string v1, "XBMCMediaSession.onStop: "

    .line 91
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 92
    invoke-super {p0}, Landroid/media/session/MediaSession$Callback;->onStop()V

    .line 93
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;->this$0:Lorg/xbmc/kodi/XBMCMediaSession;

    invoke-virtual {v0}, Lorg/xbmc/kodi/XBMCMediaSession;->_onStopRequested()V

    return-void
.end method
