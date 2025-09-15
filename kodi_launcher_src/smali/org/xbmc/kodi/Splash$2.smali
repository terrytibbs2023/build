.class Lorg/xbmc/kodi/Splash$2;
.super Landroid/content/BroadcastReceiver;
.source "Splash.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/xbmc/kodi/Splash;->startWatchingExternalStorage()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/xbmc/kodi/Splash;


# direct methods
.method constructor <init>(Lorg/xbmc/kodi/Splash;)V
    .locals 0

    .line 596
    iput-object p1, p0, Lorg/xbmc/kodi/Splash$2;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1

    .line 600
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "Storage: "

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, "Kodi"

    invoke-static {p2, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 601
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$2;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-virtual {p1}, Lorg/xbmc/kodi/Splash;->updateExternalStorageState()V

    return-void
.end method
