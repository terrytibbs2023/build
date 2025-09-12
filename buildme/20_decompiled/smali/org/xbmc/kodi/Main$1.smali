.class Lorg/xbmc/kodi/Main$1;
.super Ljava/lang/Object;
.source "Main.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/xbmc/kodi/Main;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/xbmc/kodi/Main;


# direct methods
.method constructor <init>(Lorg/xbmc/kodi/Main;)V
    .locals 0

    .line 66
    iput-object p1, p0, Lorg/xbmc/kodi/Main$1;->this$0:Lorg/xbmc/kodi/Main;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    const-string v0, "Kodi"

    const-string v1, "Main: Updating recommendations"

    .line 70
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 71
    new-instance v0, Lorg/xbmc/kodi/Main$1$1;

    invoke-direct {v0, p0}, Lorg/xbmc/kodi/Main$1$1;-><init>(Lorg/xbmc/kodi/Main$1;)V

    .line 77
    invoke-virtual {v0}, Lorg/xbmc/kodi/Main$1$1;->start()V

    .line 78
    iget-object v0, p0, Lorg/xbmc/kodi/Main$1;->this$0:Lorg/xbmc/kodi/Main;

    invoke-static {v0}, Lorg/xbmc/kodi/Main;->access$100(Lorg/xbmc/kodi/Main;)Landroid/os/Handler;

    move-result-object v0

    const-string v1, "xbmc.leanbackrefresh"

    const/16 v2, 0xe10

    invoke-static {v1, v2}, Lorg/xbmc/kodi/XBMCProperties;->getIntProperty(Ljava/lang/String;I)I

    move-result v1

    mul-int/lit16 v1, v1, 0x3e8

    int-to-long v1, v1

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
