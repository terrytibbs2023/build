.class public Lorg/xbmc/kodi/model/File;
.super Ljava/lang/Object;
.source "File.java"

# interfaces
.implements Ljava/io/Serializable;


# static fields
.field public static final CATEGORY:Ljava/lang/String; = "category"

.field public static final ID:Ljava/lang/String; = "id"

.field public static final MEDIATYPE:Ljava/lang/String; = "mediatype"

.field public static final NAME:Ljava/lang/String; = "name"

.field public static final URI:Ljava/lang/String; = "uri"


# instance fields
.field private category:Ljava/lang/String;

.field private id:J

.field private mediatype:Ljava/lang/String;

.field private name:Ljava/lang/String;

.field private uri:Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    iput-object p1, p0, Lorg/xbmc/kodi/model/File;->name:Ljava/lang/String;

    .line 47
    iput-object p2, p0, Lorg/xbmc/kodi/model/File;->category:Ljava/lang/String;

    .line 48
    invoke-virtual {p0, p3}, Lorg/xbmc/kodi/model/File;->setUri(Ljava/lang/String;)V

    const/4 p1, 0x0

    .line 50
    iput-object p1, p0, Lorg/xbmc/kodi/model/File;->mediatype:Ljava/lang/String;

    const-wide/16 p1, -0x1

    .line 51
    iput-wide p1, p0, Lorg/xbmc/kodi/model/File;->id:J

    return-void
.end method

