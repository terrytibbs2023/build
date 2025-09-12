.class public Lorg/xbmc/kodi/XBMCBroadcastReceiver;
.super Landroid/content/BroadcastReceiver;
.source "XBMCBroadcastReceiver.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "Kodi"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method native _onReceive(Landroid/content/Intent;)V
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2

    const-string v0, "android.intent.action.BOOT_COMPLETED"

    .line 18
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string p2, "xbmc.autostart"

    .line 20
    invoke-static {p2}, Lorg/xbmc/kodi/XBMCProperties;->getBoolProperty(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    .line 23
    new-instance p2, Landroid/content/Intent;

    invoke-direct {p2}, Landroid/content/Intent;-><init>()V

    .line 24
    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p2

    const-string v0, "org.xbmc.kodi"

    .line 25
    invoke-virtual {p2, v0}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p2

    const-string v0, "android.intent.category.LAUNCHER"

    .line 26
    invoke-virtual {p2, v0}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 27
    invoke-virtual {p1, p2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    goto :goto_0

    .line 34
    :cond_0
    :try_start_0
    invoke-virtual {p0, p2}, Lorg/xbmc/kodi/XBMCBroadcastReceiver;->_onReceive(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const-string p1, "Kodi"

    const-string p2, "XBMCBroadcastReceiver: Native not registered"

    .line 38
    invoke-static {p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    :goto_0
    return-void
.end method
