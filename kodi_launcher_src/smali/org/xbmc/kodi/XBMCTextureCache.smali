.class public Lorg/xbmc/kodi/XBMCTextureCache;
.super Ljava/lang/Object;
.source "XBMCTextureCache.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "Kodi"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method native _unwrapImageURL(Ljava/lang/String;)Ljava/lang/String;
.end method

.method public unwrapImageURL(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 23
    :try_start_0
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCTextureCache;->_unwrapImageURL(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    .line 27
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "unwrapImageURL: Exception: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "Kodi"

    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 p1, 0x0

    return-object p1
.end method
