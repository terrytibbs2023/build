.class public final Landroidx/tvprovider/media/tv/Program;
.super Landroidx/tvprovider/media/tv/BaseProgram;
.source "Program.java"

# interfaces
.implements Ljava/lang/Comparable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/tvprovider/media/tv/Program$Builder;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroidx/tvprovider/media/tv/BaseProgram;",
        "Ljava/lang/Comparable<",
        "Landroidx/tvprovider/media/tv/Program;",
        ">;"
    }
.end annotation


# static fields
.field private static final INVALID_INTEGER_VALUE:I = -0x1

.field private static final INVALID_LONG_VALUE:J = -0x1L

.field private static final IS_RECORDING_PROHIBITED:I = 0x1

.field public static final PROJECTION:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 80
    invoke-static {}, Landroidx/tvprovider/media/tv/Program;->getProjection()[Ljava/lang/String;

    move-result-object v0

    sput-object v0, Landroidx/tvprovider/media/tv/Program;->PROJECTION:[Ljava/lang/String;

    return-void
.end method

.method constructor <init>(Landroidx/tvprovider/media/tv/Program$Builder;)V
    .locals 0

    .line 87
    invoke-direct {p0, p1}, Landroidx/tvprovider/media/tv/BaseProgram;-><init>(Landroidx/tvprovider/media/tv/BaseProgram$Builder;)V

    return-void
.end method

.method public static fromCursor(Landroid/database/Cursor;)Landroidx/tvprovider/media/tv/Program;
    .locals 3

    .line 202
    new-instance v0, Landroidx/tvprovider/media/tv/Program$Builder;

    invoke-direct {v0}, Landroidx/tvprovider/media/tv/Program$Builder;-><init>()V

    .line 203
    invoke-static {p0, v0}, Landroidx/tvprovider/media/tv/BaseProgram;->setFieldsFromCursor(Landroid/database/Cursor;Landroidx/tvprovider/media/tv/BaseProgram$Builder;)V

    const-string v1, "channel_id"

    .line 205
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    if-ltz v1, :cond_0

    .line 206
    invoke-interface {p0, v1}, Landroid/database/Cursor;->isNull(I)Z

    move-result v2

    if-nez v2, :cond_0

    .line 207
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Landroidx/tvprovider/media/tv/Program$Builder;->setChannelId(J)Landroidx/tvprovider/media/tv/Program$Builder;

    :cond_0
    const-string v1, "broadcast_genre"

    .line 209
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    if-ltz v1, :cond_1

    .line 210
    invoke-interface {p0, v1}, Landroid/database/Cursor;->isNull(I)Z

    move-result v2

    if-nez v2, :cond_1

    .line 212
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    .line 211
    invoke-static {v1}, Landroidx/tvprovider/media/tv/TvContractCompat$Programs$Genres;->decode(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroidx/tvprovider/media/tv/Program$Builder;->setBroadcastGenres([Ljava/lang/String;)Landroidx/tvprovider/media/tv/Program$Builder;

    :cond_1
    const-string v1, "start_time_utc_millis"

    .line 214
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    if-ltz v1, :cond_2

    .line 215
    invoke-interface {p0, v1}, Landroid/database/Cursor;->isNull(I)Z

    move-result v2

    if-nez v2, :cond_2

    .line 216
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Landroidx/tvprovider/media/tv/Program$Builder;->setStartTimeUtcMillis(J)Landroidx/tvprovider/media/tv/Program$Builder;

    :cond_2
    const-string v1, "end_time_utc_millis"

    .line 218
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    if-ltz v1, :cond_3

    .line 219
    invoke-interface {p0, v1}, Landroid/database/Cursor;->isNull(I)Z

    move-result v2

    if-nez v2, :cond_3

    .line 220
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Landroidx/tvprovider/media/tv/Program$Builder;->setEndTimeUtcMillis(J)Landroidx/tvprovider/media/tv/Program$Builder;

    .line 222
    :cond_3
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x18

    if-lt v1, v2, :cond_5

    const-string v1, "recording_prohibited"

    .line 223
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    if-ltz v1, :cond_5

    .line 224
    invoke-interface {p0, v1}, Landroid/database/Cursor;->isNull(I)Z

    move-result v2

    if-nez v2, :cond_5

    .line 225
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getInt(I)I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_4

    goto :goto_0

    :cond_4
    const/4 v2, 0x0

    :goto_0
    invoke-virtual {v0, v2}, Landroidx/tvprovider/media/tv/Program$Builder;->setRecordingProhibited(Z)Landroidx/tvprovider/media/tv/Program$Builder;

    .line 228
    :cond_5
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1e

    if-lt v1, v2, :cond_7

    const-string v1, "event_id"

    .line 229
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    if-ltz v1, :cond_6

    .line 230
    invoke-interface {p0, v1}, Landroid/database/Cursor;->isNull(I)Z

    move-result v2

    if-nez v2, :cond_6

    .line 231
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getInt(I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroidx/tvprovider/media/tv/Program$Builder;->setEventId(I)Landroidx/tvprovider/media/tv/Program$Builder;

    :cond_6
    const-string v1, "global_content_id"

    .line 233
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    if-ltz v1, :cond_7

    .line 234
    invoke-interface {p0, v1}, Landroid/database/Cursor;->isNull(I)Z

    move-result v2

    if-nez v2, :cond_7

    .line 235
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroidx/tvprovider/media/tv/Program$Builder;->setGlobalContentId(Ljava/lang/String;)Landroidx/tvprovider/media/tv/Program$Builder;

    .line 238
    :cond_7
    invoke-virtual {v0}, Landroidx/tvprovider/media/tv/Program$Builder;->build()Landroidx/tvprovider/media/tv/Program;

    move-result-object p0

    return-object p0
.end method

.method private static getProjection()[Ljava/lang/String;
    .locals 8

    const-string v0, "start_time_utc_millis"

    const-string v1, "end_time_utc_millis"

    const-string v2, "channel_id"

    const-string v3, "broadcast_genre"

    .line 242
    filled-new-array {v2, v3, v0, v1}, [Ljava/lang/String;

    move-result-object v0

    const-string v1, "recording_prohibited"

    .line 248
    filled-new-array {v1}, [Ljava/lang/String;

    move-result-object v1

    const-string v2, "event_id"

    const-string v3, "global_content_id"

    .line 251
    filled-new-array {v2, v3}, [Ljava/lang/String;

    move-result-object v2

    .line 255
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1e

    const/4 v5, 0x2

    const/4 v6, 0x1

    const/4 v7, 0x0

    if-lt v3, v4, :cond_0

    .line 256
    sget-object v3, Landroidx/tvprovider/media/tv/BaseProgram;->PROJECTION:[Ljava/lang/String;

    const/4 v4, 0x3

    new-array v4, v4, [[Ljava/lang/String;

    aput-object v0, v4, v7

    aput-object v1, v4, v6

    aput-object v2, v4, v5

    invoke-static {v3, v4}, Landroidx/tvprovider/media/tv/CollectionUtils;->concatAll([Ljava/lang/Object;[[Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    return-object v0

    .line 258
    :cond_0
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x18

    if-lt v2, v3, :cond_1

    .line 259
    sget-object v2, Landroidx/tvprovider/media/tv/BaseProgram;->PROJECTION:[Ljava/lang/String;

    new-array v3, v5, [[Ljava/lang/String;

    aput-object v0, v3, v7

    aput-object v1, v3, v6

    invoke-static {v2, v3}, Landroidx/tvprovider/media/tv/CollectionUtils;->concatAll([Ljava/lang/Object;[[Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    return-object v0

    .line 261
    :cond_1
    sget-object v1, Landroidx/tvprovider/media/tv/BaseProgram;->PROJECTION:[Ljava/lang/String;

    new-array v2, v6, [[Ljava/lang/String;

    aput-object v0, v2, v7

    invoke-static {v1, v2}, Landroidx/tvprovider/media/tv/CollectionUtils;->concatAll([Ljava/lang/Object;[[Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    return-object v0
.end method


# virtual methods
.method public compareTo(Landroidx/tvprovider/media/tv/Program;)I
    .locals 4

    .line 168
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program;->mValues:Landroid/content/ContentValues;

    const-string v1, "start_time_utc_millis"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsLong(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    iget-object p1, p1, Landroidx/tvprovider/media/tv/Program;->mValues:Landroid/content/ContentValues;

    .line 169
    invoke-virtual {p1, v1}, Landroid/content/ContentValues;->getAsLong(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    .line 168
    invoke-static {v2, v3, v0, v1}, Ljava/lang/Long;->compare(JJ)I

    move-result p1

    return p1
.end method

.method public bridge synthetic compareTo(Ljava/lang/Object;)I
    .locals 0

    .line 75
    check-cast p1, Landroidx/tvprovider/media/tv/Program;

    invoke-virtual {p0, p1}, Landroidx/tvprovider/media/tv/Program;->compareTo(Landroidx/tvprovider/media/tv/Program;)I

    move-result p1

    return p1
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 1

    .line 156
    instance-of v0, p1, Landroidx/tvprovider/media/tv/Program;

    if-nez v0, :cond_0

    const/4 p1, 0x0

    return p1

    .line 159
    :cond_0
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program;->mValues:Landroid/content/ContentValues;

    check-cast p1, Landroidx/tvprovider/media/tv/Program;

    iget-object p1, p1, Landroidx/tvprovider/media/tv/Program;->mValues:Landroid/content/ContentValues;

    invoke-virtual {v0, p1}, Landroid/content/ContentValues;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public getBroadcastGenres()[Ljava/lang/String;
    .locals 2

    .line 118
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program;->mValues:Landroid/content/ContentValues;

    const-string v1, "broadcast_genre"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroidx/tvprovider/media/tv/TvContractCompat$Programs$Genres;->decode(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getChannelId()J
    .locals 2

    .line 94
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program;->mValues:Landroid/content/ContentValues;

    const-string v1, "channel_id"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsLong(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    if-nez v0, :cond_0

    const-wide/16 v0, -0x1

    goto :goto_0

    .line 95
    :cond_0
    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    :goto_0
    return-wide v0
.end method

.method public getEndTimeUtcMillis()J
    .locals 2

    .line 110
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program;->mValues:Landroid/content/ContentValues;

    const-string v1, "end_time_utc_millis"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsLong(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    if-nez v0, :cond_0

    const-wide/16 v0, -0x1

    goto :goto_0

    .line 111
    :cond_0
    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    :goto_0
    return-wide v0
.end method

.method public getEventId()I
    .locals 2

    .line 135
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program;->mValues:Landroid/content/ContentValues;

    const-string v1, "event_id"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsInteger(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, -0x1

    goto :goto_0

    .line 136
    :cond_0
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    :goto_0
    return v0
.end method

.method public getGlobalContentId()Ljava/lang/String;
    .locals 2

    .line 146
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program;->mValues:Landroid/content/ContentValues;

    const-string v1, "global_content_id"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getStartTimeUtcMillis()J
    .locals 2

    .line 102
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program;->mValues:Landroid/content/ContentValues;

    const-string v1, "start_time_utc_millis"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsLong(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0

    if-nez v0, :cond_0

    const-wide/16 v0, -0x1

    goto :goto_0

    .line 103
    :cond_0
    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    :goto_0
    return-wide v0
.end method

.method public hashCode()I
    .locals 1

    .line 151
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program;->mValues:Landroid/content/ContentValues;

    invoke-virtual {v0}, Landroid/content/ContentValues;->hashCode()I

    move-result v0

    return v0
.end method

.method public isRecordingProhibited()Z
    .locals 2

    .line 125
    iget-object v0, p0, Landroidx/tvprovider/media/tv/Program;->mValues:Landroid/content/ContentValues;

    const-string v1, "recording_prohibited"

    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->getAsInteger(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 126
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public toContentValues()Landroid/content/ContentValues;
    .locals 3

    .line 183
    invoke-super {p0}, Landroidx/tvprovider/media/tv/BaseProgram;->toContentValues()Landroid/content/ContentValues;

    move-result-object v0

    .line 184
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x18

    if-ge v1, v2, :cond_0

    const-string v1, "recording_prohibited"

    .line 185
    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->remove(Ljava/lang/String;)V

    .line 187
    :cond_0
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1e

    if-ge v1, v2, :cond_1

    const-string v1, "event_id"

    .line 188
    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->remove(Ljava/lang/String;)V

    const-string v1, "global_content_id"

    .line 189
    invoke-virtual {v0, v1}, Landroid/content/ContentValues;->remove(Ljava/lang/String;)V

    :cond_1
    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 174
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Program{"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Landroidx/tvprovider/media/tv/Program;->mValues:Landroid/content/ContentValues;

    invoke-virtual {v1}, Landroid/content/ContentValues;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
