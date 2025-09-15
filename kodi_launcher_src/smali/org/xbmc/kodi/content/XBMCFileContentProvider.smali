.class public Lorg/xbmc/kodi/content/XBMCFileContentProvider;
.super Lorg/xbmc/kodi/content/XBMCContentProvider;
.source "XBMCFileContentProvider.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/xbmc/kodi/content/XBMCFileContentProvider$TransferThread;
    }
.end annotation


# static fields
.field public static final AUTHORITY:Ljava/lang/String; = "org.xbmc.kodi.file"

.field private static TAG:Ljava/lang/String; = "Kodi"


# instance fields
.field private mJsonRPC:Lorg/xbmc/kodi/XBMCJsonRPC;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 19
    invoke-direct {p0}, Lorg/xbmc/kodi/content/XBMCContentProvider;-><init>()V

    const/4 v0, 0x0

    .line 25
    iput-object v0, p0, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->mJsonRPC:Lorg/xbmc/kodi/XBMCJsonRPC;

    return-void
.end method

.method static synthetic access$000()Ljava/lang/String;
    .locals 1

    .line 19
    sget-object v0, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static buildUri(Ljava/lang/String;)Landroid/net/Uri;
    .locals 3

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 31
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    return-object v0

    .line 34
    :cond_1
    new-instance v0, Landroid/net/Uri$Builder;

    invoke-direct {v0}, Landroid/net/Uri$Builder;-><init>()V

    const-string v1, "content"

    .line 35
    invoke-virtual {v0, v1}, Landroid/net/Uri$Builder;->scheme(Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    const-string v2, "org.xbmc.kodi.file"

    .line 36
    invoke-virtual {v1, v2}, Landroid/net/Uri$Builder;->authority(Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    .line 37
    invoke-virtual {v1, p0}, Landroid/net/Uri$Builder;->fragment(Ljava/lang/String;)Landroid/net/Uri$Builder;

    .line 39
    invoke-virtual {v0}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public getType(Landroid/net/Uri;)Ljava/lang/String;
    .locals 0

    const-string p1, "vnd.android.cursor.dir/xbmc_file"

    return-object p1
.end method

.method public insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()Z
    .locals 1

    .line 67
    new-instance v0, Lorg/xbmc/kodi/XBMCJsonRPC;

    invoke-direct {v0}, Lorg/xbmc/kodi/XBMCJsonRPC;-><init>()V

    iput-object v0, p0, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->mJsonRPC:Lorg/xbmc/kodi/XBMCJsonRPC;

    const/4 v0, 0x1

    return v0
.end method

.method public openFile(Landroid/net/Uri;Ljava/lang/String;)Landroid/os/ParcelFileDescriptor;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/FileNotFoundException;
        }
    .end annotation

    .line 123
    :try_start_0
    invoke-virtual {p1}, Landroid/net/Uri;->getFragment()Ljava/lang/String;

    move-result-object p2

    if-nez p2, :cond_0

    const/4 p1, 0x0

    return-object p1

    .line 128
    :cond_0
    invoke-static {}, Landroid/os/ParcelFileDescriptor;->createPipe()[Landroid/os/ParcelFileDescriptor;

    move-result-object v0

    .line 130
    new-instance v1, Lorg/xbmc/kodi/content/XBMCFileContentProvider$TransferThread;

    new-instance v2, Landroid/os/ParcelFileDescriptor$AutoCloseOutputStream;

    const/4 v3, 0x1

    aget-object v3, v0, v3

    invoke-direct {v2, v3}, Landroid/os/ParcelFileDescriptor$AutoCloseOutputStream;-><init>(Landroid/os/ParcelFileDescriptor;)V

    invoke-direct {v1, p2, v2}, Lorg/xbmc/kodi/content/XBMCFileContentProvider$TransferThread;-><init>(Ljava/lang/String;Ljava/io/OutputStream;)V

    .line 131
    invoke-virtual {v1}, Lorg/xbmc/kodi/content/XBMCFileContentProvider$TransferThread;->start()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x0

    .line 140
    aget-object p1, v0, p1

    return-object p1

    :catch_0
    move-exception p2

    .line 135
    sget-object v0, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->TAG:Ljava/lang/String;

    const-string v1, "XBMCFileContentProvider: Exception opening pipe"

    invoke-static {v0, v1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 136
    new-instance p2, Ljava/io/FileNotFoundException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Could not open pipe for: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 137
    invoke-virtual {p1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/io/FileNotFoundException;-><init>(Ljava/lang/String;)V

    throw p2
.end method

.method public query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    .locals 2

    .line 83
    invoke-virtual {p1}, Landroid/net/Uri;->getFragment()Ljava/lang/String;

    move-result-object p1

    .line 85
    iget-object p2, p0, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->mJsonRPC:Lorg/xbmc/kodi/XBMCJsonRPC;

    invoke-virtual {p2, p1}, Lorg/xbmc/kodi/XBMCJsonRPC;->getFiles(Ljava/lang/String;)Ljava/util/List;

    move-result-object p1

    .line 86
    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result p2

    if-eqz p2, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    const-string p2, "id"

    const-string p3, "mediatype"

    const-string p4, "name"

    const-string p5, "category"

    const-string v0, "uri"

    .line 89
    filled-new-array {p4, p5, v0, p2, p3}, [Ljava/lang/String;

    move-result-object p2

    .line 97
    new-instance p3, Landroid/database/MatrixCursor;

    invoke-direct {p3, p2}, Landroid/database/MatrixCursor;-><init>([Ljava/lang/String;)V

    .line 99
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lorg/xbmc/kodi/model/File;

    const/4 p4, 0x5

    new-array p4, p4, [Ljava/lang/Object;

    const/4 p5, 0x0

    .line 103
    invoke-virtual {p2}, Lorg/xbmc/kodi/model/File;->getName()Ljava/lang/String;

    move-result-object v0

    aput-object v0, p4, p5

    const/4 p5, 0x1

    .line 104
    invoke-virtual {p2}, Lorg/xbmc/kodi/model/File;->getCategory()Ljava/lang/String;

    move-result-object v0

    aput-object v0, p4, p5

    const/4 p5, 0x2

    .line 105
    invoke-virtual {p2}, Lorg/xbmc/kodi/model/File;->getUri()Ljava/lang/String;

    move-result-object v0

    aput-object v0, p4, p5

    .line 106
    invoke-virtual {p2}, Lorg/xbmc/kodi/model/File;->getId()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p5

    const/4 v0, 0x3

    aput-object p5, p4, v0

    const/4 p5, 0x4

    .line 107
    invoke-virtual {p2}, Lorg/xbmc/kodi/model/File;->getMediatype()Ljava/lang/String;

    move-result-object p2

    aput-object p2, p4, p5

    .line 101
    invoke-virtual {p3, p4}, Landroid/database/MatrixCursor;->addRow([Ljava/lang/Object;)V

    goto :goto_0

    :cond_1
    return-object p3
.end method

.method public update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method
