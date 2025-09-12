.class public Lorg/xbmc/kodi/model/Movie;
.super Lorg/xbmc/kodi/model/Media;
.source "Movie.java"


# instance fields
.field private duration:I

.field private rating:Ljava/lang/String;

.field private year:Ljava/lang/String;


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

    .line 35
    iget v0, p0, Lorg/xbmc/kodi/model/Movie;->duration:I

    return v0
.end method

.method public getRating()Ljava/lang/String;
    .locals 1

    .line 25
    iget-object v0, p0, Lorg/xbmc/kodi/model/Movie;->rating:Ljava/lang/String;

    return-object v0
.end method

.method public getYear()Ljava/lang/String;
    .locals 1

    .line 15
    iget-object v0, p0, Lorg/xbmc/kodi/model/Movie;->year:Ljava/lang/String;

    return-object v0
.end method

.method public setDuration(I)V
    .locals 0

    .line 40
    iput p1, p0, Lorg/xbmc/kodi/model/Movie;->duration:I

    return-void
.end method

.method public setRating(Ljava/lang/String;)V
    .locals 0

    .line 30
    iput-object p1, p0, Lorg/xbmc/kodi/model/Movie;->rating:Ljava/lang/String;

    return-void
.end method

.method public setYear(Ljava/lang/String;)V
    .locals 0

    .line 20
    iput-object p1, p0, Lorg/xbmc/kodi/model/Movie;->year:Ljava/lang/String;

    return-void
.end method
