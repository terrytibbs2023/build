.class public Lorg/xbmc/kodi/XBMCInputDeviceListener;
.super Ljava/lang/Object;
.source "XBMCInputDeviceListener.java"

# interfaces
.implements Landroid/hardware/input/InputManager$InputDeviceListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method native _onInputDeviceAdded(I)V
.end method

.method native _onInputDeviceChanged(I)V
.end method

.method native _onInputDeviceRemoved(I)V
.end method

.method public onInputDeviceAdded(I)V
    .locals 0

    .line 16
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCInputDeviceListener;->_onInputDeviceAdded(I)V

    return-void
.end method

.method public onInputDeviceChanged(I)V
    .locals 0

    .line 22
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCInputDeviceListener;->_onInputDeviceChanged(I)V

    return-void
.end method

.method public onInputDeviceRemoved(I)V
    .locals 0

    .line 28
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCInputDeviceListener;->_onInputDeviceRemoved(I)V

    return-void
.end method
