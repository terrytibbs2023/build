.class public Lorg/xbmc/kodi/interfaces/XBMCNsdManagerRegistrationListener;
.super Ljava/lang/Object;
.source "XBMCNsdManagerRegistrationListener.java"

# interfaces
.implements Landroid/net/nsd/NsdManager$RegistrationListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method native _onRegistrationFailed(Landroid/net/nsd/NsdServiceInfo;I)V
.end method

.method native _onServiceRegistered(Landroid/net/nsd/NsdServiceInfo;)V
.end method

.method native _onServiceUnregistered(Landroid/net/nsd/NsdServiceInfo;)V
.end method

.method native _onUnregistrationFailed(Landroid/net/nsd/NsdServiceInfo;I)V
.end method

.method public onRegistrationFailed(Landroid/net/nsd/NsdServiceInfo;I)V
    .locals 0

    .line 19
    invoke-virtual {p0, p1, p2}, Lorg/xbmc/kodi/interfaces/XBMCNsdManagerRegistrationListener;->_onRegistrationFailed(Landroid/net/nsd/NsdServiceInfo;I)V

    return-void
.end method

.method public onServiceRegistered(Landroid/net/nsd/NsdServiceInfo;)V
    .locals 0

    .line 26
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCNsdManagerRegistrationListener;->_onServiceRegistered(Landroid/net/nsd/NsdServiceInfo;)V

    return-void
.end method

.method public onServiceUnregistered(Landroid/net/nsd/NsdServiceInfo;)V
    .locals 0

    .line 33
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/interfaces/XBMCNsdManagerRegistrationListener;->_onServiceUnregistered(Landroid/net/nsd/NsdServiceInfo;)V

    return-void
.end method

.method public onUnregistrationFailed(Landroid/net/nsd/NsdServiceInfo;I)V
    .locals 0

    .line 40
    invoke-virtual {p0, p1, p2}, Lorg/xbmc/kodi/interfaces/XBMCNsdManagerRegistrationListener;->_onUnregistrationFailed(Landroid/net/nsd/NsdServiceInfo;I)V

    return-void
.end method
