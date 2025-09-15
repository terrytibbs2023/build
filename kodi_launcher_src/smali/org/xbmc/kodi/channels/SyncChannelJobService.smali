.class public Lorg/xbmc/kodi/channels/SyncChannelJobService;
.super Landroid/app/job/JobService;
.source "SyncChannelJobService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "Kodi"


# instance fields
.field private mSyncChannelTask:Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 46
    invoke-direct {p0}, Landroid/app/job/JobService;-><init>()V

    return-void
.end method


# virtual methods
.method public onStartJob(Landroid/app/job/JobParameters;)Z
    .locals 2

    const-string v0, "Kodi"

    const-string v1, "SyncChannelJobService: Starting channel creation job"

    .line 56
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 58
    new-instance v0, Lorg/xbmc/kodi/channels/SyncChannelJobService$1;

    .line 59
    invoke-virtual {p0}, Lorg/xbmc/kodi/channels/SyncChannelJobService;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, p0, v1, p1}, Lorg/xbmc/kodi/channels/SyncChannelJobService$1;-><init>(Lorg/xbmc/kodi/channels/SyncChannelJobService;Landroid/content/Context;Landroid/app/job/JobParameters;)V

    iput-object v0, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService;->mSyncChannelTask:Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;

    .line 67
    invoke-virtual {v0}, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->execute()V

    const/4 p1, 0x1

    return p1
.end method

.method public onStopJob(Landroid/app/job/JobParameters;)Z
    .locals 0

    .line 74
    iget-object p1, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService;->mSyncChannelTask:Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;

    if-eqz p1, :cond_0

    .line 76
    invoke-virtual {p1}, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->cancel()V

    :cond_0
    const/4 p1, 0x1

    return p1
.end method
