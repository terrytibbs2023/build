.class Lorg/xbmc/kodi/XBMCMediaSession$1;
.super Ljava/lang/Object;
.source "XBMCMediaSession.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/xbmc/kodi/XBMCMediaSession;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/xbmc/kodi/XBMCMediaSession;


# direct methods
.method constructor <init>(Lorg/xbmc/kodi/XBMCMediaSession;)V
    .locals 0

    .line 127
    iput-object p1, p0, Lorg/xbmc/kodi/XBMCMediaSession$1;->this$0:Lorg/xbmc/kodi/XBMCMediaSession;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    const-string v0, "Kodi"

    const-string v1, "XBMCMediaSession callback"

    .line 131
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 132
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession$1;->this$0:Lorg/xbmc/kodi/XBMCMediaSession;

    new-instance v1, Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;

    iget-object v2, p0, Lorg/xbmc/kodi/XBMCMediaSession$1;->this$0:Lorg/xbmc/kodi/XBMCMediaSession;

    const/4 v3, 0x0

    invoke-direct {v1, v2, v3}, Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;-><init>(Lorg/xbmc/kodi/XBMCMediaSession;Lorg/xbmc/kodi/XBMCMediaSession$1;)V

    invoke-static {v0, v1}, Lorg/xbmc/kodi/XBMCMediaSession;->access$002(Lorg/xbmc/kodi/XBMCMediaSession;Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;)Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;

    .line 133
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCMediaSession$1;->this$0:Lorg/xbmc/kodi/XBMCMediaSession;

    invoke-static {v0}, Lorg/xbmc/kodi/XBMCMediaSession;->access$200(Lorg/xbmc/kodi/XBMCMediaSession;)Landroid/media/session/MediaSession;

    move-result-object v0

    iget-object v1, p0, Lorg/xbmc/kodi/XBMCMediaSession$1;->this$0:Lorg/xbmc/kodi/XBMCMediaSession;

    invoke-static {v1}, Lorg/xbmc/kodi/XBMCMediaSession;->access$000(Lorg/xbmc/kodi/XBMCMediaSession;)Lorg/xbmc/kodi/XBMCMediaSession$XBMCMediaSessionCallback;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/media/session/MediaSession;->setCallback(Landroid/media/session/MediaSession$Callback;)V

    return-void
.end method
