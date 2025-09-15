.class Lorg/xbmc/kodi/XBMCVideoView$4;
.super Ljava/lang/Object;
.source "XBMCVideoView.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/xbmc/kodi/XBMCVideoView;->setSurfaceRect(IIII)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/xbmc/kodi/XBMCVideoView;

.field final synthetic val$bottom:I

.field final synthetic val$left:I

.field final synthetic val$right:I

.field final synthetic val$top:I


# direct methods
.method constructor <init>(Lorg/xbmc/kodi/XBMCVideoView;IIII)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 103
    iput-object p1, p0, Lorg/xbmc/kodi/XBMCVideoView$4;->this$0:Lorg/xbmc/kodi/XBMCVideoView;

    iput p2, p0, Lorg/xbmc/kodi/XBMCVideoView$4;->val$left:I

    iput p3, p0, Lorg/xbmc/kodi/XBMCVideoView$4;->val$top:I

    iput p4, p0, Lorg/xbmc/kodi/XBMCVideoView$4;->val$right:I

    iput p5, p0, Lorg/xbmc/kodi/XBMCVideoView$4;->val$bottom:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .line 113
    :try_start_0
    new-instance v0, Landroid/widget/RelativeLayout$LayoutParams;

    iget-object v1, p0, Lorg/xbmc/kodi/XBMCVideoView$4;->this$0:Lorg/xbmc/kodi/XBMCVideoView;

    invoke-virtual {v1}, Lorg/xbmc/kodi/XBMCVideoView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(Landroid/view/ViewGroup$LayoutParams;)V

    .line 114
    iget v1, p0, Lorg/xbmc/kodi/XBMCVideoView$4;->val$left:I

    iget v2, p0, Lorg/xbmc/kodi/XBMCVideoView$4;->val$top:I

    iget-object v3, p0, Lorg/xbmc/kodi/XBMCVideoView$4;->this$0:Lorg/xbmc/kodi/XBMCVideoView;

    invoke-static {v3}, Lorg/xbmc/kodi/XBMCVideoView;->access$000(Lorg/xbmc/kodi/XBMCVideoView;)Landroid/widget/RelativeLayout;

    move-result-object v3

    invoke-virtual {v3}, Landroid/widget/RelativeLayout;->getWidth()I

    move-result v3

    iget v4, p0, Lorg/xbmc/kodi/XBMCVideoView$4;->val$right:I

    sub-int/2addr v3, v4

    iget-object v4, p0, Lorg/xbmc/kodi/XBMCVideoView$4;->this$0:Lorg/xbmc/kodi/XBMCVideoView;

    invoke-static {v4}, Lorg/xbmc/kodi/XBMCVideoView;->access$000(Lorg/xbmc/kodi/XBMCVideoView;)Landroid/widget/RelativeLayout;

    move-result-object v4

    invoke-virtual {v4}, Landroid/widget/RelativeLayout;->getHeight()I

    move-result v4

    iget v5, p0, Lorg/xbmc/kodi/XBMCVideoView$4;->val$bottom:I

    sub-int/2addr v4, v5

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/widget/RelativeLayout$LayoutParams;->setMargins(IIII)V

    .line 115
    iget-object v1, p0, Lorg/xbmc/kodi/XBMCVideoView$4;->this$0:Lorg/xbmc/kodi/XBMCVideoView;

    invoke-virtual {v1, v0}, Lorg/xbmc/kodi/XBMCVideoView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 116
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCVideoView$4;->this$0:Lorg/xbmc/kodi/XBMCVideoView;

    invoke-virtual {v0}, Lorg/xbmc/kodi/XBMCVideoView;->requestLayout()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 120
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_0
    return-void
.end method
