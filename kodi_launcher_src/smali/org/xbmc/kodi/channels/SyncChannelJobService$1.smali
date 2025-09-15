.class Lorg/xbmc/kodi/channels/SyncChannelJobService$1;
.super Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;
.source "SyncChannelJobService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/xbmc/kodi/channels/SyncChannelJobService;->onStartJob(Landroid/app/job/JobParameters;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/xbmc/kodi/channels/SyncChannelJobService;

.field final synthetic val$jobParameters:Landroid/app/job/JobParameters;


# direct methods
.method constructor <init>(Lorg/xbmc/kodi/channels/SyncChannelJobService;Landroid/content/Context;Landroid/app/job/JobParameters;)V
    .locals 0

    .line 60
    iput-object p1, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$1;->this$0:Lorg/xbmc/kodi/channels/SyncChannelJobService;

    iput-object p3, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$1;->val$jobParameters:Landroid/app/job/JobParameters;

    invoke-direct {p0, p2}, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method protected onPostExecute(Ljava/lang/Boolean;)V
    .locals 2

    .line 64
    iget-object v0, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$1;->this$0:Lorg/xbmc/kodi/channels/SyncChannelJobService;

    iget-object v1, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$1;->val$jobParameters:Landroid/app/job/JobParameters;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    xor-int/lit8 p1, p1, 0x1

    invoke-virtual {v0, v1, p1}, Lorg/xbmc/kodi/channels/SyncChannelJobService;->jobFinished(Landroid/app/job/JobParameters;Z)V

    return-void
.end method
