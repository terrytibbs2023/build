.class public Lorg/xbmc/kodi/XBMCMediaSession;
.super Ljava/lang/Object;
.source "XBMCMediaSession.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "Kodi"


# instance fields
.field private mMediaSessionCallback:Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;

.field private mSession:Landroid/media/session/MediaSession;

.field private mTotDurMs:J


# direct methods
.method public constructor <init>()V
    .locals 3

    .line 119
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 114
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession;->mSession:Landroid/media/session/MediaSession;

    const-wide/16 v0, 0x0

    .line 116
    iput-wide v0, p0, Lorg/xbmc/kodi/XBMCMediaSession;->mTotDurMs:J

    const-string v0, "Kodi"

    const-string v1, "XBMCMediaSession init"

    .line 120
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 121
    new-instance v0, Landroid/media/session/MediaSession;

    sget-object v1, Lorg/xbmc/kodi/Main;->MainActivity:Lorg/xbmc/kodi/Main;

    const-string v2, "XBMC_session"

    invoke-direct {v0, v1, v2}, Landroid/media/session/MediaSession;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    iput-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession;->mSession:Landroid/media/session/MediaSession;

    .line 122
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-ge v0, v1, :cond_0

    .line 123
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession;->mSession:Landroid/media/session/MediaSession;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/media/session/MediaSession;->setFlags(I)V

    .line 126
    :cond_0
    sget-object v0, Lorg/xbmc/kodi/Main;->MainActivity:Lorg/xbmc/kodi/Main;

    new-instance v1, Lorg/xbmc/kodi/XBMCMediaSession$1;

    invoke-direct {v1, p0}, Lorg/xbmc/kodi/XBMCMediaSession$1;-><init>(Lorg/xbmc/kodi/XBMCMediaSession;)V

    invoke-virtual {v0, v1}, Lorg/xbmc/kodi/Main;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method static synthetic access$000(Lorg/xbmc/kodi/XBMCMediaSession;)Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;
    .locals 0

    .line 15
    iget-object p0, p0, Lorg/xbmc/kodi/XBMCMediaSession;->mMediaSessionCallback:Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;

    return-object p0
.end method

.method static synthetic access$002(Lorg/xbmc/kodi/XBMCMediaSession;Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;)Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;
    .locals 0

    .line 15
    iput-object p1, p0, Lorg/xbmc/kodi/XBMCMediaSession;->mMediaSessionCallback:Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;

    return-object p1
.end method

.method static synthetic access$200(Lorg/xbmc/kodi/XBMCMediaSession;)Landroid/media/session/MediaSession;
    .locals 0

    .line 15
    iget-object p0, p0, Lorg/xbmc/kodi/XBMCMediaSession;->mSession:Landroid/media/session/MediaSession;

    return-object p0
.end method

.method private updateIntent(Landroid/content/Intent;)V
    .locals 3

    .line 155
    sget-object v0, Lorg/xbmc/kodi/Main;->MainActivity:Lorg/xbmc/kodi/Main;

    const/16 v1, 0x63

    const/high16 v2, 0xc000000

    invoke-static {v0, v1, p1, v2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p1

    .line 157
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession;->mSession:Landroid/media/session/MediaSession;

    invoke-virtual {v0, p1}, Landroid/media/session/MediaSession;->setSessionActivity(Landroid/app/PendingIntent;)V

    return-void
.end method

.method private updateMetadata(Landroid/media/MediaMetadata;)V
    .locals 1

    .line 150
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession;->mSession:Landroid/media/session/MediaSession;

    invoke-virtual {v0, p1}, Landroid/media/session/MediaSession;->setMetadata(Landroid/media/MediaMetadata;)V

    return-void
.end method

.method private updatePlaybackState(Landroid/media/session/PlaybackState;)V
    .locals 1

    .line 145
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession;->mSession:Landroid/media/session/MediaSession;

    invoke-virtual {v0, p1}, Landroid/media/session/MediaSession;->setPlaybackState(Landroid/media/session/PlaybackState;)V

    return-void
.end method


# virtual methods
.method native _onForwardRequested()V
.end method

.method native _onMediaButtonEvent(Landroid/content/Intent;)Z
.end method

.method native _onNextRequested()V
.end method

.method native _onPauseRequested()V
.end method

.method native _onPlayRequested()V
.end method

.method native _onPreviousRequested()V
.end method

.method native _onRewindRequested()V
.end method

.method native _onSeekRequested(J)V
.end method

.method native _onStopRequested()V
.end method

.method public activate(Z)V
    .locals 1

    .line 140
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession;->mSession:Landroid/media/session/MediaSession;

    invoke-virtual {v0, p1}, Landroid/media/session/MediaSession;->setActive(Z)V

    return-void
.end method
