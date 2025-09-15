.class public Lorg/xbmc/kodi/interfaces/XBMCMediaDrmOnEventListener;
.super Ljava/lang/Object;
.source "XBMCMediaDrmOnEventListener.java"

# interfaces
.implements Landroid/media/MediaDrm$OnEventListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method native _onEvent(Landroid/media/MediaDrm;[BII[B)V
.end method

.method public onEvent(Landroid/media/MediaDrm;[BII[B)V
    .locals 0

    .line 13
    invoke-virtual/range {p0 .. p5}, Lorg/xbmc/kodi/interfaces/XBMCMediaDrmOnEventListener;->_onEvent(Landroid/media/MediaDrm;[BII[B)V

    return-void
.end method
