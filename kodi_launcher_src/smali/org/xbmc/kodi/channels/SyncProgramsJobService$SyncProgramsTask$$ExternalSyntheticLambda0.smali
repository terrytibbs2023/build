.class public final synthetic Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;

.field public final synthetic f$1:Ljava/lang/Boolean;


# direct methods
.method public synthetic constructor <init>(Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;Ljava/lang/Boolean;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask$$ExternalSyntheticLambda0;->f$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;

    iput-object p2, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask$$ExternalSyntheticLambda0;->f$1:Ljava/lang/Boolean;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask$$ExternalSyntheticLambda0;->f$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;

    iget-object v1, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask$$ExternalSyntheticLambda0;->f$1:Ljava/lang/Boolean;

    invoke-virtual {v0, v1}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->lambda$execute$0$org-xbmc-kodi-channels-SyncProgramsJobService$SyncProgramsTask(Ljava/lang/Boolean;)V

    return-void
.end method
