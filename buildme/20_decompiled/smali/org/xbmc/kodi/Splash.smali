.class public Lorg/xbmc/kodi/Splash;
.super Landroid/app/Activity;
.source "Splash.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/xbmc/kodi/Splash$StateMachine;,
        Lorg/xbmc/kodi/Splash$FillCache;
    }
.end annotation


# static fields
.field private static final Caching:I = 0x5

.field private static final CachingDone:I = 0x6

.field private static final CheckExternalStorage:I = 0xc

.field private static final Checking:I = 0x2

.field private static final CheckingPermissions:I = 0x9

.field private static final CheckingPermissionsDone:I = 0xa

.field private static final CheckingPermissionsInfo:I = 0xb

.field private static final ChecksDone:I = 0x3

.field private static final Clearing:I = 0x4

.field private static final InError:I = 0x1

.field private static final PERMISSION_RESULT_CODE:I = 0x22f3

.field private static final RECORDAUDIO_RESULT_CODE:I = 0x22f2

.field private static final RecordAudioPermission:I = 0xd

.field private static final StartingXBMC:I = 0x63

.field private static final StorageChecked:I = 0x8

.field private static final TAG:Ljava/lang/String; = "Kodi"

.field private static final Uninitialized:I = 0x0

.field private static final WaitingStorageChecked:I = 0x7


# instance fields
.field private fPackagePath:Ljava/io/File;

.field private fXbmcHome:Ljava/io/File;

.field private mCachingDone:Z

.field private mErrorMsg:Ljava/lang/String;

.field private mExternalStorageChecked:Z

.field private mExternalStorageReceiver:Landroid/content/BroadcastReceiver;

.field private mPermissionOK:Z

.field private mProgress:Landroid/widget/ProgressBar;

.field private mState:I

.field private mStateMachine:Lorg/xbmc/kodi/Splash$StateMachine;

.field private mTextView:Landroid/widget/TextView;

.field public myAlertDialog:Landroid/app/AlertDialog;

.field private sPackagePath:Ljava/lang/String;

.field private sXbmcHome:Ljava/lang/String;

.field private sXbmcTemp:Ljava/lang/String;

.field private sXbmcdata:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 3

    .line 44
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    const-string v0, ""

    .line 68
    iput-object v0, p0, Lorg/xbmc/kodi/Splash;->mErrorMsg:Ljava/lang/String;

    const/4 v1, 0x0

    .line 70
    iput-object v1, p0, Lorg/xbmc/kodi/Splash;->mProgress:Landroid/widget/ProgressBar;

    .line 71
    iput-object v1, p0, Lorg/xbmc/kodi/Splash;->mTextView:Landroid/widget/TextView;

    const/4 v2, 0x0

    .line 73
    iput v2, p0, Lorg/xbmc/kodi/Splash;->mState:I

    .line 76
    iput-object v0, p0, Lorg/xbmc/kodi/Splash;->sPackagePath:Ljava/lang/String;

    .line 77
    iput-object v0, p0, Lorg/xbmc/kodi/Splash;->sXbmcHome:Ljava/lang/String;

    .line 78
    iput-object v0, p0, Lorg/xbmc/kodi/Splash;->sXbmcdata:Ljava/lang/String;

    .line 79
    iput-object v1, p0, Lorg/xbmc/kodi/Splash;->fPackagePath:Ljava/io/File;

    .line 80
    iput-object v1, p0, Lorg/xbmc/kodi/Splash;->fXbmcHome:Ljava/io/File;

    .line 81
    iput-object v0, p0, Lorg/xbmc/kodi/Splash;->sXbmcTemp:Ljava/lang/String;

    .line 83
    iput-object v1, p0, Lorg/xbmc/kodi/Splash;->mExternalStorageReceiver:Landroid/content/BroadcastReceiver;

    .line 84
    iput-boolean v2, p0, Lorg/xbmc/kodi/Splash;->mExternalStorageChecked:Z

    .line 85
    iput-boolean v2, p0, Lorg/xbmc/kodi/Splash;->mCachingDone:Z

    .line 86
    iput-boolean v2, p0, Lorg/xbmc/kodi/Splash;->mPermissionOK:Z

    .line 233
    new-instance v0, Lorg/xbmc/kodi/Splash$StateMachine;

    invoke-direct {v0, p0, p0}, Lorg/xbmc/kodi/Splash$StateMachine;-><init>(Lorg/xbmc/kodi/Splash;Lorg/xbmc/kodi/Splash;)V

    iput-object v0, p0, Lorg/xbmc/kodi/Splash;->mStateMachine:Lorg/xbmc/kodi/Splash$StateMachine;

    return-void
