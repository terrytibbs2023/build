.class public Lorg/xbmc/kodi/XBMCFile;
.super Ljava/lang/Object;
.source "XBMCFile.java"


# static fields
.field private static TAG:Ljava/lang/String; = "Kodi"


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public Close()V
    .locals 2

    .line 46
    :try_start_0
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCFile;->_close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    .line 56
    :catch_0
    sget-object v0, Lorg/xbmc/kodi/XBMCFile;->TAG:Ljava/lang/String;

    const-string v1, "XBMCFile.Close: Not available"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :catch_1
    move-exception v0

    .line 50
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 51
    sget-object v0, Lorg/xbmc/kodi/XBMCFile;->TAG:Ljava/lang/String;

    const-string v1, "XBMCFile.Close: Exception"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public Eof()Z
    .locals 3

    const/4 v0, 0x0

    .line 84
    :try_start_0
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCFile;->_eof()Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    .line 94
    :catch_0
    sget-object v1, Lorg/xbmc/kodi/XBMCFile;->TAG:Ljava/lang/String;

    const-string v2, "XBMCFile.Eof: Not available"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return v0

    :catch_1
    move-exception v1

    .line 88
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 89
    sget-object v1, Lorg/xbmc/kodi/XBMCFile;->TAG:Ljava/lang/String;

    const-string v2, "XBMCFile.Eof: Exception"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return v0
.end method

.method public Open(Ljava/lang/String;)Z
    .locals 2

    const/4 v0, 0x0

    .line 27
    :try_start_0
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCFile;->_open(Ljava/lang/String;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    .line 37
    :catch_0
    sget-object p1, Lorg/xbmc/kodi/XBMCFile;->TAG:Ljava/lang/String;

    const-string v1, "XBMCFile.Open: Not available"

    invoke-static {p1, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return v0

    :catch_1
    move-exception p1

    .line 31
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    .line 32
    sget-object p1, Lorg/xbmc/kodi/XBMCFile;->TAG:Ljava/lang/String;

    const-string v1, "XBMCFile.Open: Exception"

    invoke-static {p1, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return v0
.end method

.method public Read()[B
    .locals 3

    const/4 v0, 0x0

    .line 65
    :try_start_0
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCFile;->_read()[B

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 75
    :catch_0
    sget-object v1, Lorg/xbmc/kodi/XBMCFile;->TAG:Ljava/lang/String;

    const-string v2, "XBMCFile.Read: Not available"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    new-array v0, v0, [B

    return-object v0

    :catch_1
    move-exception v1

    .line 69
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 70
    sget-object v1, Lorg/xbmc/kodi/XBMCFile;->TAG:Ljava/lang/String;

    const-string v2, "XBMCFile.Read: Exception"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    new-array v0, v0, [B

    return-object v0
.end method

.method native _close()V
.end method

.method native _eof()Z
.end method

.method native _open(Ljava/lang/String;)Z
.end method

.method native _read()[B
.end method
