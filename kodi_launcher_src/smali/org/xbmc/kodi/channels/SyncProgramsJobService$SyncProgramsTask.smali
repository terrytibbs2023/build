.class Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;
.super Ljava/lang/Object;
.source "SyncProgramsJobService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/xbmc/kodi/channels/SyncProgramsJobService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "SyncProgramsTask"
.end annotation


# instance fields
.field private executor:Ljava/util/concurrent/ExecutorService;

.field private handler:Landroid/os/Handler;

.field private final mContext:Landroid/content/Context;

.field final synthetic this$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService;


# direct methods
.method private constructor <init>(Lorg/xbmc/kodi/channels/SyncProgramsJobService;Landroid/content/Context;)V
    .locals 0

    .line 120
    iput-object p1, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->this$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 121
    iput-object p2, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->mContext:Landroid/content/Context;

    .line 122
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object p1

    iput-object p1, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->executor:Ljava/util/concurrent/ExecutorService;

    .line 123
    new-instance p1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object p2

    invoke-direct {p1, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object p1, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->handler:Landroid/os/Handler;

    return-void
.end method

.method synthetic constructor <init>(Lorg/xbmc/kodi/channels/SyncProgramsJobService;Landroid/content/Context;Lorg/xbmc/kodi/channels/SyncProgramsJobService$1;)V
    .locals 0

    .line 113
    invoke-direct {p0, p1, p2}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;-><init>(Lorg/xbmc/kodi/channels/SyncProgramsJobService;Landroid/content/Context;)V

    return-void
.end method

.method private buildProgram(JLorg/xbmc/kodi/model/Media;)Landroidx/tvprovider/media/tv/PreviewProgram;
    .locals 4

    .line 270
    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->mContext:Landroid/content/Context;

    const-class v2, Lorg/xbmc/kodi/Splash;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "android.intent.action.GET_CONTENT"

    .line 271
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 272
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getXbmcUrl()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 274
    new-instance v1, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;

    invoke-direct {v1}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;-><init>()V

    .line 275
    invoke-virtual {v1, p1, p2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setChannelId(J)Landroidx/tvprovider/media/tv/PreviewProgram$Builder;

    move-result-object p1

    .line 276
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getTitle()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setTitle(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    move-result-object p1

    check-cast p1, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;

    .line 277
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getDescription()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setDescription(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    move-result-object p1

    check-cast p1, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;

    .line 278
    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setIntent(Landroid/content/Intent;)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    .line 280
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getCategory()Ljava/lang/String;

    move-result-object p1

    const-string p2, "movie"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    const/4 p2, 0x4

    const/4 v0, 0x3

    const/4 v2, 0x0

    if-eqz p1, :cond_0

    .line 281
    invoke-virtual {v1, v2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setType(I)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    goto :goto_0

    .line 282
    :cond_0
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getCategory()Ljava/lang/String;

    move-result-object p1

    const-string v3, "tvshow"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    const/4 p1, 0x1

    .line 283
    invoke-virtual {v1, p1}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setType(I)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    goto :goto_0

    .line 284
    :cond_1
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getCategory()Ljava/lang/String;

    move-result-object p1

    const-string v3, "episode"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    .line 285
    invoke-virtual {v1, v0}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setType(I)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    goto :goto_0

    .line 286
    :cond_2
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getCategory()Ljava/lang/String;

    move-result-object p1

    const-string v3, "album"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_3

    const/16 p1, 0x8

    .line 287
    invoke-virtual {v1, p1}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setType(I)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    goto :goto_0

    .line 288
    :cond_3
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getCategory()Ljava/lang/String;

    move-result-object p1

    const-string v3, "song"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_4

    const/4 p1, 0x7

    .line 289
    invoke-virtual {v1, p1}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setType(I)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    goto :goto_0

    .line 290
    :cond_4
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getCategory()Ljava/lang/String;

    move-result-object p1

    const-string v3, "musicvideo"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_5

    .line 291
    invoke-virtual {v1, p2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setType(I)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    .line 293
    :cond_5
    :goto_0
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getCardImageUrl()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_8

    .line 295
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getCardImageUrl()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    invoke-virtual {v1, p1}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setPosterArtUri(Landroid/net/Uri;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 296
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getCardImageAspectRatio()Ljava/lang/String;

    move-result-object p1

    const-string v3, "2:3"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_6

    .line 297
    invoke-virtual {v1, p2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setPosterArtAspectRatio(I)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    goto :goto_1

    .line 298
    :cond_6
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getCardImageAspectRatio()Ljava/lang/String;

    move-result-object p1

    const-string p2, "1:1"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_7

    .line 299
    invoke-virtual {v1, v0}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setPosterArtAspectRatio(I)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    goto :goto_1

    .line 301
    :cond_7
    invoke-virtual {v1, v2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setPosterArtAspectRatio(I)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    goto :goto_1

    .line 303
    :cond_8
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getBackgroundImageUrl()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_9

    .line 305
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getBackgroundImageUrl()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    invoke-virtual {v1, p1}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setPosterArtUri(Landroid/net/Uri;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 306
    invoke-virtual {v1, v2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setPosterArtAspectRatio(I)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    .line 308
    :cond_9
    :goto_1
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getVideoUrl()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_a

    .line 309
    invoke-virtual {p3}, Lorg/xbmc/kodi/model/Media;->getVideoUrl()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    invoke-virtual {v1, p1}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setPreviewVideoUri(Landroid/net/Uri;)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    .line 311
    :cond_a
    instance-of p1, p3, Lorg/xbmc/kodi/model/Movie;

    if-eqz p1, :cond_b

    .line 313
    const-class p1, Lorg/xbmc/kodi/model/Movie;

    invoke-virtual {p1, p3}, Ljava/lang/Class;->cast(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lorg/xbmc/kodi/model/Movie;

    .line 314
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/Movie;->getYear()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setReleaseDate(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    .line 315
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/Movie;->getDuration()I

    move-result p2

    invoke-virtual {v1, p2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setDurationMillis(I)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    .line 316
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/Movie;->getRating()Ljava/lang/String;

    move-result-object p2

    if-eqz p2, :cond_b

    .line 318
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/Movie;->getRating()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setReviewRating(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 319
    invoke-virtual {v1, v2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setReviewRatingStyle(I)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 322
    :cond_b
    instance-of p1, p3, Lorg/xbmc/kodi/model/TVShow;

    if-eqz p1, :cond_c

    .line 324
    const-class p1, Lorg/xbmc/kodi/model/TVShow;

    invoke-virtual {p1, p3}, Ljava/lang/Class;->cast(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lorg/xbmc/kodi/model/TVShow;

    .line 325
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/TVShow;->getYear()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setReleaseDate(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    .line 326
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/TVShow;->getRating()Ljava/lang/String;

    move-result-object p2

    if-eqz p2, :cond_c

    .line 328
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/TVShow;->getRating()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setReviewRating(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 329
    invoke-virtual {v1, v2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setReviewRatingStyle(I)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 332
    :cond_c
    instance-of p1, p3, Lorg/xbmc/kodi/model/TVEpisode;

    if-eqz p1, :cond_d

    .line 334
    const-class p1, Lorg/xbmc/kodi/model/TVEpisode;

    invoke-virtual {p1, p3}, Ljava/lang/Class;->cast(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lorg/xbmc/kodi/model/TVEpisode;

    .line 335
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/TVEpisode;->getShowTitle()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setTitle(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 336
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/TVEpisode;->getTitle()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setEpisodeTitle(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 337
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/TVEpisode;->getSeason()I

    move-result p2

    invoke-virtual {v1, p2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setSeasonNumber(I)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 338
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/TVEpisode;->getEpisode()I

    move-result p2

    invoke-virtual {v1, p2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setEpisodeNumber(I)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 339
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/TVEpisode;->getDuration()I

    move-result p2

    invoke-virtual {v1, p2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setDurationMillis(I)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    .line 340
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/TVEpisode;->getFirstaired()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setReleaseDate(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BasePreviewProgram$Builder;

    .line 341
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/TVEpisode;->getRating()Ljava/lang/String;

    move-result-object p2

    if-eqz p2, :cond_d

    .line 343
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/TVEpisode;->getRating()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setReviewRating(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 344
    invoke-virtual {v1, v2}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->setReviewRatingStyle(I)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 348
    :cond_d
    invoke-virtual {v1}, Landroidx/tvprovider/media/tv/PreviewProgram$Builder;->build()Landroidx/tvprovider/media/tv/PreviewProgram;

    move-result-object p1

    return-object p1
.end method

.method private createPrograms(JLjava/util/List;)Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Ljava/util/List<",
            "Lorg/xbmc/kodi/model/Media;",
            ">;)",
            "Ljava/util/List<",
            "Lorg/xbmc/kodi/model/Media;",
            ">;"
        }
    .end annotation

    .line 221
    new-instance v0, Ljava/util/ArrayList;

    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 222
    invoke-interface {p3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p3

    :cond_0
    :goto_0
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/xbmc/kodi/model/Media;

    .line 224
    invoke-direct {p0, p1, p2, v1}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->buildProgram(JLorg/xbmc/kodi/model/Media;)Landroidx/tvprovider/media/tv/PreviewProgram;

    move-result-object v2

    .line 226
    iget-object v3, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->this$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService;

    .line 227
    invoke-virtual {v3}, Lorg/xbmc/kodi/channels/SyncProgramsJobService;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    sget-object v4, Landroidx/tvprovider/media/tv/TvContractCompat$PreviewPrograms;->CONTENT_URI:Landroid/net/Uri;

    .line 230
    invoke-virtual {v2}, Landroidx/tvprovider/media/tv/PreviewProgram;->toContentValues()Landroid/content/ContentValues;

    move-result-object v2

    .line 228
    invoke-virtual {v3, v4, v2}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 234
    invoke-static {v2}, Landroid/content/ContentUris;->parseId(Landroid/net/Uri;)J

    move-result-wide v2

    .line 235
    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "SyncProgramsJobService: Inserted new program: "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const-string v5, "Kodi"

    invoke-static {v5, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 236
    invoke-virtual {v1, v2, v3}, Lorg/xbmc/kodi/model/Media;->setProgramId(J)V

    .line 237
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    return-object v0
.end method

.method private deletePrograms(JLjava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Ljava/util/List<",
            "Lorg/xbmc/kodi/model/Media;",
            ">;)V"
        }
    .end annotation

    .line 246
    invoke-interface {p3}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 252
    :cond_0
    invoke-interface {p3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p3

    const/4 v0, 0x0

    :goto_0
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/xbmc/kodi/model/Media;

    .line 254
    iget-object v2, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->this$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService;

    .line 255
    invoke-virtual {v2}, Lorg/xbmc/kodi/channels/SyncProgramsJobService;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    .line 257
    invoke-virtual {v1}, Lorg/xbmc/kodi/model/Media;->getProgramId()J

    move-result-wide v3

    invoke-static {v3, v4}, Landroidx/tvprovider/media/tv/TvContractCompat;->buildPreviewProgramUri(J)Landroid/net/Uri;

    move-result-object v1

    const/4 v3, 0x0

    .line 256
    invoke-virtual {v2, v1, v3, v3}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    move-result v1

    add-int/2addr v0, v1

    goto :goto_0

    .line 261
    :cond_1
    new-instance p3, Ljava/lang/StringBuilder;

    const-string v1, "SyncProgramsJobService: Deleted "

    invoke-direct {p3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, " programs for  channel "

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    const-string v0, "Kodi"

    invoke-static {v0, p3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 264
    iget-object p3, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->this$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService;

    invoke-virtual {p3}, Lorg/xbmc/kodi/channels/SyncProgramsJobService;->getApplicationContext()Landroid/content/Context;

    move-result-object p3

    invoke-static {p3, p1, p2}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->removeMedias(Landroid/content/Context;J)V

    return-void
.end method

.method private syncPrograms(JLjava/lang/String;Ljava/util/List;)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lorg/xbmc/kodi/model/Media;",
            ">;)V"
        }
    .end annotation

    const-string v0, "SyncProgramsJobService: Suggestion channel is browsable: "

    const-string v1, "SyncProgramsJobService: Channel is browsable: "

    .line 178
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "SyncProgramsJobService: Sync programs for channel: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "Kodi"

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 179
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, p4}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 181
    iget-object p4, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->this$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService;

    .line 182
    invoke-virtual {p4}, Lorg/xbmc/kodi/channels/SyncProgramsJobService;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    .line 184
    invoke-static {p1, p2}, Landroidx/tvprovider/media/tv/TvContractCompat;->buildChannelUri(J)Landroid/net/Uri;

    move-result-object v5

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    .line 183
    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object p4

    if-eqz p4, :cond_1

    .line 190
    :try_start_0
    invoke-interface {p4}, Landroid/database/Cursor;->moveToNext()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 192
    invoke-static {p4}, Landroidx/tvprovider/media/tv/Channel;->fromCursor(Landroid/database/Cursor;)Landroidx/tvprovider/media/tv/Channel;

    .line 194
    new-instance v4, Lorg/xbmc/kodi/XBMCJsonRPC;

    invoke-direct {v4}, Lorg/xbmc/kodi/XBMCJsonRPC;-><init>()V

    .line 195
    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-eqz v5, :cond_0

    .line 198
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p3, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-static {v3, p3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 200
    invoke-direct {p0, p1, p2, v2}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->deletePrograms(JLjava/util/List;)V

    .line 201
    invoke-virtual {v4}, Lorg/xbmc/kodi/XBMCJsonRPC;->getSuggestions()Ljava/util/List;

    move-result-object p3

    invoke-direct {p0, p1, p2, p3}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->createPrograms(JLjava/util/List;)Ljava/util/List;

    move-result-object p3

    :goto_0
    move-object v2, p3

    goto :goto_1

    .line 205
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v3, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 207
    invoke-static {p3}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p3

    invoke-virtual {p3}, Landroid/net/Uri;->getFragment()Ljava/lang/String;

    move-result-object p3

    .line 208
    invoke-virtual {v4, p3}, Lorg/xbmc/kodi/XBMCJsonRPC;->getFiles(Ljava/lang/String;)Ljava/util/List;

    move-result-object p3

    .line 210
    invoke-direct {p0, p1, p2, v2}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->deletePrograms(JLjava/util/List;)V

    .line 211
    invoke-virtual {v4, p3}, Lorg/xbmc/kodi/XBMCJsonRPC;->getMedias(Ljava/util/List;)Ljava/util/List;

    move-result-object p3

    invoke-direct {p0, p1, p2, p3}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->createPrograms(JLjava/util/List;)Ljava/util/List;

    move-result-object p3

    goto :goto_0

    .line 215
    :cond_1
    :goto_1
    iget-object p3, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->this$0:Lorg/xbmc/kodi/channels/SyncProgramsJobService;

    invoke-virtual {p3}, Lorg/xbmc/kodi/channels/SyncProgramsJobService;->getApplicationContext()Landroid/content/Context;

    move-result-object p3

    invoke-static {p3, p1, p2, v2}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->saveMedias(Landroid/content/Context;JLjava/util/List;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz p4, :cond_2

    .line 216
    invoke-interface {p4}, Landroid/database/Cursor;->close()V

    :cond_2
    return-void

    :catchall_0
    move-exception p1

    if-eqz p4, :cond_3

    .line 181
    :try_start_1
    invoke-interface {p4}, Landroid/database/Cursor;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_2

    :catchall_1
    move-exception p2

    invoke-virtual {p1, p2}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_3
    :goto_2
    throw p1
.end method


# virtual methods
.method protected cancel()V
    .locals 1

    .line 138
    iget-object v0, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->executor:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    return-void
.end method

.method protected varargs doInBackground([Ljava/lang/Long;)Ljava/lang/Boolean;
    .locals 5

    .line 143
    new-instance v0, Lorg/xbmc/kodi/XBMCJsonRPC;

    invoke-direct {v0}, Lorg/xbmc/kodi/XBMCJsonRPC;-><init>()V

    .line 144
    invoke-virtual {v0}, Lorg/xbmc/kodi/XBMCJsonRPC;->Ping()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 p1, 0x0

    .line 145
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1

    .line 148
    :cond_0
    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    .line 149
    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    .line 151
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_1
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    .line 153
    iget-object v1, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->mContext:Landroid/content/Context;

    .line 154
    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    invoke-static {v1, v2, v3}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->findSubscriptionByChannelId(Landroid/content/Context;J)Lorg/xbmc/kodi/channels/model/Subscription;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 157
    iget-object v2, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    invoke-static {v2, v3, v4}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->getMedias(Landroid/content/Context;J)Ljava/util/List;

    move-result-object v2

    .line 158
    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    invoke-virtual {v1}, Lorg/xbmc/kodi/channels/model/Subscription;->getUri()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v3, v4, v0, v2}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->syncPrograms(JLjava/lang/String;Ljava/util/List;)V

    goto :goto_0

    :cond_2
    const/4 p1, 0x1

    .line 162
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1
.end method

.method public varargs execute([Ljava/lang/Long;)V
    .locals 2

    .line 128
    iget-object v0, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->executor:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0, p1}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask$$ExternalSyntheticLambda1;-><init>(Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;[Ljava/lang/Long;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method synthetic lambda$execute$0$org-xbmc-kodi-channels-SyncProgramsJobService$SyncProgramsTask(Ljava/lang/Boolean;)V
    .locals 0

    .line 130
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->onPostExecute(Ljava/lang/Boolean;)V

    return-void
.end method

.method synthetic lambda$execute$1$org-xbmc-kodi-channels-SyncProgramsJobService$SyncProgramsTask([Ljava/lang/Long;)V
    .locals 2

    .line 129
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->doInBackground([Ljava/lang/Long;)Ljava/lang/Boolean;

    move-result-object p1

    .line 130
    iget-object v0, p0, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;->handler:Landroid/os/Handler;

    new-instance v1, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, p1}, Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask$$ExternalSyntheticLambda0;-><init>(Lorg/xbmc/kodi/channels/SyncProgramsJobService$SyncProgramsTask;Ljava/lang/Boolean;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method protected onPostExecute(Ljava/lang/Boolean;)V
    .locals 0

    return-void
.end method
