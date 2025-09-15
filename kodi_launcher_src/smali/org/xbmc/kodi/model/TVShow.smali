.class public Lorg/xbmc/kodi/model/TVShow;
.super Lorg/xbmc/kodi/model/Media;
.source "TVShow.java"


# instance fields
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
.method public getRating()Ljava/lang/String;
    .locals 1

    .line 24
    iget-object v0, p0, Lorg/xbmc/kodi/model/TVShow;->rating:Ljava/lang/String;

    return-object v0
.end method

.method public getYear()Ljava/lang/String;
    .locals 1

    .line 14
    iget-object v0, p0, Lorg/xbmc/kodi/model/TVShow;->year:Ljava/lang/String;

    return-object v0
.end method

.method public setRating(Ljava/lang/String;)V
    .locals 0

    .line 29
    iput-object p1, p0, Lorg/xbmc/kodi/model/TVShow;->rating:Ljava/lang/String;

    return-void
.end method

.method public setYear(Ljava/lang/String;)V
    .locals 0

    .line 19
    iput-object p1, p0, Lorg/xbmc/kodi/model/TVShow;->year:Ljava/lang/String;

    return-void
.end method
