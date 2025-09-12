.class Lorg/xbmc/kodi/Splash$StateMachine$1;
.super Ljava/lang/Object;
.source "Splash.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/xbmc/kodi/Splash$StateMachine;->handleMessage(Landroid/os/Message;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lorg/xbmc/kodi/Splash$StateMachine;


# direct methods
.method constructor <init>(Lorg/xbmc/kodi/Splash$StateMachine;)V
    .locals 0

    .line 115
    iput-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine$1;->this$1:Lorg/xbmc/kodi/Splash$StateMachine;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 119
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine$1;->this$1:Lorg/xbmc/kodi/Splash$StateMachine;

    iget-object p1, p1, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$200(Lorg/xbmc/kodi/Splash;)Lorg/xbmc/kodi/Splash$StateMachine;

    move-result-object p1

    const/16 p2, 0xd

    invoke-virtual {p1, p2}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    return-void
.end method
