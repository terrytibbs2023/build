.class public Lorg/xbmc/kodi/model/Media;
.super Ljava/lang/Object;
.source "Media.java"

# interfaces
.implements Ljava/io/Serializable;


# static fields
.field public static final MEDIA_TYPE_ALBUM:Ljava/lang/String; = "album"

.field public static final MEDIA_TYPE_MOVIE:Ljava/lang/String; = "movie"

.field public static final MEDIA_TYPE_MUSICVIDEO:Ljava/lang/String; = "musicvideo"

.field public static final MEDIA_TYPE_SONG:Ljava/lang/String; = "song"

.field public static final MEDIA_TYPE_TVEPISODE:Ljava/lang/String; = "episode"

.field public static final MEDIA_TYPE_TVSHOW:Ljava/lang/String; = "tvshow"


# instance fields
.field private bgImageUrl:Ljava/lang/String;

.field private cardImageAspectRatio:Ljava/lang/String;

.field private cardImageUrl:Ljava/lang/String;

.field private category:Ljava/lang/String;

.field private description:Ljava/lang/String;

.field private id:J

.field private programId:J

.field private title:Ljava/lang/String;

.field private videoUrl:Ljava/lang/String;

.field private watchNextId:J

.field private xbmcUrl:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 28
    iput-object v0, p0, Lorg/xbmc/kodi/model/Media;->bgImageUrl:Ljava/lang/String;

    .line 29
    iput-object v0, p0, Lorg/xbmc/kodi/model/Media;->cardImageUrl:Ljava/lang/String;

    .line 30
    iput-object v0, p0, Lorg/xbmc/kodi/model/Media;->cardImageAspectRatio:Ljava/lang/String;

    .line 31
    iput-object v0, p0, Lorg/xbmc/kodi/model/Media;->videoUrl:Ljava/lang/String;

    .line 32
    iput-object v0, p0, Lorg/xbmc/kodi/model/Media;->xbmcUrl:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public getBackgroundImageUrl()Ljava/lang/String;
    .locals 1

    .line 121
    iget-object v0, p0, Lorg/xbmc/kodi/model/Media;->bgImageUrl:Ljava/lang/String;

    return-object v0
.end method

.method public getCardImageAspectRatio()Ljava/lang/String;
    .locals 1

    .line 151
    iget-object v0, p0, Lorg/xbmc/kodi/model/Media;->cardImageAspectRatio:Ljava/lang/String;

    return-object v0
.end method

.method public getCardImageUrl()Ljava/lang/String;
    .locals 1

    .line 131
    iget-object v0, p0, Lorg/xbmc/kodi/model/Media;->cardImageUrl:Ljava/lang/String;

    return-object v0
.end method

.method public getCategory()Ljava/lang/String;
    .locals 1

    .line 141
    iget-object v0, p0, Lorg/xbmc/kodi/model/Media;->category:Ljava/lang/String;

    return-object v0
.end method

.method public getDescription()Ljava/lang/String;
    .locals 1

    .line 91
    iget-object v0, p0, Lorg/xbmc/kodi/model/Media;->description:Ljava/lang/String;

    return-object v0
.end method

.method public getId()J
    .locals 2

    .line 71
    iget-wide v0, p0, Lorg/xbmc/kodi/model/Media;->id:J

    return-wide v0
.end method

.method public getProgramId()J
    .locals 2

    .line 51
    iget-wide v0, p0, Lorg/xbmc/kodi/model/Media;->programId:J

    return-wide v0
.end method

.method public getTitle()Ljava/lang/String;
    .locals 1

    .line 81
    iget-object v0, p0, Lorg/xbmc/kodi/model/Media;->title:Ljava/lang/String;

    return-object v0
.end method

.method public getVideoUrl()Ljava/lang/String;
    .locals 1

    .line 101
    iget-object v0, p0, Lorg/xbmc/kodi/model/Media;->videoUrl:Ljava/lang/String;

    return-object v0
.end method

.method public getWatchNextId()J
    .locals 2

    .line 61
    iget-wide v0, p0, Lorg/xbmc/kodi/model/Media;->watchNextId:J

    return-wide v0
.end method

.method public getXbmcUrl()Ljava/lang/String;
    .locals 1

    .line 111
    iget-object v0, p0, Lorg/xbmc/kodi/model/Media;->xbmcUrl:Ljava/lang/String;

    return-object v0
.end method

.method public setBackgroundImageUrl(Ljava/lang/String;)V
    .locals 0

    .line 126
    iput-object p1, p0, Lorg/xbmc/kodi/model/Media;->bgImageUrl:Ljava/lang/String;

    return-void
.end method

.method public setCardImageAspectRatio(Ljava/lang/String;)V
    .locals 0

    .line 156
    iput-object p1, p0, Lorg/xbmc/kodi/model/Media;->cardImageAspectRatio:Ljava/lang/String;

    return-void
.end method

.method public setCardImageUrl(Ljava/lang/String;)V
    .locals 0

    .line 136
    iput-object p1, p0, Lorg/xbmc/kodi/model/Media;->cardImageUrl:Ljava/lang/String;

    return-void
.end method

.method public setCategory(Ljava/lang/String;)V
    .locals 0

    .line 146
    iput-object p1, p0, Lorg/xbmc/kodi/model/Media;->category:Ljava/lang/String;

    return-void
.end method

.method public setDescription(Ljava/lang/String;)V
    .locals 0

    .line 96
    iput-object p1, p0, Lorg/xbmc/kodi/model/Media;->description:Ljava/lang/String;

    return-void
.end method

.method public setId(J)V
    .locals 0

    .line 76
    iput-wide p1, p0, Lorg/xbmc/kodi/model/Media;->id:J

    return-void
.end method

.method public setProgramId(J)V
    .locals 0

    .line 56
    iput-wide p1, p0, Lorg/xbmc/kodi/model/Media;->programId:J

    return-void
.end method

.method public setTitle(Ljava/lang/String;)V
    .locals 0

    .line 86
    iput-object p1, p0, Lorg/xbmc/kodi/model/Media;->title:Ljava/lang/String;

    return-void
.end method

.method public setVideoUrl(Ljava/lang/String;)V
    .locals 0

    .line 106
    iput-object p1, p0, Lorg/xbmc/kodi/model/Media;->videoUrl:Ljava/lang/String;

    return-void
.end method

.method public setWatchNextId(J)V
    .locals 0

    .line 66
    iput-wide p1, p0, Lorg/xbmc/kodi/model/Media;->watchNextId:J

    return-void
.end method

.method public setXbmcUrl(Ljava/lang/String;)V
    .locals 0

    .line 116
    iput-object p1, p0, Lorg/xbmc/kodi/model/Media;->xbmcUrl:Ljava/lang/String;

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 162
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Media{id="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-wide v1, p0, Lorg/xbmc/kodi/model/Media;->id:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ", programId=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lorg/xbmc/kodi/model/Media;->programId:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, "\', watchNextId=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lorg/xbmc/kodi/model/Media;->watchNextId:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, "\', title=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lorg/xbmc/kodi/model/Media;->title:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\', videoUrl=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lorg/xbmc/kodi/model/Media;->videoUrl:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\', backgroundImageUrl=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lorg/xbmc/kodi/model/Media;->bgImageUrl:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\', cardImageUrl=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lorg/xbmc/kodi/model/Media;->cardImageUrl:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\'}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
