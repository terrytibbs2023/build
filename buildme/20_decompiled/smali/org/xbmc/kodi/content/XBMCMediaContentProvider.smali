.class public Lorg/xbmc/kodi/content/XBMCMediaContentProvider;
.super Lorg/xbmc/kodi/content/XBMCContentProvider;
.source "XBMCMediaContentProvider.java"


# static fields
.field public static final AUTHORITY:Ljava/lang/String; = "org.xbmc.kodi.media"

.field private static final REFRESH_SHORTCUT:I = 0x1

.field private static final SEARCH_SUGGEST:I = 0x0

.field public static final SUGGEST_PATH:Ljava/lang/String; = "suggestions"

.field private static TAG:Ljava/lang/String; = "Kodi"

.field private static final URI_MATCHER:Landroid/content/UriMatcher;


# instance fields
.field private mJsonRPC:Lorg/xbmc/kodi/XBMCJsonRPC;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 22
    invoke-static {}, Lorg/xbmc/kodi/content/XBMCMediaContentProvider;->buildUriMatcher()Landroid/content/UriMatcher;

    move-result-object v0

    sput-object v0, Lorg/xbmc/kodi/content/XBMCMediaContentProvider;->URI_MATCHER:Landroid/content/UriMatcher;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 12
    invoke-direct {p0}, Lorg/xbmc/kodi/content/XBMCContentProvider;-><init>()V

    const/4 v0, 0x0

    .line 24
    iput-object v0, p0, Lorg/xbmc/kodi/content/XBMCMediaContentProvider;->mJsonRPC:Lorg/xbmc/kodi/XBMCJsonRPC;

    return-void
.end method

.method private static buildUriMatcher()Landroid/content/UriMatcher;
    .locals 4

    .line 28
    new-instance v0, Landroid/content/UriMatcher;

    const/4 v1, -0x1

    invoke-direct {v0, v1}, Landroid/content/UriMatcher;-><init>(I)V

    const-string v1, "org.xbmc.kodi.media"

    const-string v2, "suggestions/search_suggest_query"

    const/4 v3, 0x0

    .line 29
    invoke-virtual {v0, v1, v2, v3}, Landroid/content/UriMatcher;->addURI(Ljava/lang/String;Ljava/lang/String;I)V

    const-string v2, "suggestions/search_suggest_query/*"

    .line 30
    invoke-virtual {v0, v1, v2, v3}, Landroid/content/UriMatcher;->addURI(Ljava/lang/String;Ljava/lang/String;I)V

    return-object v0
.end method


# virtual methods
.method public delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public getType(Landroid/net/Uri;)Ljava/lang/String;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()Z
    .locals 1

    .line 58
    new-instance v0, Lorg/xbmc/kodi/XBMCJsonRPC;

    invoke-direct {v0}, Lorg/xbmc/kodi/XBMCJsonRPC;-><init>()V

    iput-object v0, p0, Lorg/xbmc/kodi/content/XBMCMediaContentProvider;->mJsonRPC:Lorg/xbmc/kodi/XBMCJsonRPC;

    const/4 v0, 0x1

    return v0
.end method

.method public query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    .locals 0

    .line 67
    sget-object p2, Lorg/xbmc/kodi/content/XBMCMediaContentProvider;->TAG:Ljava/lang/String;

    new-instance p3, Ljava/lang/StringBuilder;

    const-string p4, "XBMCMediaContentProvider.query: "

    invoke-direct {p3, p4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-static {p2, p3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 69
    sget-object p2, Lorg/xbmc/kodi/content/XBMCMediaContentProvider;->URI_MATCHER:Landroid/content/UriMatcher;

    invoke-virtual {p2, p1}, Landroid/content/UriMatcher;->match(Landroid/net/Uri;)I

    move-result p2

    if-nez p2, :cond_0

    .line 72
    invoke-virtual {p1}, Landroid/net/Uri;->getLastPathSegment()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p2

    :try_start_0
    const-string p3, "limit"

    .line 75
    invoke-virtual {p1, p3}, Landroid/net/Uri;->getQueryParameter(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/16 p1, 0xa

    .line 77
    :goto_0
    iget-object p3, p0, Lorg/xbmc/kodi/content/XBMCMediaContentProvider;->mJsonRPC:Lorg/xbmc/kodi/XBMCJsonRPC;

    invoke-virtual {p3, p2, p1}, Lorg/xbmc/kodi/XBMCJsonRPC;->getSuggestions(Ljava/lang/String;I)Landroid/database/Cursor;

    move-result-object p1

    return-object p1

    .line 80
    :cond_0
    new-instance p2, Ljava/lang/IllegalArgumentException;

    new-instance p3, Ljava/lang/StringBuilder;

    const-string p4, "Unknown Uri: "

    invoke-direct {p3, p4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p2
.end method

.method public update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method
