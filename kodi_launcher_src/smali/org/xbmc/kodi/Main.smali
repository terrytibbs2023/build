.class public Lorg/xbmc/kodi/Main;
.super Landroid/app/NativeActivity;
.source "Main.java"

# interfaces
.implements Landroid/view/Choreographer$FrameCallback;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/xbmc/kodi/Main$DelayedIntent;
    }
.end annotation


# static fields
.field public static MainActivity:Lorg/xbmc/kodi/Main; = null

.field private static final TAG:Ljava/lang/String; = "Kodi"


# instance fields
.field private handler:Landroid/os/Handler;

.field private leanbackUpdateRunnable:Ljava/lang/Runnable;

.field private mDecorView:Landroid/view/View;

.field private mDelayedIntents:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lorg/xbmc/kodi/Main$DelayedIntent;",
            ">;"
        }
    .end annotation
.end field

.field private mInputDeviceListener:Lorg/xbmc/kodi/XBMCInputDeviceListener;

.field private mJsonRPC:Lorg/xbmc/kodi/XBMCJsonRPC;

.field public mMainView:Lorg/xbmc/kodi/XBMCMainView;

.field private mPaused:Z

.field private mSettingsContentObserver:Lorg/xbmc/kodi/XBMCSettingsContentObserver;

.field private mVideoLayout:Landroid/widget/RelativeLayout;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 84
    invoke-direct {p0}, Landroid/app/NativeActivity;-><init>()V

    const/4 v0, 0x0

    .line 34
    iput-object v0, p0, Lorg/xbmc/kodi/Main;->mMainView:Lorg/xbmc/kodi/XBMCMainView;

    .line 38
    iput-object v0, p0, Lorg/xbmc/kodi/Main;->mJsonRPC:Lorg/xbmc/kodi/XBMCJsonRPC;

    .line 39
    iput-object v0, p0, Lorg/xbmc/kodi/Main;->mDecorView:Landroid/view/View;

    .line 40
    iput-object v0, p0, Lorg/xbmc/kodi/Main;->mVideoLayout:Landroid/widget/RelativeLayout;

    .line 41
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lorg/xbmc/kodi/Main;->handler:Landroid/os/Handler;

    .line 53
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/xbmc/kodi/Main;->mDelayedIntents:Ljava/util/ArrayList;

    const/4 v0, 0x1

    .line 54
    iput-boolean v0, p0, Lorg/xbmc/kodi/Main;->mPaused:Z

    .line 65
    new-instance v0, Lorg/xbmc/kodi/Main$1;

    invoke-direct {v0, p0}, Lorg/xbmc/kodi/Main$1;-><init>(Lorg/xbmc/kodi/Main;)V

    iput-object v0, p0, Lorg/xbmc/kodi/Main;->leanbackUpdateRunnable:Ljava/lang/Runnable;

    .line 85
    sput-object p0, Lorg/xbmc/kodi/Main;->MainActivity:Lorg/xbmc/kodi/Main;

    return-void
.end method

.method private native _callNative(JJ)V
.end method

.method static synthetic access$000(Lorg/xbmc/kodi/Main;)Lorg/xbmc/kodi/XBMCJsonRPC;
    .locals 0

    .line 29
    iget-object p0, p0, Lorg/xbmc/kodi/Main;->mJsonRPC:Lorg/xbmc/kodi/XBMCJsonRPC;

    return-object p0
.end method

.method static synthetic access$100(Lorg/xbmc/kodi/Main;)Landroid/os/Handler;
    .locals 0

    .line 29
    iget-object p0, p0, Lorg/xbmc/kodi/Main;->handler:Landroid/os/Handler;

    return-object p0
.end method

.method static synthetic access$200(Lorg/xbmc/kodi/Main;)Landroid/view/View;
    .locals 0

    .line 29
    iget-object p0, p0, Lorg/xbmc/kodi/Main;->mDecorView:Landroid/view/View;

    return-object p0
.end method

.method static synthetic access$300(Lorg/xbmc/kodi/Main;JJ)V
    .locals 0

    .line 29
    invoke-direct {p0, p1, p2, p3, p4}, Lorg/xbmc/kodi/Main;->_callNative(JJ)V

    return-void
.end method

.method private getLauncherName()Ljava/lang/String;
    .locals 3

    .line 345
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.MAIN"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v1, "android.intent.category.HOME"

    .line 346
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 347
    invoke-virtual {p0}, Lorg/xbmc/kodi/Main;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Landroid/content/pm/PackageManager;->resolveActivity(Landroid/content/Intent;I)Landroid/content/pm/ResolveInfo;

    move-result-object v0

    .line 348
    iget-object v0, v0, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    iget-object v0, v0, Landroid/content/pm/ActivityInfo;->packageName:Ljava/lang/String;

    return-object v0
