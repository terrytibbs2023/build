.class public Lorg/xbmc/kodi/interfaces/XBMCNsdManagerDiscoveryListener;
.super Ljava/lang/Object;
.source "XBMCNsdManagerDiscoveryListener.java"

# interfaces
.implements Landroid/net/nsd/NsdManager$DiscoveryListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method native _onDiscoveryStarted(Ljava/lang/String;)V
.end method

.method native _onDiscoveryStopped(Ljava/lang/String;)V
.end method

.method native _onServiceFound(Landroid/net/nsd/NsdServiceInfo;)V
.end method

.method native _onServiceLost(Landroid/net/nsd/NsdServiceInfo;)V
.end method

.method native _onStartDiscoveryFailed(Ljava/lang/String;I)V
.end method

.method native _onStopDiscoveryFailed(Ljava/lang/String;I)V
.end method

.method public onDiscoveryStarted(Ljava/lang/String;)V
    .locals 0

    .line 23
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCNsdManagerDiscoveryListener;->_onDiscoveryStarted(Ljava/lang/String;)V

    return-void
.end method

.method public onDiscoveryStopped(Ljava/lang/String;)V
    .locals 0

    .line 29
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCNsdManagerDiscoveryListener;->_onDiscoveryStopped(Ljava/lang/String;)V

    return-void
.end method

.method public onServiceFound(Landroid/net/nsd/NsdServiceInfo;)V
    .locals 0

    .line 35
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCNsdManagerDiscoveryListener;->_onServiceFound(Landroid/net/nsd/NsdServiceInfo;)V

    return-void
.end method

.method public onServiceLost(Landroid/net/nsd/NsdServiceInfo;)V
    .locals 0

    .line 41
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCNsdManagerDiscoveryListener;->_onServiceLost(Landroid/net/nsd/NsdServiceInfo;)V

    return-void
.end method

.method public onStartDiscoveryFailed(Ljava/lang/String;I)V
    .locals 0

    .line 47
    invoke-virtual {p0, p1, p2}, Lorg/xbmc/kodi/interfaces/XBMCNsdManagerDiscoveryListener;->_onStartDiscoveryFailed(Ljava/lang/String;I)V

    return-void
.end method

.method public onStopDiscoveryFailed(Ljava/lang/String;I)V
    .locals 0

    .line 53
    invoke-virtual {p0, p1, p2}, Lorg/xbmc/kodi/interfaces/XBMCNsdManagerDiscoveryListener;->_onStopDiscoveryFailed(Ljava/lang/String;I)V

    return-void
.end method
