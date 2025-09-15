.class Lorg/xbmc/kodi/XBMCVideoView$2;
.super Ljava/lang/Object;
.source "XBMCVideoView.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/xbmc/kodi/XBMCVideoView;->add()V
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

    .line 65
    iput-object p1, p0, Lorg/xbmc/kodi/XBMCVideoView$2;->this$0:Lorg/xbmc/kodi/XBMCVideoView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 69
    new-instance v0, Landroid/widget/RelativeLayout$LayoutParams;

    const/4 v1, -0x1

    invoke-direct {v0, v1, v1}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 70
    iget-object v1, p0, Lorg/xbmc/kodi/XBMCVideoView$2;->this$0:Lorg/xbmc/kodi/XBMCVideoView;

    invoke-static {v1}, Lorg/xbmc/kodi/XBMCVideoView;->access$000(Lorg/xbmc/kodi/XBMCVideoView;)Landroid/widget/RelativeLayout;

    move-result-object v1

    iget-object v2, p0, Lorg/xbmc/kodi/XBMCVideoView$2;->this$0:Lorg/xbmc/kodi/XBMCVideoView;

    invoke-virtual {v1, v2, v0}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method
