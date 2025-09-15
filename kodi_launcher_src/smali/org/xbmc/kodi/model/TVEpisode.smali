.class public Lorg/xbmc/kodi/model/TVEpisode;
.super Lorg/xbmc/kodi/model/Media;
.source "TVEpisode.java"


# instance fields
.field private duration:I

.field private episode:I

.field private firstaired:Ljava/lang/String;

.field private rating:Ljava/lang/String;

.field private season:I

.field private showtitle:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Lorg/xbmc/kodi/model/Media;-><init>()V

    return-void
.end method


# virtual methods
.method public getDuration()I
    .locals 1

    .line 58
    iget v0, p0, Lorg/xbmc/kodi/model/TVEpisode;->duration:I

    return v0
.end method

.method public getEpisode()I
    .locals 1

    .line 38
    iget v0, p0, Lorg/xbmc/kodi/model/TVEpisode;->episode:I

    return v0
.end method

.method public getFirstaired()Ljava/lang/String;
    .locals 1

    .line 68
    iget-object v0, p0, Lorg/xbmc/kodi/model/TVEpisode;->firstaired:Ljava/lang/String;

    return-object v0
.end method

.method public getRating()Ljava/lang/String;
    .locals 1

    .line 48
    iget-object v0, p0, Lorg/xbmc/kodi/model/TVEpisode;->rating:Ljava/lang/String;

    return-object v0
.end method

.method public getSeason()I
    .locals 1

    .line 28
    iget v0, p0, Lorg/xbmc/kodi/model/TVEpisode;->season:I

    return v0
.end method

.method public getShowTitle()Ljava/lang/String;
    .locals 1

    .line 18
    iget-object v0, p0, Lorg/xbmc/kodi/model/TVEpisode;->showtitle:Ljava/lang/String;

    return-object v0
.end method

.method public setDuration(I)V
    .locals 0

    .line 63
    iput p1, p0, Lorg/xbmc/kodi/model/TVEpisode;->duration:I

    return-void
.end method

.method public setEpisode(I)V
    .locals 0

    .line 43
    iput p1, p0, Lorg/xbmc/kodi/model/TVEpisode;->episode:I

    return-void
.end method

.method public setFirstaired(Ljava/lang/String;)V
    .locals 0

    .line 73
    iput-object p1, p0, Lorg/xbmc/kodi/model/TVEpisode;->firstaired:Ljava/lang/String;

    return-void
.end method

.method public setRating(Ljava/lang/String;)V
    .locals 0

    .line 53
    iput-object p1, p0, Lorg/xbmc/kodi/model/TVEpisode;->rating:Ljava/lang/String;

    return-void
.end method

.method public setSeason(I)V
    .locals 0

    .line 33
    iput p1, p0, Lorg/xbmc/kodi/model/TVEpisode;->season:I

    return-void
.end method

.method public setShowTitle(Ljava/lang/String;)V
    .locals 0

    .line 23
    iput-object p1, p0, Lorg/xbmc/kodi/model/TVEpisode;->showtitle:Ljava/lang/String;

    return-void
.end method
