.class public final synthetic Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;

.field public final synthetic f$1:[Ljava/lang/Long;


# direct methods
.method public synthetic constructor <init>(Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;[Ljava/lang/Long;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask$$ExternalSyntheticLambda1;->f$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;

    iput-object p2, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask$$ExternalSyntheticLambda1;->f$1:[Ljava/lang/Long;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask$$ExternalSyntheticLambda1;->f$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;

    iget-object v1, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask$$ExternalSyntheticLambda1;->f$1:[Ljava/lang/Long;

    invoke-virtual {v0, v1}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->lambda$execute$1$org-xbmc-kodi-channels-SyncProgramsJobService$SyncProgramsTask([Ljava/lang/Long;)V

    return-void
.end method