.end method

.method private runNativeOnUiThread(JJ)V
    .locals 7

    .line 331
    new-instance v6, Lorg/xbmc/kodi/Main$4;

    move-object v0, v6

    move-object v1, p0

    move-wide v2, p1

    move-wide v4, p3

    invoke-direct/range {v0 .. v5}, Lorg/xbmc/kodi/Main$4;-><init>(Lorg/xbmc/kodi/Main;JJ)V

    invoke-virtual {p0, v6}, Lorg/xbmc/kodi/Main;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method


# virtual methods
.method native _doFrame(J)V
.end method

.method native _onActivityResult(IILandroid/content/Intent;)V
.end method

.method native _onNewIntent(Landroid/content/Intent;)V
.end method

.method native _onVisibleBehindCanceled()V
.end method

.method public doFrame(J)V
    .locals 1

    .line 323
    invoke-static {}, Landroid/view/Choreographer;->getInstance()Landroid/view/Choreographer;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/Choreographer;->postFrameCallback(Landroid/view/Choreographer$FrameCallback;)V

    .line 324
    invoke-virtual {p0, p1, p2}, Lorg/xbmc/kodi/Main;->_doFrame(J)V

    return-void
.end method

.method public getDisplayRect()Landroid/graphics/Rect;
    .locals 2

    .line 90
    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    const/4 v1, 0x0

    .line 91
    iput v1, v0, Landroid/graphics/Rect;->top:I

    .line 92
    iput v1, v0, Landroid/graphics/Rect;->left:I

    .line 93
    iput v1, v0, Landroid/graphics/Rect;->right:I

    .line 94
    iput v1, v0, Landroid/graphics/Rect;->bottom:I

    .line 98
    :try_start_0
    iget-object v1, p0, Lorg/xbmc/kodi/Main;->mDecorView:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getRootView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getWidth()I

    move-result v1

    iput v1, v0, Landroid/graphics/Rect;->right:I

    .line 99
    iget-object v1, p0, Lorg/xbmc/kodi/Main;->mDecorView:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getRootView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getHeight()I

    move-result v1

    iput v1, v0, Landroid/graphics/Rect;->bottom:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-object v0
