.class public Lorg/xbmc/kodi/XBMCVideoView;
.super Landroid/view/SurfaceView;
.source "XBMCVideoView.java"

# interfaces
.implements Landroid/view/SurfaceHolder$Callback;


# static fields
.field private static final TAG:Ljava/lang/String; = "Kodi"


# instance fields
.field public mIsCreated:Z

.field private mVideoLayout:Landroid/widget/RelativeLayout;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    .line 54
    invoke-direct {p0, p1}, Landroid/view/SurfaceView;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    .line 25
    iput-boolean p1, p0, Lorg/xbmc/kodi/XBMCVideoView;->mIsCreated:Z

    const/4 p1, 0x0

    .line 26
    iput-object p1, p0, Lorg/xbmc/kodi/XBMCVideoView;->mVideoLayout:Landroid/widget/RelativeLayout;

    const/4 p1, 0x1

    .line 55
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCVideoView;->setZOrderMediaOverlay(Z)V

    .line 56
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCVideoView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object p1

    invoke-interface {p1, p0}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    .line 57
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCVideoView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object p1

    const/4 v0, -0x2

    invoke-interface {p1, v0}, Landroid/view/SurfaceHolder;->setFormat(I)V

    .line 59
    sget-object p1, Lorg/xbmc/kodi/Main;->MainActivity:Lorg/xbmc/kodi/Main;

    sget v0, Lorg/xbmc/kodi/R$id;->VideoLayout:I

    invoke-virtual {p1, v0}, Lorg/xbmc/kodi/Main;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/RelativeLayout;

    iput-object p1, p0, Lorg/xbmc/kodi/XBMCVideoView;->mVideoLayout:Landroid/widget/RelativeLayout;

    return-void
.end method

.method static synthetic access$000(Lorg/xbmc/kodi/XBMCVideoView;)Landroid/widget/RelativeLayout;
    .locals 0

    .line 14
    iget-object p0, p0, Lorg/xbmc/kodi/XBMCVideoView;->mVideoLayout:Landroid/widget/RelativeLayout;

    return-object p0
.end method

.method public static createVideoView()Lorg/xbmc/kodi/XBMCVideoView;
    .locals 2

    .line 30
    new-instance v0, Ljava/util/concurrent/FutureTask;

    new-instance v1, Lorg/xbmc/kodi/XBMCVideoView$1;

    invoke-direct {v1}, Lorg/xbmc/kodi/XBMCVideoView$1;-><init>()V

    invoke-direct {v0, v1}, Ljava/util/concurrent/FutureTask;-><init>(Ljava/util/concurrent/Callable;)V

    .line 41
    :try_start_0
    sget-object v1, Lorg/xbmc/kodi/Main;->MainActivity:Lorg/xbmc/kodi/Main;

    invoke-virtual {v1, v0}, Lorg/xbmc/kodi/Main;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 42
    invoke-virtual {v0}, Ljava/util/concurrent/FutureTask;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/xbmc/kodi/XBMCVideoView;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    .line 47
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    const/4 v0, 0x0

    return-object v0
.end method


# virtual methods
.method native _surfaceChanged(Landroid/view/SurfaceHolder;III)V
.end method

.method native _surfaceCreated(Landroid/view/SurfaceHolder;)V
.end method

.method native _surfaceDestroyed(Landroid/view/SurfaceHolder;)V
.end method

.method public add()V
    .locals 2

    .line 64
    sget-object v0, Lorg/xbmc/kodi/Main;->MainActivity:Lorg/xbmc/kodi/Main;

    new-instance v1, Lorg/xbmc/kodi/XBMCVideoView$2;

    invoke-direct {v1, p0}, Lorg/xbmc/kodi/XBMCVideoView$2;-><init>(Lorg/xbmc/kodi/XBMCVideoView;)V

    invoke-virtual {v0, v1}, Lorg/xbmc/kodi/Main;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public getSurface()Landroid/view/Surface;
    .locals 2

    .line 89
    iget-boolean v0, p0, Lorg/xbmc/kodi/XBMCVideoView;->mIsCreated:Z

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 95
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "XBMCVideoView.getSurface() = "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCVideoView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v1

    invoke-interface {v1}, Landroid/view/SurfaceHolder;->getSurface()Landroid/view/Surface;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Kodi"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 96
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCVideoView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    invoke-interface {v0}, Landroid/view/SurfaceHolder;->getSurface()Landroid/view/Surface;

    move-result-object v0

    return-object v0
.end method

.method public release()V
    .locals 2

    .line 77
    sget-object v0, Lorg/xbmc/kodi/Main;->MainActivity:Lorg/xbmc/kodi/Main;

    new-instance v1, Lorg/xbmc/kodi/XBMCVideoView$3;

    invoke-direct {v1, p0}, Lorg/xbmc/kodi/XBMCVideoView$3;-><init>(Lorg/xbmc/kodi/XBMCVideoView;)V

    invoke-virtual {v0, v1}, Lorg/xbmc/kodi/Main;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public setSurfaceRect(IIII)V
    .locals 8

    .line 102
    sget-object v0, Lorg/xbmc/kodi/Main;->MainActivity:Lorg/xbmc/kodi/Main;

    new-instance v7, Lorg/xbmc/kodi/XBMCVideoView$4;

    move-object v1, v7

    move-object v2, p0

    move v3, p1

    move v4, p2

    move v5, p3

    move v6, p4

    invoke-direct/range {v1 .. v6}, Lorg/xbmc/kodi/XBMCVideoView$4;-><init>(Lorg/xbmc/kodi/XBMCVideoView;IIII)V

    invoke-virtual {v0, v7}, Lorg/xbmc/kodi/Main;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public surfaceChanged(Landroid/view/SurfaceHolder;III)V
    .locals 1

    .line 139
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCVideoView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    if-eq p1, v0, :cond_0

    return-void

    .line 142
    :cond_0
    invoke-virtual {p0, p1, p2, p3, p4}, Lorg/xbmc/kodi/XBMCVideoView;->_surfaceChanged(Landroid/view/SurfaceHolder;III)V

    .line 144
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "XBMCVideoView: Changed, format:"

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p2, ", width:"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p2, ", height:"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, "Kodi"

    invoke-static {p2, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public surfaceCreated(Landroid/view/SurfaceHolder;)V
    .locals 2

    const-string v0, "Kodi"

    const-string v1, "XBMCVideoView: Created"

    .line 130
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    .line 131
    iput-boolean v0, p0, Lorg/xbmc/kodi/XBMCVideoView;->mIsCreated:Z

    .line 132
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCVideoView;->_surfaceCreated(Landroid/view/SurfaceHolder;)V

    return-void
.end method

.method public surfaceDestroyed(Landroid/view/SurfaceHolder;)V
    .locals 2

    const-string v0, "Kodi"

    const-string v1, "XBMCVideoView: Destroyed"

    .line 151
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    .line 152
    iput-boolean v0, p0, Lorg/xbmc/kodi/XBMCVideoView;->mIsCreated:Z

    .line 153
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCVideoView;->_surfaceDestroyed(Landroid/view/SurfaceHolder;)V

    return-void
.end method
