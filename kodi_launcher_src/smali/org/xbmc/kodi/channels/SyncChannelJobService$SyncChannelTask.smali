.class Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;
.super Ljava/lang/Object;
.source "SyncChannelJobService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/xbmc/kodi/channels/SyncChannelJobService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "SyncChannelTask"
.end annotation


# instance fields
.field private executor:Ljava/util/concurrent/ExecutorService;

.field private handler:Landroid/os/Handler;

.field private final mContext:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 1

    .line 88
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 89
    iput-object p1, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->mContext:Landroid/content/Context;

    .line 90
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object p1

    iput-object p1, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->executor:Ljava/util/concurrent/ExecutorService;

    .line 91
    new-instance p1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {p1, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object p1, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->handler:Landroid/os/Handler;

    return-void
.end method


# virtual methods
.method protected cancel()V
    .locals 1

    .line 106
    iget-object v0, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->executor:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    return-void
.end method

.method protected doInBackground()Ljava/lang/Boolean;
    .locals 9

    .line 133
    new-instance v0, Lorg/xbmc/kodi/XBMCJsonRPC;

    invoke-direct {v0}, Lorg/xbmc/kodi/XBMCJsonRPC;-><init>()V

    .line 134
    invoke-virtual {v0}, Lorg/xbmc/kodi/XBMCJsonRPC;->Ping()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 135
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0

    .line 138
    :cond_0
    iget-object v0, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->getSubscriptions(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    .line 139
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 140
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 141
    new-instance v3, Lorg/xbmc/kodi/XBMCURIUtils;

    invoke-direct {v3}, Lorg/xbmc/kodi/XBMCURIUtils;-><init>()V

    const-string v4, "special://profile/playlists/video/"

    .line 143
    invoke-virtual {v3, v4}, Lorg/xbmc/kodi/XBMCURIUtils;->substitutePath(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->getFilesFromUrl(Ljava/lang/String;)Ljava/util/List;

    move-result-object v4

    invoke-interface {v2, v4}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    const-string v4, "special://profile/playlists/mixed/"

    .line 144
    invoke-virtual {v3, v4}, Lorg/xbmc/kodi/XBMCURIUtils;->substitutePath(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->getFilesFromUrl(Ljava/lang/String;)Ljava/util/List;

    move-result-object v4

    invoke-interface {v2, v4}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    const-string v4, "special://profile/playlists/music/"

    .line 145
    invoke-virtual {v3, v4}, Lorg/xbmc/kodi/XBMCURIUtils;->substitutePath(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->getFilesFromUrl(Ljava/lang/String;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 147
    iget-object v3, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->mContext:Landroid/content/Context;

    sget v4, Lorg/xbmc/kodi/R$string;->suggestion_channel:I

    invoke-virtual {v3, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    const-string v4, ""

    sget v5, Lorg/xbmc/kodi/R$drawable;->ic_recommendation_80dp:I

    invoke-static {v3, v4, v5}, Lorg/xbmc/kodi/channels/model/Subscription;->createSubscription(Ljava/lang/String;Ljava/lang/String;I)Lorg/xbmc/kodi/channels/model/Subscription;

    move-result-object v3

    .line 148
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v4

    if-nez v4, :cond_1

    .line 150
    iget-object v4, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->mContext:Landroid/content/Context;

    invoke-static {v4, v3}, Lorg/xbmc/kodi/channels/util/TvUtil;->createChannel(Landroid/content/Context;Lorg/xbmc/kodi/channels/model/Subscription;)J

    move-result-wide v4

    .line 151
    invoke-virtual {v3, v4, v5}, Lorg/xbmc/kodi/channels/model/Subscription;->setChannelId(J)V

    .line 152
    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 154
    iget-object v6, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->mContext:Landroid/content/Context;

    invoke-static {v6, v4, v5}, Landroidx/tvprovider/media/tv/TvContractCompat;->requestChannelBrowsable(Landroid/content/Context;J)V

    goto :goto_0

    .line 158
    :cond_1
    invoke-interface {v0, v3}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v4

    if-ltz v4, :cond_2

    .line 161
    invoke-interface {v0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/xbmc/kodi/channels/model/Subscription;

    .line 162
    invoke-virtual {v3}, Lorg/xbmc/kodi/channels/model/Subscription;->getChannelId()J

    move-result-wide v4

    const-wide/16 v6, 0x0

    cmp-long v8, v4, v6

    if-nez v8, :cond_2

    .line 164
    iget-object v4, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->mContext:Landroid/content/Context;

    invoke-static {v4, v3}, Lorg/xbmc/kodi/channels/util/TvUtil;->createChannel(Landroid/content/Context;Lorg/xbmc/kodi/channels/model/Subscription;)J

    move-result-wide v4

    .line 165
    invoke-virtual {v3, v4, v5}, Lorg/xbmc/kodi/channels/model/Subscription;->setChannelId(J)V

    .line 169
    :cond_2
    :goto_0
    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 171
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    const/4 v4, -0x1

    if-eqz v3, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/xbmc/kodi/model/File;

    .line 173
    invoke-virtual {v3}, Lorg/xbmc/kodi/model/File;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3}, Lorg/xbmc/kodi/model/File;->getUri()Ljava/lang/String;

    move-result-object v3

    sget v6, Lorg/xbmc/kodi/R$drawable;->ic_recommendation_80dp:I

    invoke-static {v5, v3, v6}, Lorg/xbmc/kodi/channels/model/Subscription;->createSubscription(Ljava/lang/String;Ljava/lang/String;I)Lorg/xbmc/kodi/channels/model/Subscription;

    move-result-object v3

    .line 175
    invoke-interface {v0, v3}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v5

    if-ne v5, v4, :cond_3

    .line 178
    iget-object v4, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->mContext:Landroid/content/Context;

    invoke-static {v4, v3}, Lorg/xbmc/kodi/channels/util/TvUtil;->createChannel(Landroid/content/Context;Lorg/xbmc/kodi/channels/model/Subscription;)J

    move-result-wide v4

    .line 179
    invoke-virtual {v3, v4, v5}, Lorg/xbmc/kodi/channels/model/Subscription;->setChannelId(J)V

    .line 180
    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 183
    :cond_3
    invoke-interface {v0, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lorg/xbmc/kodi/channels/model/Subscription;

    invoke-virtual {v4}, Lorg/xbmc/kodi/channels/model/Subscription;->getChannelId()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Lorg/xbmc/kodi/channels/model/Subscription;->setChannelId(J)V

    .line 185
    :goto_2
    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 190
    :cond_4
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_5
    :goto_3
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_8

    .line 192
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/xbmc/kodi/channels/model/Subscription;

    .line 194
    invoke-interface {v1, v2}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v3

    if-ne v3, v4, :cond_7

    .line 197
    invoke-virtual {v2}, Lorg/xbmc/kodi/channels/model/Subscription;->getChannelId()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    .line 198
    iget-object v3, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    .line 200
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    invoke-static {v5, v6}, Landroidx/tvprovider/media/tv/TvContractCompat;->buildPreviewProgramsUriForChannel(J)Landroid/net/Uri;

    move-result-object v5

    const/4 v6, 0x0

    .line 199
    invoke-virtual {v3, v5, v6, v6}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    .line 203
    iget-object v3, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    .line 205
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v7

    invoke-static {v7, v8}, Landroidx/tvprovider/media/tv/TvContractCompat;->buildChannelUri(J)Landroid/net/Uri;

    move-result-object v5

    .line 204
    invoke-virtual {v3, v5, v6, v6}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    .line 208
    iget-object v3, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    invoke-static {v3, v5, v6}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->removeMedias(Landroid/content/Context;J)V

    .line 209
    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    .line 211
    iget-object v3, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->mContext:Landroid/content/Context;

    const-string v5, "jobscheduler"

    .line 212
    invoke-virtual {v3, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/job/JobScheduler;

    .line 213
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    invoke-static {v5, v6}, Lorg/xbmc/kodi/channels/util/TvUtil;->getTriggeredJobIdForChannelId(J)I

    move-result v5

    invoke-static {v3, v5}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m(Landroid/app/job/JobScheduler;I)Landroid/app/job/JobInfo;

    move-result-object v5

    if-eqz v5, :cond_6

    .line 214
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    invoke-static {v5, v6}, Lorg/xbmc/kodi/channels/util/TvUtil;->getTriggeredJobIdForChannelId(J)I

    move-result v5

    invoke-virtual {v3, v5}, Landroid/app/job/JobScheduler;->cancel(I)V

    .line 215
    :cond_6
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    invoke-static {v5, v6}, Lorg/xbmc/kodi/channels/util/TvUtil;->getTimedJobIdForChannelId(J)I

    move-result v5

    invoke-static {v3, v5}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m(Landroid/app/job/JobScheduler;I)Landroid/app/job/JobInfo;

    move-result-object v5

    if-eqz v5, :cond_5

    .line 216
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    invoke-static {v5, v6}, Lorg/xbmc/kodi/channels/util/TvUtil;->getTimedJobIdForChannelId(J)I

    move-result v2

    invoke-virtual {v3, v2}, Landroid/app/job/JobScheduler;->cancel(I)V

    goto/16 :goto_3

    .line 220
    :cond_7
    iget-object v3, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Lorg/xbmc/kodi/channels/model/Subscription;->getChannelId()J

    move-result-wide v5

    invoke-static {v3, v5, v6}, Lorg/xbmc/kodi/channels/util/TvUtil;->scheduleTriggeredSyncingProgramsForChannel(Landroid/content/Context;J)V

    .line 221
    iget-object v3, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Lorg/xbmc/kodi/channels/model/Subscription;->getChannelId()J

    move-result-wide v5

    invoke-static {v3, v5, v6}, Lorg/xbmc/kodi/channels/util/TvUtil;->scheduleTimedSyncingProgramsForChannel(Landroid/content/Context;J)V

    goto/16 :goto_3

    .line 223
    :cond_8
    iget-object v0, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->mContext:Landroid/content/Context;

    invoke-static {v0, v1}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->saveSubscriptions(Landroid/content/Context;Ljava/util/List;)V

    const/4 v0, 0x1

    .line 225
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method

.method public execute()V
    .locals 2

    .line 96
    iget-object v0, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->executor:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask$$ExternalSyntheticLambda1;-><init>(Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method getFilesFromUrl(Ljava/lang/String;)Ljava/util/List;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lorg/xbmc/kodi/model/File;",
            ">;"
        }
    .end annotation

    .line 111
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 113
    iget-object v1, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->mContext:Landroid/content/Context;

    .line 114
    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    .line 116
    invoke-static {p1}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    .line 115
    invoke-virtual/range {v2 .. v7}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object p1

    if-eqz p1, :cond_1

    .line 124
    :goto_0
    :try_start_0
    invoke-interface {p1}, Landroid/database/Cursor;->moveToNext()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 125
    invoke-static {p1}, Lorg/xbmc/kodi/model/File;->fromCursor(Landroid/database/Cursor;)Lorg/xbmc/kodi/model/File;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    if-eqz p1, :cond_0

    .line 113
    :try_start_1
    invoke-interface {p1}, Landroid/database/Cursor;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception p1

    invoke-virtual {v0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_0
    :goto_1
    throw v0

    :cond_1
    if-eqz p1, :cond_2

    .line 127
    invoke-interface {p1}, Landroid/database/Cursor;->close()V

    :cond_2
    return-object v0
.end method

.method synthetic lambda$execute$0$org-xbmc-kodi-channels-SyncChannelJobService$SyncChannelTask(Ljava/lang/Boolean;)V
    .locals 0

    .line 98
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->onPostExecute(Ljava/lang/Boolean;)V

    return-void
.end method

.method synthetic lambda$execute$1$org-xbmc-kodi-channels-SyncChannelJobService$SyncChannelTask()V
    .locals 3

    .line 97
    invoke-virtual {p0}, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->doInBackground()Ljava/lang/Boolean;

    move-result-object v0

    .line 98
    iget-object v1, p0, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;->handler:Landroid/os/Handler;

    new-instance v2, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask$$ExternalSyntheticLambda2;

    invoke-direct {v2, p0, v0}, Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask$$ExternalSyntheticLambda2;-><init>(Lorg/xbmc/kodi/channels/SyncChannelJobService$SyncChannelTask;Ljava/lang/Boolean;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method protected onPostExecute(Ljava/lang/Boolean;)V
    .locals 0

    return-void
.end method
