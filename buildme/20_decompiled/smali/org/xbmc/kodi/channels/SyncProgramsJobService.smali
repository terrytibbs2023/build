.class public Lorg/xbmc/kodi/channels/SyncProgramsJobService;
.super Landroid/app/job/JobService;
.source "SyncProgramsJobService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "Kodi"


# instance fields
.field private mSyncProgramsTask:Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 55
    invoke-direct {p0}, Landroid/app/job/JobService;-><init>()V

    return-void
.end method

.method static synthetic access$102(Lorg/xbmc/kodi/channels/SyncProgramsJobService;Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;)Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;
    .locals 0

    .line 55
    iput-object p1, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService;->mSyncProgramsTask:Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;

    return-object p1
.end method

.method private getChannelId(Landroid/app/job/JobParameters;)J
    .locals 3

    .line 104
    invoke-virtual {p1}, Landroid/app/job/JobParameters;->getExtras()Landroid/os/PersistableBundle;

    move-result-object p1

    const-wide/16 v0, -0x1

    if-nez p1, :cond_0

    return-wide v0

    :cond_0
    const-string v2, "android.media.tv.extra.CHANNEL_ID"

    .line 110
    invoke-virtual {p1, v2, v0, v1}, Landroid/os/PersistableBundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    return-wide v0
.end method


# virtual methods
.method public onStartJob(Landroid/app/job/JobParameters;)Z
    .locals 10

    .line 65
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "SyncProgramsJobService.onStartJob(): "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Kodi"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 67
    invoke-direct {p0, p1}, Lorg/xbmc/kodi/channels/SyncProgramsJobService;->getChannelId(Landroid/app/job/JobParameters;)J

    move-result-wide v8

    const-wide/16 v2, -0x1

    const/4 v0, 0x0

    cmp-long v4, v8, v2

    if-nez v4, :cond_0

    return v0

    .line 72
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "SyncProgramsJobService.onStartJob(): Scheduling syncing for programs for channel "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 74
    new-instance v1, Lorg/xbmc/kodi/channels/SyncProgramsJobService$1;

    .line 75
    invoke-virtual {p0}, Lorg/xbmc/kodi/channels/SyncProgramsJobService;->getApplicationContext()Landroid/content/Context;

    move-result-object v4

    move-object v2, v1

    move-object v3, p0

    move-wide v5, v8

    move-object v7, p1

    invoke-direct/range {v2 .. v7}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$1;-><init>(Lorg/xbmc/kodi/channels/SyncProgramsJobService;Landroid/content/Context;JLandroid/app/job/JobParameters;)V

    iput-object v1, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService;->mSyncProgramsTask:Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;

    const/4 p1, 0x1

    new-array v2, p1, [Ljava/lang/Long;

    .line 87
    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    aput-object v3, v2, v0

    invoke-virtual {v1, v2}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->execute([Ljava/lang/Long;)V

    return p1
.end method

.method public onStopJob(Landroid/app/job/JobParameters;)Z
    .locals 0

    .line 95
    iget-object p1, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService;->mSyncProgramsTask:Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;

    if-eqz p1, :cond_0

    .line 97
    invoke-virtual {p1}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->cancel()V

    :cond_0
    const/4 p1, 0x1

    return p1
.end method