.end method

.method private CheckPermissions()Z
    .locals 4

    .line 522
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-ge v0, v1, :cond_1

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_0

    invoke-direct {p0}, Lorg/xbmc/kodi/Splash;->isAndroidTV()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 529
    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x16

    if-le v0, v1, :cond_3

    const-string v0, "android.permission.WRITE_EXTERNAL_STORAGE"

    .line 532
    invoke-static {p0, v0}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m(Lorg/xbmc/kodi/Splash;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_2

    goto :goto_1

    .line 524
    :cond_1
    :goto_0
    invoke-static {}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m()Z

    move-result v0

    if-eqz v0, :cond_2

    goto :goto_1

    :cond_2
    const/4 v2, 0x0

    :cond_3
    :goto_1
    return v2
.end method

.method private SetupEnvironment()V
    .locals 8

    const-string v0, "xbmc.home"

    const-string v1, ""

    .line 430
    invoke-static {v0, v1}, Lorg/xbmc/kodi/XBMCProperties;->getStringProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lorg/xbmc/kodi/Splash;->sXbmcHome:Ljava/lang/String;

    .line 431
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    const-wide/16 v3, 0x3e8

    const/16 v5, 0x14

    if-nez v2, :cond_1

    .line 433
    new-instance v2, Ljava/io/File;

    iget-object v6, p0, Lorg/xbmc/kodi/Splash;->sXbmcHome:Ljava/lang/String;

    invoke-direct {v2, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v2, p0, Lorg/xbmc/kodi/Splash;->fXbmcHome:Ljava/io/File;

    const/16 v2, 0x14

    .line 435
    :goto_0
    iget-object v6, p0, Lorg/xbmc/kodi/Splash;->fXbmcHome:Ljava/io/File;

    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v6

    if-nez v6, :cond_0

    if-lez v2, :cond_0

    .line 440
    :try_start_0
    invoke-static {v3, v4}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v2, v2, -0x1

    goto :goto_0

    :catch_0
    nop

    goto :goto_0

    .line 448
    :cond_0
    iget-object v2, p0, Lorg/xbmc/kodi/Splash;->fXbmcHome:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_1

    .line 450
    invoke-static {v0, v1}, Ljava/lang/System;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 451
    iput-object v1, p0, Lorg/xbmc/kodi/Splash;->sXbmcHome:Ljava/lang/String;

    .line 454
    :cond_1
    invoke-virtual {p0}, Lorg/xbmc/kodi/Splash;->getCacheDir()Ljava/io/File;

    move-result-object v0

    .line 455
    iget-object v2, p0, Lorg/xbmc/kodi/Splash;->sXbmcHome:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 457
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, "/apk"

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lorg/xbmc/kodi/Splash;->sXbmcHome:Ljava/lang/String;

    .line 458
    new-instance v2, Ljava/io/File;

    iget-object v6, p0, Lorg/xbmc/kodi/Splash;->sXbmcHome:Ljava/lang/String;

    invoke-direct {v2, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v2, p0, Lorg/xbmc/kodi/Splash;->fXbmcHome:Ljava/io/File;

    .line 460
    :cond_2
    new-instance v2, Ljava/io/File;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "/lib"

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 461
    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    const-string v0, "xbmc.data"

    .line 463
    invoke-static {v0, v1}, Lorg/xbmc/kodi/XBMCProperties;->getStringProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lorg/xbmc/kodi/Splash;->sXbmcdata:Ljava/lang/String;

    .line 464
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_4

    .line 466
    new-instance v2, Ljava/io/File;

    iget-object v6, p0, Lorg/xbmc/kodi/Splash;->sXbmcdata:Ljava/lang/String;

    invoke-direct {v2, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    const/16 v6, 0x14

    .line 468
    :goto_1
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v7

    if-nez v7, :cond_3

    if-lez v6, :cond_3

    .line 473
    :try_start_1
    invoke-static {v3, v4}, Ljava/lang/Thread;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_1

    add-int/lit8 v6, v6, -0x1

    goto :goto_1

    :catch_1
    nop

    goto :goto_1

    .line 482
    :cond_3
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_4

    .line 484
    iput-object v1, p0, Lorg/xbmc/kodi/Splash;->sXbmcdata:Ljava/lang/String;

    .line 485
    invoke-static {v0, v1}, Ljava/lang/System;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    :cond_4
    const-string v0, "xbmc.temp"

    .line 489
    invoke-static {v0, v1}, Lorg/xbmc/kodi/XBMCProperties;->getStringProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lorg/xbmc/kodi/Splash;->sXbmcTemp:Ljava/lang/String;

    .line 490
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_6

    .line 492
    new-instance v2, Ljava/io/File;

    iget-object v6, p0, Lorg/xbmc/kodi/Splash;->sXbmcTemp:Ljava/lang/String;

    invoke-direct {v2, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 494
    :goto_2
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v6

    if-nez v6, :cond_5

    if-lez v5, :cond_5

    .line 499
    :try_start_2
    invoke-static {v3, v4}, Ljava/lang/Thread;->sleep(J)V
    :try_end_2
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_2

    add-int/lit8 v5, v5, -0x1

    goto :goto_2

    :catch_2
    nop

    goto :goto_2

    .line 508
    :cond_5
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_6

    .line 510
    iput-object v1, p0, Lorg/xbmc/kodi/Splash;->sXbmcTemp:Ljava/lang/String;

    .line 511
    invoke-static {v0, v1}, Ljava/lang/System;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 515
    :cond_6
    invoke-virtual {p0}, Lorg/xbmc/kodi/Splash;->getPackageResourcePath()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/xbmc/kodi/Splash;->sPackagePath:Ljava/lang/String;

    .line 516
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lorg/xbmc/kodi/Splash;->sPackagePath:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lorg/xbmc/kodi/Splash;->fPackagePath:Ljava/io/File;

    return-void
.end method

.method static synthetic access$000(Lorg/xbmc/kodi/Splash;)I
    .locals 0

    .line 44
    iget p0, p0, Lorg/xbmc/kodi/Splash;->mState:I

    return p0
.end method

.method static synthetic access$002(Lorg/xbmc/kodi/Splash;I)I
    .locals 0

    .line 44
    iput p1, p0, Lorg/xbmc/kodi/Splash;->mState:I

    return p1
.end method

.method static synthetic access$100(Lorg/xbmc/kodi/Splash;)Ljava/lang/String;
    .locals 0

    .line 44
    iget-object p0, p0, Lorg/xbmc/kodi/Splash;->mErrorMsg:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$1000(Lorg/xbmc/kodi/Splash;)Ljava/io/File;
    .locals 0

    .line 44
    iget-object p0, p0, Lorg/xbmc/kodi/Splash;->fXbmcHome:Ljava/io/File;

    return-object p0
.end method

.method static synthetic access$102(Lorg/xbmc/kodi/Splash;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 44
    iput-object p1, p0, Lorg/xbmc/kodi/Splash;->mErrorMsg:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1100(Lorg/xbmc/kodi/Splash;)Ljava/io/File;
    .locals 0

    .line 44
    iget-object p0, p0, Lorg/xbmc/kodi/Splash;->fPackagePath:Ljava/io/File;

    return-object p0
.end method

.method static synthetic access$1200(Lorg/xbmc/kodi/Splash;)Ljava/lang/String;
    .locals 0

    .line 44
    iget-object p0, p0, Lorg/xbmc/kodi/Splash;->sPackagePath:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$1300(Lorg/xbmc/kodi/Splash;)Ljava/lang/String;
    .locals 0

    .line 44
    iget-object p0, p0, Lorg/xbmc/kodi/Splash;->sXbmcHome:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$200(Lorg/xbmc/kodi/Splash;)Lorg/xbmc/kodi/Splash$StateMachine;
    .locals 0

    .line 44
    iget-object p0, p0, Lorg/xbmc/kodi/Splash;->mStateMachine:Lorg/xbmc/kodi/Splash$StateMachine;

    return-object p0
.end method

.method static synthetic access$300(Lorg/xbmc/kodi/Splash;)Landroid/widget/TextView;
    .locals 0

    .line 44
    iget-object p0, p0, Lorg/xbmc/kodi/Splash;->mTextView:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic access$400(Lorg/xbmc/kodi/Splash;)Landroid/widget/ProgressBar;
    .locals 0

    .line 44
    iget-object p0, p0, Lorg/xbmc/kodi/Splash;->mProgress:Landroid/widget/ProgressBar;

    return-object p0
.end method

.method static synthetic access$500(Lorg/xbmc/kodi/Splash;)Z
    .locals 0

    .line 44
    invoke-direct {p0}, Lorg/xbmc/kodi/Splash;->isAndroidTV()Z

    move-result p0

    return p0
.end method

.method static synthetic access$600(Lorg/xbmc/kodi/Splash;)Z
    .locals 0

    .line 44
    iget-boolean p0, p0, Lorg/xbmc/kodi/Splash;->mPermissionOK:Z

    return p0
.end method

.method static synthetic access$700(Lorg/xbmc/kodi/Splash;)Z
    .locals 0

    .line 44
    iget-boolean p0, p0, Lorg/xbmc/kodi/Splash;->mCachingDone:Z

    return p0
.end method

.method static synthetic access$702(Lorg/xbmc/kodi/Splash;Z)Z
    .locals 0

    .line 44
    iput-boolean p1, p0, Lorg/xbmc/kodi/Splash;->mCachingDone:Z

    return p1
.end method

.method static synthetic access$802(Lorg/xbmc/kodi/Splash;Z)Z
    .locals 0

    .line 44
    iput-boolean p1, p0, Lorg/xbmc/kodi/Splash;->mExternalStorageChecked:Z

    return p1
.end method

.method static synthetic access$900(Lorg/xbmc/kodi/Splash;)V
    .locals 0

    .line 44
    invoke-direct {p0}, Lorg/xbmc/kodi/Splash;->SetupEnvironment()V

    return-void
.end method

.method private isAndroidTV()Z
    .locals 2

    .line 711
    invoke-virtual {p0}, Lorg/xbmc/kodi/Splash;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "android.software.leanback"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v0

    const-string v1, "Kodi"

    if-eqz v0, :cond_0

    const-string v0, "Running on an Android TV Device"

    .line 713
    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    return v0

    :cond_0
    const-string v0, "Running on a non Android TV Device"

    .line 718
    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    return v0
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 0

    .line 568
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    const/16 p2, 0x22f3

    if-ne p1, p2, :cond_1

    .line 571
    invoke-static {}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m()Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    .line 573
    iput-boolean p1, p0, Lorg/xbmc/kodi/Splash;->mPermissionOK:Z

    .line 575
    :cond_0
    iget-object p1, p0, Lorg/xbmc/kodi/Splash;->mStateMachine:Lorg/xbmc/kodi/Splash$StateMachine;

    const/16 p2, 0xa

    invoke-virtual {p1, p2}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    :cond_1
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 7

    .line 633
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 636
    invoke-static {}, Lorg/xbmc/kodi/XBMCProperties;->initializeProperties()V

    .line 639
    invoke-virtual {p0}, Lorg/xbmc/kodi/Splash;->getBaseContext()Landroid/content/Context;

    move-result-object p1

    const-string v0, "activity"

    .line 640
    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/app/ActivityManager;

    const v0, 0x7fffffff

    .line 642
    invoke-virtual {p1, v0}, Landroid/app/ActivityManager;->getRunningTasks(I)Ljava/util/List;

    move-result-object p1

    .line 643
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager$RunningTaskInfo;

    .line 644
    invoke-static {v0}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m(Landroid/app/ActivityManager$RunningTaskInfo;)Landroid/content/ComponentName;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/ComponentName;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "ComponentInfo{org.xbmc.kodi/org.xbmc.kodi.Main}"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 648
    invoke-virtual {p0}, Lorg/xbmc/kodi/Splash;->startXBMC()V

    return-void

    .line 652
    :cond_1
    iget-object p1, p0, Lorg/xbmc/kodi/Splash;->mStateMachine:Lorg/xbmc/kodi/Splash$StateMachine;

    const/4 v0, 0x2

    invoke-virtual {p1, v0}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    .line 654
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "External storage = "

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "; state = "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "Kodi"

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string p1, "mounted"

    .line 655
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    const/4 v0, 0x1

    if-eqz p1, :cond_2

    .line 656
    iput-boolean v0, p0, Lorg/xbmc/kodi/Splash;->mExternalStorageChecked:Z

    .line 658
    :cond_2
    invoke-direct {p0}, Lorg/xbmc/kodi/Splash;->CheckPermissions()Z

    move-result p1

    iput-boolean p1, p0, Lorg/xbmc/kodi/Splash;->mPermissionOK:Z

    const/4 v1, 0x6

    const/16 v2, 0xb

    if-nez p1, :cond_3

    .line 661
    iput v2, p0, Lorg/xbmc/kodi/Splash;->mState:I

    goto :goto_0

    .line 665
    :cond_3
    iget p1, p0, Lorg/xbmc/kodi/Splash;->mState:I

    if-eq p1, v0, :cond_4

    iget-boolean p1, p0, Lorg/xbmc/kodi/Splash;->mExternalStorageChecked:Z

    if-eqz p1, :cond_4

    const/4 p1, 0x3

    .line 667
    iput p1, p0, Lorg/xbmc/kodi/Splash;->mState:I

    .line 669
    invoke-direct {p0}, Lorg/xbmc/kodi/Splash;->SetupEnvironment()V

    .line 671
    iget p1, p0, Lorg/xbmc/kodi/Splash;->mState:I

    if-eq p1, v0, :cond_4

    iget-object p1, p0, Lorg/xbmc/kodi/Splash;->fXbmcHome:Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lorg/xbmc/kodi/Splash;->fXbmcHome:Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->lastModified()J

    move-result-wide v3

    iget-object p1, p0, Lorg/xbmc/kodi/Splash;->fPackagePath:Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->lastModified()J

    move-result-wide v5

    cmp-long p1, v3, v5

    if-ltz p1, :cond_4

    .line 673
    iput v1, p0, Lorg/xbmc/kodi/Splash;->mState:I

    .line 674
    iput-boolean v0, p0, Lorg/xbmc/kodi/Splash;->mCachingDone:Z

    .line 679
    :cond_4
    :goto_0
    iget p1, p0, Lorg/xbmc/kodi/Splash;->mState:I

    if-eq p1, v0, :cond_5

    iget-boolean p1, p0, Lorg/xbmc/kodi/Splash;->mCachingDone:Z

    if-eqz p1, :cond_5

    iget-boolean p1, p0, Lorg/xbmc/kodi/Splash;->mExternalStorageChecked:Z

    if-eqz p1, :cond_5

    iget-boolean p1, p0, Lorg/xbmc/kodi/Splash;->mPermissionOK:Z

    if-eqz p1, :cond_5

    .line 681
    invoke-virtual {p0}, Lorg/xbmc/kodi/Splash;->startXBMC()V

    return-void

    .line 685
    :cond_5
    sget p1, Lorg/xbmc/kodi/R$layout;->activity_splash:I

    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/Splash;->setContentView(I)V

    .line 686
    sget p1, Lorg/xbmc/kodi/R$id;->progressBar1:I

    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/Splash;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ProgressBar;

    iput-object p1, p0, Lorg/xbmc/kodi/Splash;->mProgress:Landroid/widget/ProgressBar;

    .line 687
    sget p1, Lorg/xbmc/kodi/R$id;->textView1:I

    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/Splash;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lorg/xbmc/kodi/Splash;->mTextView:Landroid/widget/TextView;

    .line 689
    iget p1, p0, Lorg/xbmc/kodi/Splash;->mState:I

    if-eq p1, v0, :cond_9

    if-ne p1, v2, :cond_6

    goto :goto_2

    .line 695
    :cond_6
    iget-boolean p1, p0, Lorg/xbmc/kodi/Splash;->mExternalStorageChecked:Z

    if-nez p1, :cond_7

    .line 697
    invoke-virtual {p0}, Lorg/xbmc/kodi/Splash;->startWatchingExternalStorage()V

    .line 698
    iget-object p1, p0, Lorg/xbmc/kodi/Splash;->mStateMachine:Lorg/xbmc/kodi/Splash$StateMachine;

    const/4 v0, 0x7

    invoke-virtual {p1, v0}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    goto :goto_1

    .line 702
    :cond_7
    iget-boolean p1, p0, Lorg/xbmc/kodi/Splash;->mCachingDone:Z

    if-nez p1, :cond_8

    .line 703
    new-instance p1, Lorg/xbmc/kodi/Splash$FillCache;

    invoke-direct {p1, p0, p0}, Lorg/xbmc/kodi/Splash$FillCache;-><init>(Lorg/xbmc/kodi/Splash;Lorg/xbmc/kodi/Splash;)V

    invoke-virtual {p1}, Lorg/xbmc/kodi/Splash$FillCache;->execute()V

    goto :goto_1

    .line 705
    :cond_8
    iget-object p1, p0, Lorg/xbmc/kodi/Splash;->mStateMachine:Lorg/xbmc/kodi/Splash$StateMachine;

    invoke-virtual {p1, v1}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    :goto_1
    return-void

    .line 691
    :cond_9
    :goto_2
    iget-object v0, p0, Lorg/xbmc/kodi/Splash;->mStateMachine:Lorg/xbmc/kodi/Splash$StateMachine;

    invoke-virtual {v0, p1}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 0

    const/16 p2, 0x22f2

    if-eq p1, p2, :cond_2

    const/16 p2, 0x22f3

    if-eq p1, p2, :cond_0

    goto :goto_0

    .line 550
    :cond_0
    array-length p1, p3

    if-lez p1, :cond_1

    const/4 p1, 0x0

    aget p1, p3, p1

    if-nez p1, :cond_1

    const/4 p1, 0x1

    .line 553
    iput-boolean p1, p0, Lorg/xbmc/kodi/Splash;->mPermissionOK:Z

    .line 555
    :cond_1
    iget-object p1, p0, Lorg/xbmc/kodi/Splash;->mStateMachine:Lorg/xbmc/kodi/Splash$StateMachine;

    const/16 p2, 0xa

    invoke-virtual {p1, p2}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    goto :goto_0

    .line 560
    :cond_2
    iget-object p1, p0, Lorg/xbmc/kodi/Splash;->mStateMachine:Lorg/xbmc/kodi/Splash$StateMachine;

    const/16 p2, 0x9

    invoke-virtual {p1, p2}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    :goto_0
    return-void
.end method

.method public showErrorDialog(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    .line 399
    iget-object v0, p0, Lorg/xbmc/kodi/Splash;->myAlertDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/app/AlertDialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 402
    :cond_0
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 403
    invoke-virtual {v0, p2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    const p2, 0x1080027

    .line 404
    invoke-virtual {v0, p2}, Landroid/app/AlertDialog$Builder;->setIcon(I)Landroid/app/AlertDialog$Builder;

    .line 405
    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    const/4 v2, 0x0

    if-lt p2, v1, :cond_1

    .line 406
    invoke-static {p3, v2}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m(Ljava/lang/String;I)Landroid/text/Spanned;

    move-result-object p2

    invoke-virtual {v0, p2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    goto :goto_0

    .line 408
    :cond_1
    invoke-static {p3}, Landroid/text/Html;->fromHtml(Ljava/lang/String;)Landroid/text/Spanned;

    move-result-object p2

    invoke-virtual {v0, p2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 410
    :goto_0
    new-instance p2, Lorg/xbmc/kodi/Splash$1;

    invoke-direct {p2, p0, p1}, Lorg/xbmc/kodi/Splash$1;-><init>(Lorg/xbmc/kodi/Splash;Landroid/app/Activity;)V

    const-string p1, "Exit"

    invoke-virtual {v0, p1, p2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 419
    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    .line 420
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object p1

    iput-object p1, p0, Lorg/xbmc/kodi/Splash;->myAlertDialog:Landroid/app/AlertDialog;

    .line 421
    invoke-virtual {p1}, Landroid/app/AlertDialog;->show()V

    .line 424
    iget-object p1, p0, Lorg/xbmc/kodi/Splash;->myAlertDialog:Landroid/app/AlertDialog;

    const p2, 0x102000b

    invoke-virtual {p1, p2}, Landroid/app/AlertDialog;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    .line 425
    invoke-static {}, Landroid/text/method/LinkMovementMethod;->getInstance()Landroid/text/method/MovementMethod;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setMovementMethod(Landroid/text/method/MovementMethod;)V

    return-void
.end method

.method startWatchingExternalStorage()V
    .locals 2

    .line 595
    new-instance v0, Lorg/xbmc/kodi/Splash$2;

    invoke-direct {v0, p0}, Lorg/xbmc/kodi/Splash$2;-><init>(Lorg/xbmc/kodi/Splash;)V

    iput-object v0, p0, Lorg/xbmc/kodi/Splash;->mExternalStorageReceiver:Landroid/content/BroadcastReceiver;

    .line 604
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    const-string v1, "android.intent.action.MEDIA_MOUNTED"

    .line 605
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.MEDIA_REMOVED"

    .line 606
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.MEDIA_SHARED"

    .line 607
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.MEDIA_UNMOUNTABLE"

    .line 608
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "android.intent.action.MEDIA_UNMOUNTED"

    .line 609
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "file"

    .line 610
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addDataScheme(Ljava/lang/String;)V

    .line 611
    iget-object v1, p0, Lorg/xbmc/kodi/Splash;->mExternalStorageReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v1, v0}, Lorg/xbmc/kodi/Splash;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    return-void
.end method

.method protected startXBMC()V
    .locals 2

    .line 623
    invoke-virtual {p0}, Lorg/xbmc/kodi/Splash;->getIntent()Landroid/content/Intent;

    move-result-object v0

    .line 624
    const-class v1, Lorg/xbmc/kodi/Main;

    invoke-virtual {v0, p0, v1}, Landroid/content/Intent;->setClass(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    const/high16 v1, 0x1000000

    .line 625
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 626
    invoke-virtual {p0, v0}, Lorg/xbmc/kodi/Splash;->startActivity(Landroid/content/Intent;)V

    .line 627
    invoke-virtual {p0}, Lorg/xbmc/kodi/Splash;->finish()V

    return-void
.end method

.method stopWatchingExternalStorage()V
    .locals 1

    .line 616
    iget-object v0, p0, Lorg/xbmc/kodi/Splash;->mExternalStorageReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_0

    .line 617
    invoke-virtual {p0, v0}, Lorg/xbmc/kodi/Splash;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    :cond_0
    return-void
.end method

.method updateExternalStorageState()V
    .locals 3

    .line 581
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v0

    .line 582
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "External storage = "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "; state = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "Kodi"

    invoke-static {v2, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v1, "mounted"

    .line 583
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 585
    iget-object v0, p0, Lorg/xbmc/kodi/Splash;->mStateMachine:Lorg/xbmc/kodi/Splash$StateMachine;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 589
    iput-boolean v0, p0, Lorg/xbmc/kodi/Splash;->mExternalStorageChecked:Z

    :goto_0
    return-void
.end method
