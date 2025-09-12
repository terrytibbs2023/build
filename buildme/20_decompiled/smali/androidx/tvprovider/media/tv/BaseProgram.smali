.class public abstract Landroidx/tvprovider/media/tv/BaseProgram;
.super Ljava/lang/Object;
.source "BaseProgram.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/tvprovider/media/tv/BaseProgram$Builder;
    }
.end annotation


# static fields
.field private static final INVALID_INT_VALUE:I = -0x1

.field private static final INVALID_LONG_VALUE:J = -0x1L

.field private static final IS_SEARCHABLE:I = 0x1

.field public static final PROJECTION:[Ljava/lang/String;

.field private static final REVIEW_RATING_STYLE_UNKNOWN:I = -0x1


# instance fields
.field protected mValues:Landroid/content/ContentValues;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 50
    invoke-static {}, Landroidx/tvprovider/media/tv/BaseProgram;->getProjection()[Ljava/lang/String;

    move-result-object v0

    sput-object v0, Landroidx/tvprovider/media/tv/BaseProgram;->PROJECTION:[Ljava/lang/String;

    return-void
.end method

.method constructor <init>(Landroidx/tvprovider/media/tv/BaseProgram$Builder;)V
    .locals 0

    .line 77
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 78
    iget-object p1, p1, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->mValues:Landroid/content/ContentValues;

    iput-object p1, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    return-void
.end method

.method private static getProjection()[Ljava/lang/String;
    .locals 11

    const/16 v0, 0x11

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "_id"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const-string v1, "package_name"

    const/4 v3, 0x1

    aput-object v1, v0, v3

    const-string v1, "title"

    const/4 v4, 0x2

    aput-object v1, v0, v4

    const-string v1, "episode_title"

    const/4 v5, 0x3

    aput-object v1, v0, v5

    .line 493
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0x18

    if-lt v1, v6, :cond_0

    const-string v1, "season_display_number"

    goto :goto_0

    :cond_0
    const-string v1, "season_number"

    :goto_0
    const/4 v7, 0x4

    aput-object v1, v0, v7

    .line 496
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v1, v6, :cond_1

    const-string v1, "episode_display_number"

    goto :goto_1

    :cond_1
    const-string v1, "episode_number"

    :goto_1
    const/4 v7, 0x5

    aput-object v1, v0, v7

    const/4 v1, 0x6

    const-string v7, "short_description"

    aput-object v7, v0, v1

    const/4 v1, 0x7

    const-string v7, "long_description"

    aput-object v7, v0, v1

    const/16 v1, 0x8

    const-string v7, "poster_art_uri"

    aput-object v7, v0, v1

    const/16 v1, 0x9

    const-string v7, "thumbnail_uri"

    aput-object v7, v0, v1

    const/16 v1, 0xa

    const-string v7, "audio_language"

    aput-object v7, v0, v1

    const/16 v1, 0xb

    const-string v7, "canonical_genre"

    aput-object v7, v0, v1

    const/16 v1, 0xc

    const-string v7, "content_rating"

    aput-object v7, v0, v1

    const/16 v1, 0xd

    const-string v7, "video_width"

    aput-object v7, v0, v1

    const/16 v1, 0xe

    const-string v7, "video_height"

    aput-object v7, v0, v1

    const/16 v1, 0xf

    const-string v7, "internal_provider_data"

    aput-object v7, v0, v1

    const/16 v1, 0x10

    const-string v7, "series_id"

    aput-object v7, v0, v1

    const-string v1, "internal_provider_flag3"

    const-string v7, "internal_provider_flag4"

    const-string v8, "searchable"

    const-string v9, "internal_provider_flag1"

    const-string v10, "internal_provider_flag2"

    .line 511
    filled-new-array {v8, v9, v10, v1, v7}, [Ljava/lang/String;

    move-result-object v1

    const-string v7, "season_title"

    .line 518
    filled-new-array {v7}, [Ljava/lang/String;

    move-result-object v7

    const-string v8, "review_rating"

    const-string v9, "review_rating_style"

    .line 521
    filled-new-array {v8, v9}, [Ljava/lang/String;

    move-result-object v8

    .line 525
    sget v9, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v10, 0x1a

    if-lt v9, v10, :cond_2

    new-array v5, v5, [[Ljava/lang/String;

    aput-object v1, v5, v2

    aput-object v7, v5, v3

    aput-object v8, v5, v4

    .line 526
    invoke-static {v0, v5}, Landroidx/tvprovider/media/tv/CollectionUtils;->concatAll([Ljava/lang/Object;[[Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    return-object v0

    .line 528
    :cond_2
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v5, v6, :cond_3

    new-array v4, v4, [[Ljava/lang/String;

    aput-object v1, v4, v2

    aput-object v7, v4, v3

    .line 529
    invoke-static {v0, v4}, Landroidx/tvprovider/media/tv/CollectionUtils;->concatAll([Ljava/lang/Object;[[Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    return-object v0

    .line 530
    :cond_3
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0x17

    if-lt v4, v5, :cond_4

    new-array v3, v3, [[Ljava/lang/String;

    aput-object v1, v3, v2

    .line 531
    invoke-static {v0, v3}, Landroidx/tvprovider/media/tv/CollectionUtils;->concatAll([Ljava/lang/Object;[[Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    :cond_4
    return-object v0
.end method

.method static setFieldsFromCursor(Landroid/database/Cursor;Landroidx/tvprovider/media/tv/BaseProgram$Builder;)V
    .locals 4

    const-string v0, "_id"

    .line 355
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_0

    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_0

    .line 356
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setId(J)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_0
    const-string v0, "package_name"

    .line 358
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_1

    .line 359
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_1

    .line 360
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setPackageName(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_1
    const-string v0, "title"

    .line 362
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_2

    .line 363
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_2

    .line 364
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setTitle(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_2
    const-string v0, "episode_title"

    .line 366
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_3

    .line 367
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_3

    .line 368
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setEpisodeTitle(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 370
    :cond_3
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, -0x1

    const/16 v2, 0x18

    if-lt v0, v2, :cond_4

    const-string v0, "season_display_number"

    .line 372
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_5

    .line 373
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v3

    if-nez v3, :cond_5

    .line 374
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0, v1}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setSeasonNumber(Ljava/lang/String;I)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    goto :goto_0

    :cond_4
    const-string v0, "season_number"

    .line 377
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_5

    .line 378
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v3

    if-nez v3, :cond_5

    .line 379
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getInt(I)I

    move-result v0

    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setSeasonNumber(I)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 382
    :cond_5
    :goto_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v0, v2, :cond_6

    const-string v0, "episode_display_number"

    .line 384
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_7

    .line 385
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v3

    if-nez v3, :cond_7

    .line 386
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0, v1}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setEpisodeNumber(Ljava/lang/String;I)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    goto :goto_1

    :cond_6
    const-string v0, "episode_number"

    .line 389
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_7

    .line 390
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_7

    .line 391
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getInt(I)I

    move-result v0

    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setEpisodeNumber(I)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_7
    :goto_1
    const-string v0, "short_description"

    .line 394
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_8

    .line 395
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_8

    .line 396
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setDescription(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_8
    const-string v0, "long_description"

    .line 398
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_9

    .line 399
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_9

    .line 400
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setLongDescription(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_9
    const-string v0, "poster_art_uri"

    .line 402
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_a

    .line 403
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_a

    .line 404
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setPosterArtUri(Landroid/net/Uri;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_a
    const-string v0, "thumbnail_uri"

    .line 406
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_b

    .line 407
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_b

    .line 408
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setThumbnailUri(Landroid/net/Uri;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_b
    const-string v0, "audio_language"

    .line 410
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_c

    .line 411
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_c

    .line 413
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroidx/tvprovider/media/tv/TvContractUtils;->stringToAudioLanguages(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 412
    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setAudioLanguages([Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_c
    const-string v0, "canonical_genre"

    .line 415
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_d

    .line 416
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_d

    .line 418
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 417
    invoke-static {v0}, Landroidx/tvprovider/media/tv/TvContractCompat$Programs$Genres;->decode(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setCanonicalGenres([Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_d
    const-string v0, "content_rating"

    .line 420
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_e

    .line 421
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_e

    .line 423
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroidx/tvprovider/media/tv/TvContractUtils;->stringToContentRatings(Ljava/lang/String;)[Landroid/media/tv/TvContentRating;

    move-result-object v0

    .line 422
    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setContentRatings([Landroid/media/tv/TvContentRating;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_e
    const-string v0, "video_width"

    .line 425
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_f

    .line 426
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_f

    .line 427
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v0

    long-to-int v1, v0

    invoke-virtual {p1, v1}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setVideoWidth(I)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_f
    const-string v0, "video_height"

    .line 429
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_10

    .line 430
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_10

    .line 431
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v0

    long-to-int v1, v0

    invoke-virtual {p1, v1}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setVideoHeight(I)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_10
    const-string v0, "internal_provider_data"

    .line 433
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_11

    .line 434
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_11

    .line 435
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getBlob(I)[B

    move-result-object v0

    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setInternalProviderData([B)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 437
    :cond_11
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_17

    const-string v0, "searchable"

    .line 438
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_13

    .line 439
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_13

    .line 440
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getInt(I)I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_12

    goto :goto_2

    :cond_12
    const/4 v1, 0x0

    :goto_2
    invoke-virtual {p1, v1}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setSearchable(Z)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_13
    const-string v0, "internal_provider_flag1"

    .line 443
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_14

    .line 444
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_14

    .line 445
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setInternalProviderFlag1(J)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_14
    const-string v0, "internal_provider_flag2"

    .line 448
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_15

    .line 449
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_15

    .line 450
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setInternalProviderFlag2(J)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_15
    const-string v0, "internal_provider_flag3"

    .line 453
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_16

    .line 454
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_16

    .line 455
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setInternalProviderFlag3(J)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_16
    const-string v0, "internal_provider_flag4"

    .line 458
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_17

    .line 459
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_17

    .line 460
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setInternalProviderFlag4(J)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 463
    :cond_17
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v0, v2, :cond_18

    const-string v0, "season_title"

    .line 464
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_18

    .line 465
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_18

    .line 466
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setSeasonTitle(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    .line 469
    :cond_18
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_1a

    const-string v0, "review_rating_style"

    .line 470
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_19

    .line 472
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_19

    .line 473
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getInt(I)I

    move-result v0

    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setReviewRatingStyle(I)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_19
    const-string v0, "review_rating"

    .line 475
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_1a

    .line 476
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_1a

    .line 477
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setReviewRating(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_1a
    const-string v0, "series_id"

    .line 480
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_1b

    .line 481
    invoke-interface {p0, v0}, Landroid/database/Cursor;->isNull(I)Z

    move-result v1

    if-nez v1, :cond_1b

    .line 482
    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;->setSeriesId(Ljava/lang/String;)Landroidx/tvprovider/media/tv/BaseProgram$Builder;

    :cond_1b
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 1

    .line 311
    instance-of v0, p1, Landroidx/tvprovider/media/tv/BaseProgram;

    if-nez v0, :cond_0

    const/4 p1, 0x0

    return p1

    .line 314
    :cond_0
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    check-cast p1, Landroidx/tvprovider/media/tv/BaseProgram;

    iget-object p1, p1, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    invoke-virtual {v0, p1}, Landroid/content/ContentValues;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public getAudioLanguages()[Ljava/lang/String;
    .locals 2

    .line 224
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "audio_language"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroidx/tvprovider/media/tv/TvContractUtils;->stringToAudioLanguages(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getCanonicalGenres()[Ljava/lang/String;
    .locals 2

    .line 181
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "canonical_genre"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroidx/tvprovider/media/tv/TvContractCompat$Programs$Genres;->decode(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getContentRatings()[Landroid/media/tv/TvContentRating;
    .locals 2

    .line 189
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "content_rating"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroidx/tvprovider/media/tv/TvContractUtils;->stringToContentRatings(Ljava/lang/String;)[Landroid/media/tv/TvContentRating;

    move-result-object v0

    return-object v0
.end method

.method public getDescription()Ljava/lang/String;
    .locals 2

    .line 147
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "short_description"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getEpisodeNumber()Ljava/lang/String;
    .locals 2

    .line 135
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-lt v0, v1, :cond_0

    .line 136
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "episode_display_number"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 138
    :cond_0
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "episode_number"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getEpisodeTitle()Ljava/lang/String;
    .locals 2

    .line 113
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "episode_title"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getId()J
    .locals 2

    .line 86
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "_id"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsLong(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    if-nez v0, :cond_0

    const-wide/16 v0, -0x1

    goto :goto_0

    .line 87
    :cond_0
    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    :goto_0
    return-wide v0
.end method

.method public getInternalProviderDataByteArray()[B
    .locals 2

    .line 216
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "internal_provider_data"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsByteArray(Ljava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public getInternalProviderFlag1()Ljava/lang/Long;
    .locals 2

    .line 242
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "internal_provider_flag1"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsLong(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    return-object v0
.end method

.method public getInternalProviderFlag2()Ljava/lang/Long;
    .locals 2

    .line 250
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "internal_provider_flag2"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsLong(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    return-object v0
.end method

.method public getInternalProviderFlag3()Ljava/lang/Long;
    .locals 2

    .line 258
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "internal_provider_flag3"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsLong(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    return-object v0
.end method

.method public getInternalProviderFlag4()Ljava/lang/Long;
    .locals 2

    .line 266
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "internal_provider_flag4"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsLong(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    return-object v0
.end method

.method public getLongDescription()Ljava/lang/String;
    .locals 2

    .line 155
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "long_description"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getPackageName()Ljava/lang/String;
    .locals 2

    .line 97
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "package_name"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getPosterArtUri()Landroid/net/Uri;
    .locals 2

    .line 198
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "poster_art_uri"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    .line 199
    :cond_0
    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method public getReviewRating()Ljava/lang/String;
    .locals 2

    .line 291
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "review_rating"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getReviewRatingStyle()I
    .locals 2

    .line 282
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "review_rating_style"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsInteger(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, -0x1

    goto :goto_0

    .line 283
    :cond_0
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    :goto_0
    return v0
.end method

.method public getSeasonNumber()Ljava/lang/String;
    .locals 2

    .line 122
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x18

    if-lt v0, v1, :cond_0

    .line 123
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "season_display_number"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 125
    :cond_0
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "season_number"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getSeasonTitle()Ljava/lang/String;
    .locals 2

    .line 274
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "season_title"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getSeriesId()Ljava/lang/String;
    .locals 2

    .line 301
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "series_id"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getThumbnailUri()Landroid/net/Uri;
    .locals 2

    .line 207
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "poster_art_uri"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    .line 208
    :cond_0
    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method public getTitle()Ljava/lang/String;
    .locals 2

    .line 105
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "title"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getVideoHeight()I
    .locals 2

    .line 172
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "video_height"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsInteger(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, -0x1

    goto :goto_0

    .line 173
    :cond_0
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    :goto_0
    return v0
.end method

.method public getVideoWidth()I
    .locals 2

    .line 163
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "video_width"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsInteger(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, -0x1

    goto :goto_0

    .line 164
    :cond_0
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    :goto_0
    return v0
.end method

.method public hashCode()I
    .locals 1

    .line 306
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    invoke-virtual {v0}, Landroid/content/ContentValues;->hashCode()I

    move-result v0

    return v0
.end method

.method public isSearchable()Z
    .locals 2

    .line 233
    iget-object v0, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    const-string v1, "searchable"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsInteger(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    .line 234
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :cond_1
    :goto_0
    return v1
.end method

.method public toContentValues()Landroid/content/ContentValues;
    .locals 3

    .line 327
    new-instance v0, Landroid/content/ContentValues;

    iget-object v1, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    invoke-direct {v0, v1}, Landroid/content/ContentValues;-><init>(Landroid/content/ContentValues;)V

    .line 328
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x17

    if-ge v1, v2, :cond_0

    const-string v1, "searchable"

    .line 329
    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->remove(Ljava/lang/String;)V

    const-string v1, "internal_provider_flag1"

    .line 330
    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->remove(Ljava/lang/String;)V

    const-string v1, "internal_provider_flag2"

    .line 331
    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->remove(Ljava/lang/String;)V

    const-string v1, "internal_provider_flag3"

    .line 332
    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->remove(Ljava/lang/String;)V

    const-string v1, "internal_provider_flag4"

    .line 333
    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->remove(Ljava/lang/String;)V

    .line 335
    :cond_0
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x18

    if-ge v1, v2, :cond_1

    const-string v1, "season_title"

    .line 336
    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->remove(Ljava/lang/String;)V

    .line 338
    :cond_1
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-ge v1, v2, :cond_2

    const-string v1, "review_rating_style"

    .line 339
    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->remove(Ljava/lang/String;)V

    const-string v1, "review_rating"

    .line 340
    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->remove(Ljava/lang/String;)V

    :cond_2
    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 319
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "BaseProgram{"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Landroidx/tvprovider/media/tv/BaseProgram;->mValues:Landroid/content/ContentValues;

    invoke-virtual {v1}, Landroid/content/ContentValues;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
