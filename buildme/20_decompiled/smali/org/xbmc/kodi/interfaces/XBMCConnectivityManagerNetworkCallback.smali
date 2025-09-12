.class public Lorg/xbmc/kodi/interfaces/XBMCConnectivityManagerNetworkCallback;
.super Landroid/net/ConnectivityManager$NetworkCallback;
.source "XBMCConnectivityManagerNetworkCallback.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Landroid/net/ConnectivityManager$NetworkCallback;-><init>()V

    return-void
.end method


# virtual methods
.method native _onAvailable(Landroid/net/Network;)V
.end method

.method native _onLost(Landroid/net/Network;)V
.end method

.method public onAvailable(Landroid/net/Network;)V
    .locals 0

    .line 13
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCConnectivityManagerNetworkCallback;->_onAvailable(Landroid/net/Network;)V

    return-void
.end method

.method public onLost(Landroid/net/Network;)V
    .locals 0

    .line 18
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCConnectivityManagerNetworkCallback;->_onLost(Landroid/net/Network;)V

    return-void
.end method
