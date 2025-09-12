.class public Lorg/xbmc/kodi/XBMCMainView;
.super Landroid/view/SurfaceView;
.source "XBMCMainView.java"

# interfaces
.implements Landroid/view/SurfaceHolder$Callback;


# static fields
.field private static final TAG:Ljava/lang/String; = "Kodi"


# instance fields
.field public mIsCreated:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    .line 27
    invoke-direct {p0, p1}, Landroid/view/SurfaceView;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    .line 23
    iput-boolean p1, p0, Lorg/xbmc/kodi/XBMCMainView;->mIsCreated:Z

    const/4 p1, 0x1

    .line 28
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCMainView;->setZOrderOnTop(Z)V

    .line 29
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCMainView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object p1

    invoke-interface {p1, p0}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    .line 30
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCMainView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object p1

    const/4 v0, -0x2

    invoke-interface {p1, v0}, Landroid/view/SurfaceHolder;->setFormat(I)V

    const-string p1, "Kodi"

    const-string v0, "XBMCMainView: Created"

    .line 32
    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1

    const/4 v0, 0x0

    .line 47
    invoke-direct {p0, p1, p2, v0}, Lorg/xbmc/kodi/XBMCMainView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    .line 37
    invoke-direct {p0, p1, p2, p3}, Landroid/view/SurfaceView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    .line 23
    iput-boolean p1, p0, Lorg/xbmc/kodi/XBMCMainView;->mIsCreated:Z

    const/4 p1, 0x1

    .line 38
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCMainView;->setZOrderOnTop(Z)V

    .line 39
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCMainView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object p1

    invoke-interface {p1, p0}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    .line 40
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCMainView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object p1

    const/4 p2, -0x2

    invoke-interface {p1, p2}, Landroid/view/SurfaceHolder;->setFormat(I)V

    const-string p1, "Kodi"

    const-string p2, "XBMCMainView: Created"

    .line 42
    invoke-static {p1, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method


# virtual methods
.method native _attach()V
.end method

.method native _surfaceChanged(Landroid/view/SurfaceHolder;III)V
.end method

.method native _surfaceCreated(Landroid/view/SurfaceHolder;)V
.end method

.method native _surfaceDestroyed(Landroid/view/SurfaceHolder;)V
.end method

.method public surfaceChanged(Landroid/view/SurfaceHolder;III)V
    .locals 2

    .line 63
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCMainView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    if-eq p1, v0, :cond_0

    return-void

    .line 66
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "XBMCMainView: Surface Changed, format:"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", width:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", height:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Kodi"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 67
    invoke-virtual {p0, p1, p2, p3, p4}, Lorg/xbmc/kodi/XBMCMainView;->_surfaceChanged(Landroid/view/SurfaceHolder;III)V

    return-void
.end method

.method public surfaceCreated(Landroid/view/SurfaceHolder;)V
    .locals 2

    const-string v0, "Kodi"

    const-string v1, "XBMCMainView: Surface Created"

    .line 53
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    .line 54
    iput-boolean v0, p0, Lorg/xbmc/kodi/XBMCMainView;->mIsCreated:Z

    .line 55
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCMainView;->_attach()V

    .line 56
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCMainView;->_surfaceCreated(Landroid/view/SurfaceHolder;)V

    return-void
.end method

.method public surfaceDestroyed(Landroid/view/SurfaceHolder;)V
    .locals 2

    const-string v0, "Kodi"

    const-string v1, "XBMCMainView: Surface Destroyed"

    .line 73
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    .line 74
    iput-boolean v0, p0, Lorg/xbmc/kodi/XBMCMainView;->mIsCreated:Z

    .line 75
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCMainView;->_surfaceDestroyed(Landroid/view/SurfaceHolder;)V

    return-void
.end method
