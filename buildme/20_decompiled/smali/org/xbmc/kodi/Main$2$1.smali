.class Lorg/xbmc/kodi/Main$2$1;
.super Ljava/lang/Object;
.source "Main.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/xbmc/kodi/Main$2;->onSystemUiVisibilityChange(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lorg/xbmc/kodi/Main$2;


# direct methods
.method constructor <init>(Lorg/xbmc/kodi/Main$2;)V
    .locals 0

    .line 183
    iput-object p1, p0, Lorg/xbmc/kodi/Main$2$1;->this$1:Lorg/xbmc/kodi/Main$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 187
    iget-object v0, p0, Lorg/xbmc/kodi/Main$2$1;->this$1:Lorg/xbmc/kodi/Main$2;

    iget-object v0, v0, Lorg/xbmc/kodi/Main$2;->this$0:Lorg/xbmc/kodi/Main;

    invoke-static {v0}, Lorg/xbmc/kodi/Main;->access$200(Lorg/xbmc/kodi/Main;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x1706

    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    return-void
.end method
