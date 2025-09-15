.class public Landroidx/tvprovider/media/tv/Program$Builder;
.super Landroidx/tvprovider/media/tv/BaseProgram$Builder;
.source "Program.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/tvprovider/media/tv/Program;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroidx/tvprovider/media/tv/BaseProgram$Builder<",
        "Landroidx/tvprovider/media/tv/Program$Builder;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 273
    invoke-direct {p0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;-><init>()V

    return-void
.end method

.method public constructor <init>(Landroidx/tvprovider/media/tv/Program;)V
    .locals 1

    .line 280
    invoke-direct {p0}, Landroidx/tvprovider/media/tv/BaseProgram$Builder;-><init>()V

    .line 281
    new-instance v0, Landroid/content/ContentValues;

    iget-object p1, p1, Landroidx/tvprovider/media/tv/Program;->mValues:Landroid/content/ContentValues;

    invoke-direct {v0, p1}, Landroid/content/ContentValues;-><init>(Landroid/content/ContentValues;)V

    iput-object v0, p0, Landroidx/tvprovider/media/tv/Program$Builder;->mValues:Landroid/content/ContentValues;

    return-void
.end method


# virtual methods
.method public build()Landroidx/tvprovider/media/tv/Program;
    .locals 1

    .line 378
    new-instance v0, Landroidx/tvprovider/media/tv/Program;

    invoke-direct {v0, p0}, Landroidx/tvprovider/media/tv/Program;-><init>(Landroidx/tvprovider/media/tv/Program$Builder;)V

    return-object v0
.end method

.method public setBroadcastGenres([Ljava/lang/String;)Landroidx/tvprovider/media/tv/Program$Builder;
    .locals 2

    .line 328
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program$Builder;->mValues:Landroid/content/ContentValues;

    const-string v1, "broadcast_genre"

    invoke-static {p1}, Landroidx/tvprovider/media/tv/TvContractCompat$Programs$Genres;->encode([Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, v1, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    return-object p0
.end method

.method public setChannelId(J)Landroidx/tvprovider/media/tv/Program$Builder;
    .locals 2

    .line 291
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program$Builder;->mValues:Landroid/content/ContentValues;

    const-string v1, "channel_id"

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    invoke-virtual {v0, v1, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V

    return-object p0
.end method

.method public setEndTimeUtcMillis(J)Landroidx/tvprovider/media/tv/Program$Builder;
    .locals 2

    .line 315
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program$Builder;->mValues:Landroid/content/ContentValues;

    const-string v1, "end_time_utc_millis"

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    invoke-virtual {v0, v1, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V

    return-object p0
.end method

.method public setEventId(I)Landroidx/tvprovider/media/tv/Program$Builder;
    .locals 2

    .line 355
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program$Builder;->mValues:Landroid/content/ContentValues;

    const-string v1, "event_id"

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {v0, v1, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    return-object p0
.end method

.method public setGlobalContentId(Ljava/lang/String;)Landroidx/tvprovider/media/tv/Program$Builder;
    .locals 2

    .line 370
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program$Builder;->mValues:Landroid/content/ContentValues;

    const-string v1, "global_content_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    return-object p0
.end method

.method public setRecordingProhibited(Z)Landroidx/tvprovider/media/tv/Program$Builder;
    .locals 2

    .line 340
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program$Builder;->mValues:Landroid/content/ContentValues;

    .line 341
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    const-string v1, "recording_prohibited"

    .line 340
    invoke-virtual {v0, v1, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    return-object p0
.end method

.method public setStartTimeUtcMillis(J)Landroidx/tvprovider/media/tv/Program$Builder;
    .locals 2

    .line 303
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program$Builder;->mValues:Landroid/content/ContentValues;

    const-string v1, "start_time_utc_millis"

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    invoke-virtual {v0, v1, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V

    return-object p0
.end method
