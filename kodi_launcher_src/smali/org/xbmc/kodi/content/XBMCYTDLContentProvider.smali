.class public Lorg/xbmc/kodi/content/XBMCYTDLContentProvider;
.super Lorg/xbmc/kodi/content/XBMCContentProvider;
.source "XBMCYTDLContentProvider.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/xbmc/kodi/content/XBMCYTDLContentProvider$TransferThread;
    }
.end annotation


# static fields
.field public static AUTHORITY:Ljava/lang/String; = "org.xbmc.kodi.ytdl"

.field private static TAG:Ljava/lang/String; = "Kodi"


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Lorg/xbmc/kodi/content/XBMCContentProvider;-><init>()V

    return-void
.end method

.method public static GetYTDLUri(Ljava/lang/String;)Landroid/net/Uri;
    .locals 3

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 35
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    return-object v0

    .line 38
    :cond_1
    new-instance v0, Landroid/net/Uri$Builder;

    invoke-direct {v0}, Landroid/net/Uri$Builder;-><init>()V

    const-string v1, "content"

    .line 39
    invoke-virtual {v0, v1}, Landroid/net/Uri$Builder;->scheme(Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    sget-object v2, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider;->AUTHORITY:Ljava/lang/String;

    .line 40
    invoke-virtual {v1, v2}, Landroid/net/Uri$Builder;->authority(Ljava/lang/String;)Landroid/net/Uri$Builder;

    move-result-object v1

    .line 41
    invoke-virtual {v1, p0}, Landroid/net/Uri$Builder;->fragment(Ljava/lang/String;)Landroid/net/Uri$Builder;

    .line 43
    invoke-virtual {v0}, Landroid/net/Uri$Builder;->build()Landroid/net/Uri;

    move-result-object p0

    return-object p0
.end method

.method private static getFinalURL(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 49
    new-instance v0, Landroid/util/TimingLogger;

    sget-object v1, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider;->TAG:Ljava/lang/String;

    const-string v2, "XBMCYTDLContentProvider::getFinalURL"

    invoke-direct {v0, v1, v2}, Landroid/util/TimingLogger;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 51
    new-instance v1, Ljava/net/URL;

    invoke-direct {v1, p0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v1

    check-cast v1, Ljava/net/HttpURLConnection;

    const/4 v2, 0x0

    .line 52
    invoke-virtual {v1, v2}, Ljava/net/HttpURLConnection;->setInstanceFollowRedirects(Z)V

    .line 53
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->connect()V

    const-string v2, "connect"

    .line 54
    invoke-virtual {v0, v2}, Landroid/util/TimingLogger;->addSplit(Ljava/lang/String;)V

    .line 56
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    const-string v2, "response"

    .line 57
    invoke-virtual {v0, v2}, Landroid/util/TimingLogger;->addSplit(Ljava/lang/String;)V

    .line 59
    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v2

    const/16 v3, 0x12d

    if-eq v2, v3, :cond_1

    invoke-virtual {v1}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v2

    const/16 v3, 0x12e

    if-ne v2, v3, :cond_0

    goto :goto_0

    :cond_0
    const-string v1, "done"

    .line 65
    invoke-virtual {v0, v1}, Landroid/util/TimingLogger;->addSplit(Ljava/lang/String;)V

    .line 66
    invoke-virtual {v0}, Landroid/util/TimingLogger;->dumpToLog()V

    return-object p0

    :cond_1
    :goto_0
    const-string p0, "Location"

    .line 61
    invoke-virtual {v1, p0}, Ljava/net/HttpURLConnection;->getHeaderField(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 62
    invoke-static {p0}, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider;->getFinalURL(Ljava/lang/String;)Ljava/lang/String;

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

    const-string p1, "video/*"

    return-object p1
.end method

.method public insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()Z
    .locals 1

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

    .line 79
    :try_start_0
    invoke-virtual {p1}, Landroid/net/Uri;->getFragment()Ljava/lang/String;

    move-result-object p2
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v0, 0x0

    if-nez p2, :cond_0

    return-object v0

    .line 88
    :cond_0
    :try_start_1
    invoke-static {p2}, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider;->getFinalURL(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 96
    :try_start_2
    invoke-static {}, Landroid/os/ParcelFileDescriptor;->createPipe()[Landroid/os/ParcelFileDescriptor;

    move-result-object v0

    .line 98
    new-instance v1, Ljava/net/URL;

    invoke-direct {v1, p2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 99
    invoke-virtual {v1}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object p2

    check-cast p2, Ljava/net/HttpURLConnection;

    const/4 v1, 0x1

    .line 101
    invoke-virtual {p2, v1}, Ljava/net/HttpURLConnection;->setDoInput(Z)V

    .line 102
    invoke-virtual {p2}, Ljava/net/HttpURLConnection;->connect()V

    .line 104
    new-instance v2, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider$TransferThread;

    invoke-virtual {p2}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object p2

    new-instance v3, Landroid/os/ParcelFileDescriptor$AutoCloseOutputStream;

    aget-object v1, v0, v1

    invoke-direct {v3, v1}, Landroid/os/ParcelFileDescriptor$AutoCloseOutputStream;-><init>(Landroid/os/ParcelFileDescriptor;)V

    invoke-direct {v2, p2, v3}, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider$TransferThread;-><init>(Ljava/io/InputStream;Ljava/io/OutputStream;)V

    .line 105
    invoke-virtual {v2}, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider$TransferThread;->start()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    const/4 p1, 0x0

    .line 114
    aget-object p1, v0, p1

    return-object p1

    :catch_0
    move-exception p2

    .line 92
    :try_start_3
    invoke-virtual {p2}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    return-object v0

    :catch_1
    move-exception p2

    .line 109
    sget-object v0, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider;->TAG:Ljava/lang/String;

    const-string v1, "XBMCYTDLContentProvider: Exception opening pipe"

    invoke-static {v0, v1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 110
    new-instance p2, Ljava/io/FileNotFoundException;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Could not open pipe for: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 111
    invoke-virtual {p1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/io/FileNotFoundException;-><init>(Ljava/lang/String;)V

    throw p2
.end method

.method public query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method
