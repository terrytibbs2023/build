.class public Lorg/xbmc/kodi/channels/util/TvUtil;
.super Ljava/lang/Object;
.source "TvUtil.java"


# static fields
.field private static final CHANNELS_PROJECTION:[Ljava/lang/String;

.field private static final CHANNEL_JOB_ID:I = 0x1f4

.field private static final CHANNEL_TIMED_JOB_ID_OFFSET:I = 0x7d0

.field private static final CHANNEL_TRIGGERED_JOB_ID_OFFSET:I = 0x3e8

.field private static final TAG:Ljava/lang/String; = "Kodi"


# direct methods
.method static constructor <clinit>()V
    .locals 3

    const-string v0, "display_name"

    const-string v1, "browsable"

    const-string v2, "_id"

    .line 56
    filled-new-array {v2, v0, v1}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lorg/xbmc/kodi/channels/util/TvUtil;->CHANNELS_PROJECTION:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static cancelAllScheduledJobs(Landroid/content/Context;)V
    .locals 1

    const-string v0, "jobscheduler"

    .line 190
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/job/JobScheduler;

    .line 191
    invoke-virtual {p0}, Landroid/app/job/JobScheduler;->cancelAll()V

    return-void
.end method

.method public static convertToBitmap(Landroid/content/Context;I)Landroid/graphics/Bitmap;
    .locals 4

    .line 165
    invoke-virtual {p0, p1}, Landroid/content/Context;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 166
    instance-of v1, v0, Landroid/graphics/drawable/VectorDrawable;

    if-eqz v1, :cond_0

    .line 170
    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result p0

    .line 171
    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result p1

    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    .line 169
    invoke-static {p0, p1, v1}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object p0

    .line 173
    new-instance p1, Landroid/graphics/Canvas;

    invoke-direct {p1, p0}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 174
    invoke-virtual {p1}, Landroid/graphics/Canvas;->getWidth()I

    move-result v1

    invoke-virtual {p1}, Landroid/graphics/Canvas;->getHeight()I

    move-result v2

    const/4 v3, 0x0

    invoke-virtual {v0, v3, v3, v1, v2}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 175
    invoke-virtual {v0, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    return-object p0

    .line 179
    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-static {p0, p1}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object p0

    return-object p0
.end method

.method public static createChannel(Landroid/content/Context;Lorg/xbmc/kodi/channels/model/Subscription;)J
    .locals 6

    .line 74
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroidx/tvprovider/media/tv/TvContractCompat$Channels;->CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lorg/xbmc/kodi/channels/util/TvUtil;->CHANNELS_PROJECTION:[Ljava/lang/String;

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    .line 75
    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v0

    const-string v1, "Kodi"

    if-eqz v0, :cond_2

    .line 81
    invoke-interface {v0}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 85
    :cond_0
    invoke-static {v0}, Landroidx/tvprovider/media/tv/Channel;->fromCursor(Landroid/database/Cursor;)Landroidx/tvprovider/media/tv/Channel;

    move-result-object v2

    .line 86
    invoke-virtual {p1}, Lorg/xbmc/kodi/channels/model/Subscription;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2}, Landroidx/tvprovider/media/tv/Channel;->getDisplayName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 88
    new-instance p0, Ljava/lang/StringBuilder;

    const-string p1, "TvUtil: Channel already exists. Returning channel "

    invoke-direct {p0, p1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 91
    invoke-virtual {v2}, Landroidx/tvprovider/media/tv/Channel;->getId()J

    move-result-wide v3

    invoke-virtual {p0, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string p1, " from TV Provider."

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 88
    invoke-static {v1, p0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 93
    invoke-virtual {v2}, Landroidx/tvprovider/media/tv/Channel;->getId()J

    move-result-wide p0

    return-wide p0

    .line 95
    :cond_1
    invoke-interface {v0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-nez v2, :cond_0

    .line 98
    :cond_2
    new-instance v0, Landroid/content/Intent;

    const-class v2, Lorg/xbmc/kodi/Splash;

    invoke-direct {v0, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 99
    invoke-virtual {p1}, Lorg/xbmc/kodi/channels/model/Subscription;->getUri()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_3

    const-string v2, "android.intent.action.VIEW"

    .line 101
    invoke-virtual {v0, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_0

    :cond_3
    const-string v2, "android.intent.action.GET_CONTENT"

    .line 105
    invoke-virtual {v0, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 106
    invoke-virtual {p1}, Lorg/xbmc/kodi/channels/model/Subscription;->getUri()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v2}, Landroid/net/Uri;->getFragment()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 109
    :goto_0
    new-instance v2, Landroidx/tvprovider/media/tv/Channel$Builder;

    invoke-direct {v2}, Landroidx/tvprovider/media/tv/Channel$Builder;-><init>()V

    const-string v3, "TYPE_PREVIEW"

    .line 110
    invoke-virtual {v2, v3}, Landroidx/tvprovider/media/tv/Channel$Builder;->setType(Ljava/lang/String;)Landroidx/tvprovider/media/tv/Channel$Builder;

    move-result-object v3

    .line 111
    invoke-virtual {p1}, Lorg/xbmc/kodi/channels/model/Subscription;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroidx/tvprovider/media/tv/Channel$Builder;->setDisplayName(Ljava/lang/String;)Landroidx/tvprovider/media/tv/Channel$Builder;

    move-result-object v3

    .line 112
    invoke-virtual {v3, v0}, Landroidx/tvprovider/media/tv/Channel$Builder;->setAppLinkIntent(Landroid/content/Intent;)Landroidx/tvprovider/media/tv/Channel$Builder;

    .line 114
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v3, "TvUtil: Creating channel: "

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Lorg/xbmc/kodi/channels/model/Subscription;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 119
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v3, Landroidx/tvprovider/media/tv/TvContractCompat$Channels;->CONTENT_URI:Landroid/net/Uri;

    .line 122
    invoke-virtual {v2}, Landroidx/tvprovider/media/tv/Channel$Builder;->build()Landroidx/tvprovider/media/tv/Channel;

    move-result-object v2

    invoke-virtual {v2}, Landroidx/tvprovider/media/tv/Channel;->toContentValues()Landroid/content/ContentValues;

    move-result-object v2

    .line 120
    invoke-virtual {v0, v3, v2}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    const-string v2, "TvUtil: Failed to add channel to the tv provider"

    .line 124
    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 125
    invoke-virtual {v0}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    const/4 v0, 0x0

    :goto_1
    if-nez v0, :cond_4

    const-wide/16 p0, 0x0

    return-wide p0

    .line 131
    :cond_4
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "TvUtil: channel insert at "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 132
    invoke-static {v0}, Landroid/content/ContentUris;->parseId(Landroid/net/Uri;)J

    move-result-wide v2

    .line 133
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v4, "TvUtil: channel id "

    invoke-direct {v0, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 135
    invoke-virtual {p1}, Lorg/xbmc/kodi/channels/model/Subscription;->getChannelLogo()I

    move-result p1

    invoke-static {p0, p1}, Lorg/xbmc/kodi/channels/util/TvUtil;->convertToBitmap(Landroid/content/Context;I)Landroid/graphics/Bitmap;

    move-result-object p1

    .line 136
    invoke-static {p0, v2, v3, p1}, Landroidx/tvprovider/media/tv/ChannelLogoUtils;->storeChannelLogo(Landroid/content/Context;JLandroid/graphics/Bitmap;)Z

    return-wide v2
.end method

.method public static getNumberOfChannels(Landroid/content/Context;)I
    .locals 6

    .line 144
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    sget-object v1, Landroidx/tvprovider/media/tv/TvContractCompat$Channels;->CONTENT_URI:Landroid/net/Uri;

    sget-object v2, Lorg/xbmc/kodi/channels/util/TvUtil;->CHANNELS_PROJECTION:[Ljava/lang/String;

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    .line 145
    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object p0

    if-eqz p0, :cond_0

    .line 151
    invoke-interface {p0}, Landroid/database/Cursor;->getCount()I

    move-result p0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method public static getTimedJobIdForChannelId(J)I
    .locals 2

    const-wide/16 v0, 0x7d0

    add-long/2addr p0, v0

    long-to-int p1, p0

    return p1
.end method

.method public static getTriggeredJobIdForChannelId(J)I
    .locals 2

    const-wide/16 v0, 0x3e8

    add-long/2addr p0, v0

    long-to-int p1, p0

    return p1
.end method

.method public static scheduleSyncingChannel(Landroid/content/Context;)V
    .locals 4

    const-string v0, "jobscheduler"

    .line 202
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/job/JobScheduler;

    const/16 v1, 0x1f4

    .line 203
    invoke-static {v0, v1}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m(Landroid/app/job/JobScheduler;I)Landroid/app/job/JobInfo;

    move-result-object v2

    if-eqz v2, :cond_0

    return-void

    .line 206
    :cond_0
    new-instance v2, Landroid/content/ComponentName;

    const-class v3, Lorg/xbmc/kodi/channels/SyncChannelJobService;

    invoke-direct {v2, p0, v3}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 207
    new-instance p0, Landroid/app/job/JobInfo$Builder;

    invoke-direct {p0, v1, v2}, Landroid/app/job/JobInfo$Builder;-><init>(ILandroid/content/ComponentName;)V

    const/4 v1, 0x1

    .line 208
    invoke-virtual {p0, v1}, Landroid/app/job/JobInfo$Builder;->setRequiredNetworkType(I)Landroid/app/job/JobInfo$Builder;

    const-wide/16 v1, 0x2710

    .line 209
    invoke-virtual {p0, v1, v2}, Landroid/app/job/JobInfo$Builder;->setMinimumLatency(J)Landroid/app/job/JobInfo$Builder;

    const-string v1, "TvUtil: Scheduled channel creation."

    const-string v2, "Kodi"

    .line 211
    invoke-static {v2, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 214
    :try_start_0
    invoke-virtual {p0}, Landroid/app/job/JobInfo$Builder;->build()Landroid/app/job/JobInfo;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/app/job/JobScheduler;->schedule(Landroid/app/job/JobInfo;)I
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    .line 216
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "TvUtil: scheduleSyncingChannel - Exception: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Ljava/lang/IllegalStateException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v2, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void
.end method

.method public static scheduleTimedSyncingProgramsForChannel(Landroid/content/Context;J)V
    .locals 3

    const-string v0, "jobscheduler"

    .line 267
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/job/JobScheduler;

    .line 268
    invoke-static {p1, p2}, Lorg/xbmc/kodi/channels/util/TvUtil;->getTimedJobIdForChannelId(J)I

    move-result v1

    invoke-static {v0, v1}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m(Landroid/app/job/JobScheduler;I)Landroid/app/job/JobInfo;

    move-result-object v1

    if-eqz v1, :cond_0

    return-void

    .line 271
    :cond_0
    new-instance v1, Landroid/content/ComponentName;

    const-class v2, Lorg/xbmc/kodi/channels/SyncProgramsJobService;

    invoke-direct {v1, p0, v2}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 273
    new-instance p0, Landroid/app/job/JobInfo$Builder;

    .line 274
    invoke-static {p1, p2}, Lorg/xbmc/kodi/channels/util/TvUtil;->getTimedJobIdForChannelId(J)I

    move-result v2

    invoke-direct {p0, v2, v1}, Landroid/app/job/JobInfo$Builder;-><init>(ILandroid/content/ComponentName;)V

    const-wide/32 v1, 0x1b7740

    .line 275
    invoke-virtual {p0, v1, v2}, Landroid/app/job/JobInfo$Builder;->setPeriodic(J)Landroid/app/job/JobInfo$Builder;

    .line 277
    new-instance v1, Landroid/os/PersistableBundle;

    invoke-direct {v1}, Landroid/os/PersistableBundle;-><init>()V

    const-string v2, "android.media.tv.extra.CHANNEL_ID"

    .line 278
    invoke-virtual {v1, v2, p1, p2}, Landroid/os/PersistableBundle;->putLong(Ljava/lang/String;J)V

    .line 279
    invoke-virtual {p0, v1}, Landroid/app/job/JobInfo$Builder;->setExtras(Landroid/os/PersistableBundle;)Landroid/app/job/JobInfo$Builder;

    .line 281
    invoke-virtual {p0}, Landroid/app/job/JobInfo$Builder;->build()Landroid/app/job/JobInfo;

    move-result-object p0

    .line 282
    new-instance p1, Ljava/lang/StringBuilder;

    const-string p2, "TvUtil: scheduleTimedSyncingProgramsForChannel: minperiod="

    invoke-direct {p1, p2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m()J

    move-result-wide v1

    invoke-virtual {p1, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, "Kodi"

    invoke-static {p2, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 285
    :try_start_0
    invoke-virtual {v0, p0}, Landroid/app/job/JobScheduler;->schedule(Landroid/app/job/JobInfo;)I
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    .line 287
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "TvUtil: scheduleTimedSyncingProgramsForChannel - Exception: "

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Ljava/lang/IllegalStateException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p2, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void
.end method

.method public static scheduleTriggeredSyncingProgramsForChannel(Landroid/content/Context;J)V
    .locals 3

    const-string v0, "jobscheduler"

    .line 230
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/job/JobScheduler;

    .line 231
    new-instance v1, Landroid/content/ComponentName;

    const-class v2, Lorg/xbmc/kodi/channels/SyncProgramsJobService;

    invoke-direct {v1, p0, v2}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 233
    new-instance p0, Landroid/app/job/JobInfo$Builder;

    .line 234
    invoke-static {p1, p2}, Lorg/xbmc/kodi/channels/util/TvUtil;->getTriggeredJobIdForChannelId(J)I

    move-result v2

    invoke-direct {p0, v2, v1}, Landroid/app/job/JobInfo$Builder;-><init>(ILandroid/content/ComponentName;)V

    .line 236
    invoke-static {}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m()V

    .line 238
    invoke-static {p1, p2}, Landroidx/tvprovider/media/tv/TvContractCompat;->buildChannelUri(J)Landroid/net/Uri;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v1, v2}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m(Landroid/net/Uri;I)Landroid/app/job/JobInfo$TriggerContentUri;

    move-result-object v1

    .line 240
    invoke-static {p0, v1}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m(Landroid/app/job/JobInfo$Builder;Landroid/app/job/JobInfo$TriggerContentUri;)Landroid/app/job/JobInfo$Builder;

    const-wide/16 v1, 0x0

    .line 241
    invoke-static {p0, v1, v2}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m(Landroid/app/job/JobInfo$Builder;J)Landroid/app/job/JobInfo$Builder;

    .line 242
    invoke-static {p0, v1, v2}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m$1(Landroid/app/job/JobInfo$Builder;J)Landroid/app/job/JobInfo$Builder;

    .line 244
    new-instance v1, Landroid/os/PersistableBundle;

    invoke-direct {v1}, Landroid/os/PersistableBundle;-><init>()V

    const-string v2, "android.media.tv.extra.CHANNEL_ID"

    .line 245
    invoke-virtual {v1, v2, p1, p2}, Landroid/os/PersistableBundle;->putLong(Ljava/lang/String;J)V

    .line 246
    invoke-virtual {p0, v1}, Landroid/app/job/JobInfo$Builder;->setExtras(Landroid/os/PersistableBundle;)Landroid/app/job/JobInfo$Builder;

    .line 248
    invoke-static {p1, p2}, Lorg/xbmc/kodi/channels/util/TvUtil;->getTriggeredJobIdForChannelId(J)I

    move-result p1

    invoke-virtual {v0, p1}, Landroid/app/job/JobScheduler;->cancel(I)V

    .line 251
    :try_start_0
    invoke-virtual {p0}, Landroid/app/job/JobInfo$Builder;->build()Landroid/app/job/JobInfo;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/app/job/JobScheduler;->schedule(Landroid/app/job/JobInfo;)I
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    .line 253
    new-instance p1, Ljava/lang/StringBuilder;

    const-string p2, "TvUtil: scheduleTriggeredSyncingProgramsForChannel - Exception: "

    invoke-direct {p1, p2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Ljava/lang/IllegalStateException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string p1, "Kodi"

    invoke-static {p1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void
.end method
