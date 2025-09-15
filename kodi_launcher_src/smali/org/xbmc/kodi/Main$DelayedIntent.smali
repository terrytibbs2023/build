.class Lorg/xbmc/kodi/Main$DelayedIntent;
.super Ljava/lang/Object;
.source "Main.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/xbmc/kodi/Main;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DelayedIntent"
.end annotation


# instance fields
.field public mDelay:I

.field public mIntent:Landroid/content/Intent;

.field final synthetic this$0:Lorg/xbmc/kodi/Main;


# direct methods
.method public constructor <init>(Lorg/xbmc/kodi/Main;Landroid/content/Intent;I)V
    .locals 0

    .line 48
    iput-object p1, p0, Lorg/xbmc/kodi/Main$DelayedIntent;->this$0:Lorg/xbmc/kodi/Main;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 49
    iput-object p2, p0, Lorg/xbmc/kodi/Main$DelayedIntent;->mIntent:Landroid/content/Intent;

    .line 50
    iput p3, p0, Lorg/xbmc/kodi/Main$DelayedIntent;->mDelay:I

    return-void
.end method
