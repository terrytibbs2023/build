.class Lorg/xbmc/kodi/Main$2;
.super Ljava/lang/Object;
.source "Main.java"

# interfaces
.implements Landroid/view/View$OnSystemUiVisibilityChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/xbmc/kodi/Main;->onCreate(Landroid/os/Bundle;)V
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

    .line 176
    iput-object p1, p0, Lorg/xbmc/kodi/Main$2;->this$0:Lorg/xbmc/kodi/Main;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSystemUiVisibilityChange(I)V
    .locals 1

    and-int/lit8 p1, p1, 0x2

    if-nez p1, :cond_0

    .line 182
    iget-object p1, p0, Lorg/xbmc/kodi/Main$2;->this$0:Lorg/xbmc/kodi/Main;

    invoke-static {p1}, Lorg/xbmc/kodi/Main;->access$100(Lorg/xbmc/kodi/Main;)Landroid/os/Handler;

    move-result-object p1

    new-instance v0, Lorg/xbmc/kodi/Main$2$1;

    invoke-direct {v0, p0}, Lorg/xbmc/kodi/Main$2$1;-><init>(Lorg/xbmc/kodi/Main$2;)V

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_0
    return-void
.end method
