.class public Lorg/xbmc/kodi/interfaces/XBMCDisplayManagerDisplayListener;
.super Ljava/lang/Object;
.source "XBMCDisplayManagerDisplayListener.java"

# interfaces
.implements Landroid/hardware/display/DisplayManager$DisplayListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method native _onDisplayAdded(I)V
.end method

.method native _onDisplayChanged(I)V
.end method

.method native _onDisplayRemoved(I)V
.end method

.method public onDisplayAdded(I)V
    .locals 0

    .line 14
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCDisplayManagerDisplayListener;->_onDisplayAdded(I)V

    return-void
.end method

.method public onDisplayChanged(I)V
    .locals 0

    .line 20
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCDisplayManagerDisplayListener;->_onDisplayChanged(I)V

    return-void
.end method

.method public onDisplayRemoved(I)V
    .locals 0

    .line 26
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCDisplayManagerDisplayListener;->_onDisplayRemoved(I)V

    return-void
.end method
