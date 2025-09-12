.class Lorg/xbmc/kodi/Main$1$1;
.super Ljava/lang/Thread;
.source "Main.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/xbmc/kodi/Main$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lorg/xbmc/kodi/Main$1;


# direct methods
.method constructor <init>(Lorg/xbmc/kodi/Main$1;)V
    .locals 0

    .line 72
    iput-object p1, p0, Lorg/xbmc/kodi/Main$1$1;->this$1:Lorg/xbmc/kodi/Main$1;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 75
    iget-object v0, p0, Lorg/xbmc/kodi/Main$1$1;->this$1:Lorg/xbmc/kodi/Main$1;

    iget-object v0, v0, Lorg/xbmc/kodi/Main$1;->this$0:Lorg/xbmc/kodi/Main;

    invoke-static {v0}, Lorg/xbmc/kodi/Main;->access$000(Lorg/xbmc/kodi/Main;)Lorg/xbmc/kodi/XBMCJsonRPC;

    move-result-object v0

    iget-object v1, p0, Lorg/xbmc/kodi/Main$1$1;->this$1:Lorg/xbmc/kodi/Main$1;

    iget-object v1, v1, Lorg/xbmc/kodi/Main$1;->this$0:Lorg/xbmc/kodi/Main;

    invoke-virtual {v0, v1}, Lorg/xbmc/kodi/XBMCJsonRPC;->updateLeanback(Landroid/content/Context;)V

    return-void
.end method