.method public static createFile(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xbmc/kodi/model/File;
    .locals 1

    .line 56
    new-instance v0, Lorg/xbmc/kodi/model/File;

    invoke-direct {v0, p0, p1, p2}, Lorg/xbmc/kodi/model/File;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method public static fromCursor(Landroid/database/Cursor;)Lorg/xbmc/kodi/model/File;
    .locals 3

    .line 62
    new-instance v0, Lorg/xbmc/kodi/model/File;

    invoke-direct {v0}, Lorg/xbmc/kodi/model/File;-><init>()V

    const-string v1, "name"

    .line 64
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    if-ltz v1, :cond_0

    invoke-interface {p0, v1}, Landroid/database/Cursor;->isNull(I)Z

    move-result v2

    if-nez v2, :cond_0

    .line 65
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/xbmc/kodi/model/File;->setName(Ljava/lang/String;)V

    :cond_0
    const-string v1, "category"

    .line 66
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    if-ltz v1, :cond_1

    invoke-interface {p0, v1}, Landroid/database/Cursor;->isNull(I)Z

    move-result v2

    if-nez v2, :cond_1

    .line 67
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/xbmc/kodi/model/File;->setCategory(Ljava/lang/String;)V

    :cond_1
    const-string v1, "uri"

    .line 68
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    if-ltz v1, :cond_2

    invoke-interface {p0, v1}, Landroid/database/Cursor;->isNull(I)Z

    move-result v2

    if-nez v2, :cond_2

    .line 69
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/xbmc/kodi/model/File;->setUri(Ljava/lang/String;)V

    :cond_2
    const-string v1, "id"

    .line 70
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    if-ltz v1, :cond_3

    invoke-interface {p0, v1}, Landroid/database/Cursor;->isNull(I)Z

    move-result v2

    if-nez v2, :cond_3

    .line 71
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lorg/xbmc/kodi/model/File;->setId(J)V

    :cond_3
    const-string v1, "mediatype"

    .line 72
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    if-ltz v1, :cond_4

    invoke-interface {p0, v1}, Landroid/database/Cursor;->isNull(I)Z

    move-result v2

    if-nez v2, :cond_4

    .line 73
    invoke-interface {p0, v1}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Lorg/xbmc/kodi/model/File;->setMediatype(Ljava/lang/String;)V

    :cond_4
    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    const/4 v1, 0x0

    if-eqz p1, :cond_7

    .line 150
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    if-eq v2, v3, :cond_1

    goto :goto_2

    .line 152
    :cond_1
    check-cast p1, Lorg/xbmc/kodi/model/File;

    .line 154
    iget-object v2, p0, Lorg/xbmc/kodi/model/File;->name:Ljava/lang/String;

    iget-object v3, p1, Lorg/xbmc/kodi/model/File;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    return v1

    .line 155
    :cond_2
    iget-object v2, p0, Lorg/xbmc/kodi/model/File;->category:Ljava/lang/String;

    if-eqz v2, :cond_3

    iget-object v3, p1, Lorg/xbmc/kodi/model/File;->category:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_4

    goto :goto_0

    :cond_3
    iget-object v2, p1, Lorg/xbmc/kodi/model/File;->category:Ljava/lang/String;

    if-eqz v2, :cond_4

    :goto_0
    return v1

    .line 156
    :cond_4
    iget-object v2, p0, Lorg/xbmc/kodi/model/File;->uri:Ljava/lang/String;

    iget-object p1, p1, Lorg/xbmc/kodi/model/File;->uri:Ljava/lang/String;

    if-eqz v2, :cond_5

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_1

    :cond_5
    if-nez p1, :cond_6

    goto :goto_1

    :cond_6
    const/4 v0, 0x0

    :goto_1
    return v0

    :cond_7
    :goto_2
    return v1
.end method

.method public getCategory()Ljava/lang/String;
    .locals 1

    .line 108
    iget-object v0, p0, Lorg/xbmc/kodi/model/File;->category:Ljava/lang/String;

    return-object v0
.end method

.method public getId()J
    .locals 2

    .line 128
    iget-wide v0, p0, Lorg/xbmc/kodi/model/File;->id:J

    return-wide v0
.end method

.method public getMediatype()Ljava/lang/String;
    .locals 1

    .line 118
    iget-object v0, p0, Lorg/xbmc/kodi/model/File;->mediatype:Ljava/lang/String;

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .line 98
    iget-object v0, p0, Lorg/xbmc/kodi/model/File;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getUri()Ljava/lang/String;
    .locals 1

    .line 138
    iget-object v0, p0, Lorg/xbmc/kodi/model/File;->uri:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 3

    .line 162
    iget-object v0, p0, Lorg/xbmc/kodi/model/File;->name:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    mul-int/lit8 v0, v0, 0x1f

    .line 163
    iget-object v1, p0, Lorg/xbmc/kodi/model/File;->category:Ljava/lang/String;

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    .line 164
    iget-object v1, p0, Lorg/xbmc/kodi/model/File;->uri:Ljava/lang/String;

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v2

    :cond_1
    add-int/2addr v0, v2

    return v0
.end method

.method public setCategory(Ljava/lang/String;)V
    .locals 0

    .line 113
    iput-object p1, p0, Lorg/xbmc/kodi/model/File;->category:Ljava/lang/String;

    return-void
.end method

.method public setId(J)V
    .locals 0

    .line 133
    iput-wide p1, p0, Lorg/xbmc/kodi/model/File;->id:J

    return-void
.end method

.method public setMediatype(Ljava/lang/String;)V
    .locals 0

    .line 123
    iput-object p1, p0, Lorg/xbmc/kodi/model/File;->mediatype:Ljava/lang/String;

    return-void
.end method

.method public setName(Ljava/lang/String;)V
    .locals 0

    .line 103
    iput-object p1, p0, Lorg/xbmc/kodi/model/File;->name:Ljava/lang/String;

    return-void
.end method

.method public setUri(Ljava/lang/String;)V
    .locals 0

    .line 143
    iput-object p1, p0, Lorg/xbmc/kodi/model/File;->uri:Ljava/lang/String;

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 81
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "File{id="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 83
    invoke-virtual {p0}, Lorg/xbmc/kodi/model/File;->getId()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, ", name=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lorg/xbmc/kodi/model/File;->name:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\', category=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lorg/xbmc/kodi/model/File;->category:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\', mediatype=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lorg/xbmc/kodi/model/File;->mediatype:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\'}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