.end method

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 0

    .line 296
    invoke-super {p0, p1, p2, p3}, Landroid/app/NativeActivity;->onActivityResult(IILandroid/content/Intent;)V

    .line 297
    invoke-virtual {p0, p1, p2, p3}, Lorg/xbmc/kodi/Main;->_onActivityResult(IILandroid/content/Intent;)V

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 4

    const-string v0, "kodi"

    .line 123
    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 125
    invoke-super {p0, p1}, Landroid/app/NativeActivity;->onCreate(Landroid/os/Bundle;)V

    .line 127
    sget p1, Lorg/xbmc/kodi/R$layout;->activity_main:I

    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/Main;->setContentView(I)V

    const/4 p1, 0x3

    .line 128
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/Main;->setVolumeControlStream(I)V

    .line 130
    new-instance p1, Lorg/xbmc/kodi/XBMCSettingsContentObserver;

    iget-object v0, p0, Lorg/xbmc/kodi/Main;->handler:Landroid/os/Handler;

    invoke-direct {p1, p0, v0}, Lorg/xbmc/kodi/XBMCSettingsContentObserver;-><init>(Landroid/content/Context;Landroid/os/Handler;)V

    iput-object p1, p0, Lorg/xbmc/kodi/Main;->mSettingsContentObserver:Lorg/xbmc/kodi/XBMCSettingsContentObserver;

    .line 131
    invoke-virtual {p0}, Lorg/xbmc/kodi/Main;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    sget-object v0, Landroid/provider/Settings$System;->CONTENT_URI:Landroid/net/Uri;

    const/4 v1, 0x1

    iget-object v2, p0, Lorg/xbmc/kodi/Main;->mSettingsContentObserver:Lorg/xbmc/kodi/XBMCSettingsContentObserver;

    invoke-virtual {p1, v0, v1, v2}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    .line 134
    invoke-virtual {p0}, Lorg/xbmc/kodi/Main;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p1

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    .line 136
    iget-object p1, p0, Lorg/xbmc/kodi/Main;->mDelayedIntents:Ljava/util/ArrayList;

    new-instance v1, Lorg/xbmc/kodi/Main$DelayedIntent;

    new-instance v2, Landroid/content/Intent;

    invoke-virtual {p0}, Lorg/xbmc/kodi/Main;->getIntent()Landroid/content/Intent;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Intent;)V

    const/16 v3, 0x1388

    invoke-direct {v1, p0, v2, v3}, Lorg/xbmc/kodi/Main$DelayedIntent;-><init>(Lorg/xbmc/kodi/Main;Landroid/content/Intent;I)V

    invoke-virtual {p1, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 137
    invoke-virtual {p0}, Lorg/xbmc/kodi/Main;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 140
    :cond_0
    invoke-virtual {p0}, Lorg/xbmc/kodi/Main;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p1

    const-string v1, "android.software.leanback"

    invoke-virtual {p1, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    .line 142
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt p1, v1, :cond_1

    .line 143
    invoke-direct {p0}, Lorg/xbmc/kodi/Main;->getLauncherName()Ljava/lang/String;

    move-result-object p1

    const-string v2, "com.google.android.tvlauncher"

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    .line 145
    invoke-static {p0}, Lorg/xbmc/kodi/channels/util/TvUtil;->scheduleSyncingChannel(Landroid/content/Context;)V

    goto :goto_0

    .line 147
    :cond_1
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ge p1, v1, :cond_2

    .line 148
    invoke-direct {p0}, Lorg/xbmc/kodi/Main;->getLauncherName()Ljava/lang/String;

    move-result-object p1

    const-string v1, "com.google.android.leanbacklauncher"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    .line 151
    new-instance p1, Lorg/xbmc/kodi/XBMCJsonRPC;

    invoke-direct {p1}, Lorg/xbmc/kodi/XBMCJsonRPC;-><init>()V

    iput-object p1, p0, Lorg/xbmc/kodi/Main;->mJsonRPC:Lorg/xbmc/kodi/XBMCJsonRPC;

    .line 152
    iget-object p1, p0, Lorg/xbmc/kodi/Main;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lorg/xbmc/kodi/Main;->leanbackUpdateRunnable:Ljava/lang/Runnable;

    invoke-virtual {p1, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 153
    iget-object p1, p0, Lorg/xbmc/kodi/Main;->handler:Landroid/os/Handler;

    iget-object v1, p0, Lorg/xbmc/kodi/Main;->leanbackUpdateRunnable:Ljava/lang/Runnable;

    const-wide/16 v2, 0x7530

    invoke-virtual {p1, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 158
    :cond_2
    :goto_0
    new-instance p1, Lorg/xbmc/kodi/XBMCInputDeviceListener;

    invoke-direct {p1}, Lorg/xbmc/kodi/XBMCInputDeviceListener;-><init>()V

    iput-object p1, p0, Lorg/xbmc/kodi/Main;->mInputDeviceListener:Lorg/xbmc/kodi/XBMCInputDeviceListener;

    const-string p1, "input"

    .line 159
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/Main;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/hardware/input/InputManager;

    .line 160
    iget-object v1, p0, Lorg/xbmc/kodi/Main;->mInputDeviceListener:Lorg/xbmc/kodi/XBMCInputDeviceListener;

    iget-object v2, p0, Lorg/xbmc/kodi/Main;->handler:Landroid/os/Handler;

    invoke-virtual {p1, v1, v2}, Landroid/hardware/input/InputManager;->registerInputDeviceListener(Landroid/hardware/input/InputManager$InputDeviceListener;Landroid/os/Handler;)V

    .line 162
    invoke-virtual {p0}, Lorg/xbmc/kodi/Main;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lorg/xbmc/kodi/Main;->mDecorView:Landroid/view/View;

    .line 163
    invoke-virtual {p1, v0}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 164
    invoke-virtual {p0}, Lorg/xbmc/kodi/Main;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/view/Window;->takeSurface(Landroid/view/SurfaceHolder$Callback2;)V

    .line 165
    sget p1, Lorg/xbmc/kodi/R$layout;->activity_main:I

    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/Main;->setContentView(I)V

    .line 166
    sget p1, Lorg/xbmc/kodi/R$id;->VideoLayout:I

    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/Main;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/RelativeLayout;

    iput-object p1, p0, Lorg/xbmc/kodi/Main;->mVideoLayout:Landroid/widget/RelativeLayout;

    .line 168
    new-instance p1, Lorg/xbmc/kodi/XBMCMainView;

    invoke-direct {p1, p0}, Lorg/xbmc/kodi/XBMCMainView;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lorg/xbmc/kodi/Main;->mMainView:Lorg/xbmc/kodi/XBMCMainView;

    .line 169
    new-instance p1, Landroid/widget/RelativeLayout$LayoutParams;

    const/4 v0, -0x1

    invoke-direct {p1, v0, v0}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 170
    iget-object v0, p0, Lorg/xbmc/kodi/Main;->mMainView:Lorg/xbmc/kodi/XBMCMainView;

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-virtual {v0, v1}, Lorg/xbmc/kodi/XBMCMainView;->setElevation(F)V

    .line 171
    iget-object v0, p0, Lorg/xbmc/kodi/Main;->mVideoLayout:Landroid/widget/RelativeLayout;

    iget-object v1, p0, Lorg/xbmc/kodi/Main;->mMainView:Lorg/xbmc/kodi/XBMCMainView;

    invoke-virtual {v0, v1, p1}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 173
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v0, 0x1e

    if-ge p1, v0, :cond_3

    .line 175
    iget-object p1, p0, Lorg/xbmc/kodi/Main;->mDecorView:Landroid/view/View;

    new-instance v0, Lorg/xbmc/kodi/Main$2;

    invoke-direct {v0, p0}, Lorg/xbmc/kodi/Main$2;-><init>(Lorg/xbmc/kodi/Main;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnSystemUiVisibilityChangeListener(Landroid/view/View$OnSystemUiVisibilityChangeListener;)V

    :cond_3
    return-void
.end method

.method public onDestroy()V
    .locals 2

    .line 303
    invoke-static {p0}, Lorg/xbmc/kodi/channels/util/TvUtil;->cancelAllScheduledJobs(Landroid/content/Context;)V

    const-string v0, "input"

    .line 306
    invoke-virtual {p0, v0}, Lorg/xbmc/kodi/Main;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/input/InputManager;

    .line 307
    iget-object v1, p0, Lorg/xbmc/kodi/Main;->mInputDeviceListener:Lorg/xbmc/kodi/XBMCInputDeviceListener;

    invoke-virtual {v0, v1}, Landroid/hardware/input/InputManager;->unregisterInputDeviceListener(Landroid/hardware/input/InputManager$InputDeviceListener;)V

    .line 309
    invoke-virtual {p0}, Lorg/xbmc/kodi/Main;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    iget-object v1, p0, Lorg/xbmc/kodi/Main;->mSettingsContentObserver:Lorg/xbmc/kodi/XBMCSettingsContentObserver;

    invoke-virtual {v0, v1}, Landroid/content/ContentResolver;->unregisterContentObserver(Landroid/database/ContentObserver;)V

    .line 310
    invoke-super {p0}, Landroid/app/NativeActivity;->onDestroy()V

    return-void
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 3

    .line 205
    invoke-super {p0, p1}, Landroid/app/NativeActivity;->onNewIntent(Landroid/content/Intent;)V

    .line 207
    iget-boolean v0, p0, Lorg/xbmc/kodi/Main;->mPaused:Z

    const-string v1, "Kodi"

    if-eqz v0, :cond_0

    const-string v0, "Main: onNewIntent (delayed)"

    .line 209
    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 210
    iget-object v0, p0, Lorg/xbmc/kodi/Main;->mDelayedIntents:Ljava/util/ArrayList;

    new-instance v1, Lorg/xbmc/kodi/Main$DelayedIntent;

    new-instance v2, Landroid/content/Intent;

    invoke-direct {v2, p1}, Landroid/content/Intent;-><init>(Landroid/content/Intent;)V

    const/16 p1, 0x1f4

    invoke-direct {v1, p0, v2, p1}, Lorg/xbmc/kodi/Main$DelayedIntent;-><init>(Lorg/xbmc/kodi/Main;Landroid/content/Intent;I)V

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    const-string v0, "Main: onNewIntent (immediate)"

    .line 214
    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 215
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/Main;->_onNewIntent(Landroid/content/Intent;)V

    :goto_0
    return-void
.end method

.method public onPause()V
    .locals 2

    .line 281
    invoke-super {p0}, Landroid/app/NativeActivity;->onPause()V

    .line 283
    invoke-virtual {p0}, Lorg/xbmc/kodi/Main;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "android.software.leanback"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    .line 285
    invoke-direct {p0}, Lorg/xbmc/kodi/Main;->getLauncherName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "com.google.android.tvlauncher"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 286
    invoke-static {p0}, Lorg/xbmc/kodi/channels/util/TvUtil;->scheduleSyncingChannel(Landroid/content/Context;)V

    :cond_0
    const/4 v0, 0x1

    .line 289
    iput-boolean v0, p0, Lorg/xbmc/kodi/Main;->mPaused:Z

    return-void
.end method

.method public onResume()V
    .locals 7

    .line 231
    invoke-super {p0}, Landroid/app/NativeActivity;->onResume()V

    .line 233
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    const/4 v2, 0x0

    if-lt v0, v1, :cond_0

    .line 235
    invoke-virtual {p0}, Lorg/xbmc/kodi/Main;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-static {v0, v2}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m(Landroid/view/Window;Z)V

    .line 236
    invoke-virtual {p0}, Lorg/xbmc/kodi/Main;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-static {v0}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m(Landroid/view/Window;)Landroid/view/WindowInsetsController;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 239
    invoke-static {}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m()I

    move-result v1

    invoke-static {}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m$1()I

    move-result v3

    or-int/2addr v1, v3

    invoke-static {v0, v1}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m(Landroid/view/WindowInsetsController;I)V

    const/4 v1, 0x2

    .line 240
    invoke-static {v0, v1}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m$1(Landroid/view/WindowInsetsController;I)V

    goto :goto_0

    .line 246
    :cond_0
    iget-object v0, p0, Lorg/xbmc/kodi/Main;->mDecorView:Landroid/view/View;

    const/16 v1, 0x1706

    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 256
    :cond_1
    :goto_0
    iget-object v0, p0, Lorg/xbmc/kodi/Main;->mDelayedIntents:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/xbmc/kodi/Main$DelayedIntent;

    .line 258
    iget-object v3, p0, Lorg/xbmc/kodi/Main;->handler:Landroid/os/Handler;

    new-instance v4, Lorg/xbmc/kodi/Main$3;

    invoke-direct {v4, p0, v1}, Lorg/xbmc/kodi/Main$3;-><init>(Lorg/xbmc/kodi/Main;Lorg/xbmc/kodi/Main$DelayedIntent;)V

    iget v1, v1, Lorg/xbmc/kodi/Main$DelayedIntent;->mDelay:I

    int-to-long v5, v1

    invoke-virtual {v3, v4, v5, v6}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_1

    .line 274
    :cond_2
    iget-object v0, p0, Lorg/xbmc/kodi/Main;->mDelayedIntents:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 275
    iput-boolean v2, p0, Lorg/xbmc/kodi/Main;->mPaused:Z

    return-void
.end method

.method public onStart()V
    .locals 1

    .line 222
    invoke-super {p0}, Landroid/app/NativeActivity;->onStart()V

    .line 224
    invoke-static {}, Landroid/view/Choreographer;->getInstance()Landroid/view/Choreographer;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/Choreographer;->removeFrameCallback(Landroid/view/Choreographer$FrameCallback;)V

    .line 225
    invoke-static {}, Landroid/view/Choreographer;->getInstance()Landroid/view/Choreographer;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/Choreographer;->postFrameCallback(Landroid/view/Choreographer$FrameCallback;)V

    return-void
.end method

.method public onVisibleBehindCanceled()V
    .locals 0

    .line 316
    invoke-virtual {p0}, Lorg/xbmc/kodi/Main;->_onVisibleBehindCanceled()V

    .line 317
    invoke-super {p0}, Landroid/app/NativeActivity;->onVisibleBehindCanceled()V

    return-void
.end method

.method public registerMediaButtonEventReceiver()V
    .locals 4

    const-string v0, "audio"

    .line 110
    invoke-virtual {p0, v0}, Lorg/xbmc/kodi/Main;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/AudioManager;

    .line 111
    new-instance v1, Landroid/content/ComponentName;

    invoke-virtual {p0}, Lorg/xbmc/kodi/Main;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const-class v3, Lorg/xbmc/kodi/XBMCBroadcastReceiver;

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/media/AudioManager;->registerMediaButtonEventReceiver(Landroid/content/ComponentName;)V

    return-void
.end method

.method public unregisterMediaButtonEventReceiver()V
    .locals 4

    const-string v0, "audio"

    .line 116
    invoke-virtual {p0, v0}, Lorg/xbmc/kodi/Main;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/AudioManager;

    .line 117
    new-instance v1, Landroid/content/ComponentName;

    invoke-virtual {p0}, Lorg/xbmc/kodi/Main;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const-class v3, Lorg/xbmc/kodi/XBMCBroadcastReceiver;

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/media/AudioManager;->unregisterMediaButtonEventReceiver(Landroid/content/ComponentName;)V

    return-void
.end method
