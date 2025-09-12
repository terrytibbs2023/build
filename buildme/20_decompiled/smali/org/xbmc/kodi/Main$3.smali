.class Lorg/xbmc/kodi/Main$3;
.super Ljava/lang/Object;
.source "Main.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/xbmc/kodi/Main;->onResume()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/xbmc/kodi/Main;

.field final synthetic val$delayedIntent:Lorg/xbmc/kodi/Main$DelayedIntent;


# direct methods
.method constructor <init>(Lorg/xbmc/kodi/Main;Lorg/xbmc/kodi/Main$DelayedIntent;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 259
    iput-object p1, p0, Lorg/xbmc/kodi/Main$3;->this$0:Lorg/xbmc/kodi/Main;

    iput-object p2, p0, Lorg/xbmc/kodi/Main$3;->val$delayedIntent:Lorg/xbmc/kodi/Main$DelayedIntent;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 265
    :try_start_0
    iget-object v0, p0, Lorg/xbmc/kodi/Main$3;->this$0:Lorg/xbmc/kodi/Main;

    iget-object v1, p0, Lorg/xbmc/kodi/Main$3;->val$delayedIntent:Lorg/xbmc/kodi/Main$DelayedIntent;

    iget-object v1, v1, Lorg/xbmc/kodi/Main$DelayedIntent;->mIntent:Landroid/content/Intent;

    invoke-virtual {v0, v1}, Lorg/xbmc/kodi/Main;->_onNewIntent(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const-string v0, "Kodi"

    const-string v1, "Main: Native not registered"

    .line 269
    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void
.end method
