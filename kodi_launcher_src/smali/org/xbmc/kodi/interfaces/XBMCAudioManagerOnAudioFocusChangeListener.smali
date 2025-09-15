.class public Lorg/xbmc/kodi/interfaces/XBMCAudioManagerOnAudioFocusChangeListener;
.super Ljava/lang/Object;
.source "XBMCAudioManagerOnAudioFocusChangeListener.java"

# interfaces
.implements Landroid/media/AudioManager$OnAudioFocusChangeListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method native _onAudioFocusChange(I)V
.end method

.method public onAudioFocusChange(I)V
    .locals 0

    .line 12
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCAudioManagerOnAudioFocusChangeListener;->_onAudioFocusChange(I)V

    return-void
.end method
