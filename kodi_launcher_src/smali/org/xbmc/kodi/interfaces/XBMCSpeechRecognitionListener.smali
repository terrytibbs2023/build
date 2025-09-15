.class public Lorg/xbmc/kodi/interfaces/XBMCSpeechRecognitionListener;
.super Ljava/lang/Object;
.source "XBMCSpeechRecognitionListener.java"

# interfaces
.implements Landroid/speech/RecognitionListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method native _onError(I)V
.end method

.method native _onReadyForSpeech(Landroid/os/Bundle;)V
.end method

.method native _onResults(Landroid/os/Bundle;)V
.end method

.method public onBeginningOfSpeech()V
    .locals 0

    return-void
.end method

.method public onBufferReceived([B)V
    .locals 0

    return-void
.end method

.method public onEndOfSpeech()V
    .locals 0

    return-void
.end method

.method public onError(I)V
    .locals 0

    .line 30
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCSpeechRecognitionListener;->_onError(I)V

    return-void
.end method

.method public onEvent(ILandroid/os/Bundle;)V
    .locals 0

    return-void
.end method

.method public onPartialResults(Landroid/os/Bundle;)V
    .locals 0

    return-void
.end method

.method public onReadyForSpeech(Landroid/os/Bundle;)V
    .locals 0

    .line 46
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCSpeechRecognitionListener;->_onReadyForSpeech(Landroid/os/Bundle;)V

    return-void
.end method

.method public onResults(Landroid/os/Bundle;)V
    .locals 0

    .line 52
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCSpeechRecognitionListener;->_onResults(Landroid/os/Bundle;)V

    return-void
.end method

.method public onRmsChanged(F)V
    .locals 0

    return-void
.end method
