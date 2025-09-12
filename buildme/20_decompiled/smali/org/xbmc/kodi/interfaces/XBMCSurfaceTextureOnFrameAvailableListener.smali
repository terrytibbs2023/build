.class public Lorg/xbmc/kodi/interfaces/XBMCSurfaceTextureOnFrameAvailableListener;
.super Ljava/lang/Object;
.source "XBMCSurfaceTextureOnFrameAvailableListener.java"

# interfaces
.implements Landroid/graphics/SurfaceTexture$OnFrameAvailableListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method native _onFrameAvailable(Landroid/graphics/SurfaceTexture;)V
.end method

.method public onFrameAvailable(Landroid/graphics/SurfaceTexture;)V
    .locals 0

    .line 13
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCSurfaceTextureOnFrameAvailableListener;->_onFrameAvailable(Landroid/graphics/SurfaceTexture;)V

    return-void
.end method
