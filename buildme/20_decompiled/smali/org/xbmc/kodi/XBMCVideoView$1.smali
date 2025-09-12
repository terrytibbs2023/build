.class Lorg/xbmc/kodi/XBMCVideoView$1;
.super Ljava/lang/Object;
.source "XBMCVideoView.java"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/xbmc/kodi/XBMCVideoView;->createVideoView()Lorg/xbmc/kodi/XBMCVideoView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/concurrent/Callable<",
        "Lorg/xbmc/kodi/XBMCVideoView;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bridge synthetic call()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 31
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCVideoView$1;->call()Lorg/xbmc/kodi/XBMCVideoView;

    move-result-object v0

    return-object v0
.end method

.method public call()Lorg/xbmc/kodi/XBMCVideoView;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 35
    new-instance v0, Lorg/xbmc/kodi/XBMCVideoView;

    sget-object v1, Lorg/xbmc/kodi/Main;->MainActivity:Lorg/xbmc/kodi/Main;

    invoke-direct {v0, v1}, Lorg/xbmc/kodi/XBMCVideoView;-><init>(Landroid/content/Context;)V

    return-object v0
.end method
