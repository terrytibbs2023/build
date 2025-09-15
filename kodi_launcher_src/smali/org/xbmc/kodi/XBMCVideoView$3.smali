.class Lorg/xbmc/kodi/XBMCVideoView$3;
.super Ljava/lang/Object;
.source "XBMCVideoView.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/xbmc/kodi/XBMCVideoView;->release()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/xbmc/kodi/XBMCVideoView;


# direct methods
.method constructor <init>(Lorg/xbmc/kodi/XBMCVideoView;)V
    .locals 0

    .line 78
    iput-object p1, p0, Lorg/xbmc/kodi/XBMCVideoView$3;->this$0:Lorg/xbmc/kodi/XBMCVideoView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 82
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCVideoView$3;->this$0:Lorg/xbmc/kodi/XBMCVideoView;

    invoke-static {v0}, Lorg/xbmc/kodi/XBMCVideoView;->access$000(Lorg/xbmc/kodi/XBMCVideoView;)Landroid/widget/RelativeLayout;

    move-result-object v0

    iget-object v1, p0, Lorg/xbmc/kodi/XBMCVideoView$3;->this$0:Lorg/xbmc/kodi/XBMCVideoView;

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->removeView(Landroid/view/View;)V

    return-void
.end method
