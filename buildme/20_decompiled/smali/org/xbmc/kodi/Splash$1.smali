.class Lorg/xbmc/kodi/Splash$1;
.super Ljava/lang/Object;
.source "Splash.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/xbmc/kodi/Splash;->showErrorDialog(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/xbmc/kodi/Splash;

.field final synthetic val$act:Landroid/app/Activity;


# direct methods
.method constructor <init>(Lorg/xbmc/kodi/Splash;Landroid/app/Activity;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 412
    iput-object p1, p0, Lorg/xbmc/kodi/Splash$1;->this$0:Lorg/xbmc/kodi/Splash;

    iput-object p2, p0, Lorg/xbmc/kodi/Splash$1;->val$act:Landroid/app/Activity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 415
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    .line 416
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$1;->val$act:Landroid/app/Activity;

    invoke-virtual {p1}, Landroid/app/Activity;->finish()V

    return-void
.end method
