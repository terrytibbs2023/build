.class public Lorg/xbmc/kodi/interfaces/XBMCNsdManagerResolveListener;
.super Ljava/lang/Object;
.source "XBMCNsdManagerResolveListener.java"

# interfaces
.implements Landroid/net/nsd/NsdManager$ResolveListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method native _onResolveFailed(Landroid/net/nsd/NsdServiceInfo;I)V
.end method

.method native _onServiceResolved(Landroid/net/nsd/NsdServiceInfo;)V
.end method

.method public onResolveFailed(Landroid/net/nsd/NsdServiceInfo;I)V
    .locals 0

    .line 15
    invoke-virtual {p0, p1, p2}, Lorg/xbmc/kodi/interfaces/XBMCNsdManagerResolveListener;->_onResolveFailed(Landroid/net/nsd/NsdServiceInfo;I)V

    return-void
.end method

.method public onServiceResolved(Landroid/net/nsd/NsdServiceInfo;)V
    .locals 0

    .line 22
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCNsdManagerResolveListener;->_onServiceResolved(Landroid/net/nsd/NsdServiceInfo;)V

    return-void
.end method
