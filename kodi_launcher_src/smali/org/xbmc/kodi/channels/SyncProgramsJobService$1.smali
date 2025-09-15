.class Lorg/xbmc/kodi/channels/SyncProgramsJobService$1;
.super Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;
.source "SyncProgramsJobService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/xbmc/kodi/channels/SyncProgramsJobService;->onStartJob(Landroid/app/job/JobParameters;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService;

.field final synthetic val$channelId:J

.field final synthetic val$jobParameters:Landroid/app/job/JobParameters;


# direct methods
.method constructor <init>(Lorg/xbmc/kodi/channels/SyncProgramsJobService;Landroid/content/Context;JLandroid/app/job/JobParameters;)V
    .locals 0

    .line 76
    iput-object p1, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$1;->this$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService;

    iput-wide p3, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$1;->val$channelId:J

    iput-object p5, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$1;->val$jobParameters:Landroid/app/job/JobParameters;

    const/4 p3, 0x0

    invoke-direct {p0, p1, p2, p3}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;-><init>(Lorg/xbmc/kodi/channels/SyncProgramsJobService;Landroid/content/Context;Lorg/xbmc/kodi/channels/SyncProgramsJobService$1;)V

    return-void
.end method


# virtual methods
.method protected onPostExecute(Ljava/lang/Boolean;)V
    .locals 3

    .line 81
    iget-object v0, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$1;->this$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService;

    iget-wide v1, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$1;->val$channelId:J

    invoke-static {v0, v1, v2}, Lorg/xbmc/kodi/channels/util/TvUtil;->scheduleTriggeredSyncingProgramsForChannel(Landroid/content/Context;J)V

    .line 83
    iget-object v0, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$1;->this$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lorg/xbmc/kodi/channels/SyncProgramsJobService;->access$102(Lorg/xbmc/kodi/channels/SyncProgramsJobService;Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;)Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;

    .line 84
    iget-object v0, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$1;->this$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService;

    iget-object v1, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$1;->val$jobParameters:Landroid/app/job/JobParameters;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    xor-int/lit8 p1, p1, 0x1

    invoke-virtual {v0, v1, p1}, Lorg/xbmc/kodi/channels/SyncProgramsJobService;->jobFinished(Landroid/app/job/JobParameters;Z)V

    return-void
.end method
