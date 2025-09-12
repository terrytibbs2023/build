.class public Lorg/xbmc/kodi/XBMCURIUtils;
.super Ljava/lang/Object;
.source "XBMCURIUtils.java"


# static fields
.field private static TAG:Ljava/lang/String; = "Kodi"


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method native _substitutePath(Ljava/lang/String;)Ljava/lang/String;
.end method

.method public substitutePath(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    .line 19
    :try_start_0
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCURIUtils;->_substitutePath(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    .line 23
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    .line 24
    sget-object p1, Lorg/xbmc/kodi/XBMCURIUtils;->TAG:Ljava/lang/String;

    const-string v0, "XBMCURIUtils.substitutePath: Exception"

    invoke-static {p1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 p1, 0x0

    return-object p1
.end method
