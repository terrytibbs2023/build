.class public Lorg/xbmc/kodi/XBMCJsonRPC;
.super Ljava/lang/Object;
.source "XBMCJsonRPC.java"


# static fields
.field public static final APP_NAME:Ljava/lang/String; = "Kodi Search"

.field public static final COLUMN_BASE_PATH:Ljava/lang/String; = "COLUMN_BASE_PATH"

.field public static final COLUMN_FANART:Ljava/lang/String; = "COLUMN_FANART"

.field public static final COLUMN_FILENAME:Ljava/lang/String; = "COLUMN_FILENAME"

.field public static final COLUMN_FULL_PATH:Ljava/lang/String; = "COLUMN_FULL_PATH"

.field public static final COLUMN_ID:Ljava/lang/String; = "COLUMN_ID"

.field public static final COLUMN_RECOMMENDATION_REASON:Ljava/lang/String; = "COLUMN_RECOMMENDATION_REASON"

.field public static final COLUMN_TAGLINE:Ljava/lang/String; = "COLUMN_TAGLINE"

.field public static final COLUMN_THUMB:Ljava/lang/String; = "COLUMN_THUMB"

.field public static final COLUMN_TITLE:Ljava/lang/String; = "COLUMN_TITLE"

.field public static final COLUMN_VIEW_PROGRESS:Ljava/lang/String; = "COLUMN_VIEW_PROGRESS"

.field private static final MAX_ITEMS:I = 0x14

.field public static final REQ_ID_ALBUMS:Ljava/lang/String; = "3"

.field public static final REQ_ID_ARTISTS:Ljava/lang/String; = "4"

.field public static final REQ_ID_MOVIES:Ljava/lang/String; = "1"

.field public static final REQ_ID_MOVIES_ACTOR:Ljava/lang/String; = "5"

.field public static final REQ_ID_SHOWS:Ljava/lang/String; = "2"

.field public static final REQ_ID_SHOWS_ACTOR:Ljava/lang/String; = "6"

.field private static TAG:Ljava/lang/String; = "Kodi"


# instance fields
.field private GET_VERSION:Ljava/lang/String;

.field private MAX_RECOMMENDATIONS:I

.field private RECOMMENDATIONS_ALBUMS_JSON:Ljava/lang/String;

.field private RECOMMENDATIONS_SHOWS_JSON:Ljava/lang/String;

.field private RECOMMENDATION_MOVIES_JSON:Ljava/lang/String;

.field private RETRIEVE_ALBUM_DETAILS:Ljava/lang/String;

.field private RETRIEVE_EPISODE_DETAILS:Ljava/lang/String;

.field private RETRIEVE_FILE_ITEMS:Ljava/lang/String;

.field private RETRIEVE_MOVIE_DETAILS:Ljava/lang/String;

.field private RETRIEVE_MUSICVIDEO_DETAILS:Ljava/lang/String;

.field private RETRIEVE_SONG_DETAILS:Ljava/lang/String;

.field private RETRIEVE_TVSHOW_DETAILS:Ljava/lang/String;

.field private SEARCH_ALBUMS_JSON:Ljava/lang/String;

.field private SEARCH_ARTISTS_JSON:Ljava/lang/String;

.field private SEARCH_MOVIES_JSON:Ljava/lang/String;

.field private SEARCH_SHOWS_JSON:Ljava/lang/String;

.field private mNotificationManager:Landroid/app/NotificationManager;

.field private mRecomendationIds:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private mTextureCache:Lorg/xbmc/kodi/XBMCTextureCache;

.field private m_xbmc_web_url:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .line 127
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "http://localhost:8080"

    .line 64
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->m_xbmc_web_url:Ljava/lang/String;

    .line 65
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->mRecomendationIds:Ljava/util/HashSet;

    const/4 v0, 0x0

    .line 66
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->mTextureCache:Lorg/xbmc/kodi/XBMCTextureCache;

    const/4 v0, 0x3

    .line 68
    iput v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->MAX_RECOMMENDATIONS:I

    const-string v0, "{ \"jsonrpc\": \"2.0\", \"method\": \"JSONRPC.Version\", \"id\": 1 }"

    .line 70
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->GET_VERSION:Ljava/lang/String;

    const-string v0, "{\"jsonrpc\": \"2.0\", \"method\": \"VideoLibrary.GetMovies\", \"params\": { \"filter\": {\"field\": \"playcount\", \"operator\": \"is\", \"value\": \"0\"}, \"limits\": { \"start\" : 0, \"end\": 10}, \"properties\" : [\"imdbnumber\", \"title\", \"tagline\", \"art\", \"year\", \"runtime\", \"file\", \"plot\", \"rating\"], \"sort\": { \"order\": \"descending\", \"method\": \"random\", \"ignorearticle\": true } }, \"id\": \"1\"}"

    .line 72
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->RECOMMENDATION_MOVIES_JSON:Ljava/lang/String;

    const-string v0, "{\"jsonrpc\":\"2.0\",\"method\":\"VideoLibrary.GetTVShows\",\"params\":{\"filter\":{\"and\":[{\"field\":\"playcount\",\"operator\":\"is\",\"value\":\"0\"},{\"field\":\"plot\",\"operator\":\"isnot\",\"value\":\"\"}]},\"limits\":{\"start\":0,\"end\":10},\"properties\":[\"imdbnumber\",\"title\",\"plot\",\"art\",\"studio\", \"year\", \"rating\"],\"sort\":{\"order\":\"descending\",\"method\":\"lastplayed\",\"ignorearticle\":true}},\"id\":\"1\"}"

    .line 80
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->RECOMMENDATIONS_SHOWS_JSON:Ljava/lang/String;

    const-string v0, "{\"jsonrpc\": \"2.0\", \"method\": \"AudioLibrary.GetAlbums\", \"params\": { \"limits\": { \"start\" : 0, \"end\": 3}, \"properties\" : [\"title\", \"displayartist\", \"art\"], \"sort\": { \"order\": \"descending\", \"method\": \"random\", \"ignorearticle\": true } }, \"id\": \"1\"}"

    .line 83
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->RECOMMENDATIONS_ALBUMS_JSON:Ljava/lang/String;

    const-string v0, "{\"jsonrpc\": \"2.0\", \"method\": \"VideoLibrary.GetMovies\", \"params\": { \"filter\": {%s}, \"limits\": { \"start\" : 0, \"end\": 10}, \"properties\" : [\"imdbnumber\", \"title\", \"tagline\", \"art\", \"year\", \"runtime\"], \"sort\": { \"order\": \"ascending\", \"method\": \"title\", \"ignorearticle\": true } }, \"id\": \"%s\"}"

    .line 86
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->SEARCH_MOVIES_JSON:Ljava/lang/String;

    const-string v0, "{\"jsonrpc\":\"2.0\",\"method\":\"VideoLibrary.GetTVShows\",\"params\":{\"filter\":{%s},\"limits\":{\"start\":0,\"end\":10},\"properties\":[\"imdbnumber\",\"title\",\"plot\",\"art\",\"year\"],\"sort\":{\"order\":\"descending\",\"method\":\"lastplayed\",\"ignorearticle\":true}},\"id\":\"%s\"}"

    .line 94
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->SEARCH_SHOWS_JSON:Ljava/lang/String;

    const-string v0, "{\"jsonrpc\": \"2.0\", \"method\": \"AudioLibrary.GetAlbums\", \"params\": {\"filter\":{%s},\"limits\": { \"start\" : 0, \"end\": 10}, \"properties\" : [\"title\", \"displayartist\", \"art\"], \"sort\": { \"order\": \"descending\", \"method\": \"dateadded\", \"ignorearticle\": true } }, \"id\": \"%s\"}"

    .line 97
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->SEARCH_ALBUMS_JSON:Ljava/lang/String;

    const-string v0, "{\"jsonrpc\": \"2.0\", \"method\": \"AudioLibrary.GetArtists\", \"params\": {\"filter\":{%s},\"limits\": { \"start\" : 0, \"end\": 10}, \"properties\" : [\"description\", \"art\"], \"sort\": { \"order\": \"descending\", \"method\": \"dateadded\", \"ignorearticle\": true } }, \"id\": \"%s\"}"

    .line 100
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->SEARCH_ARTISTS_JSON:Ljava/lang/String;

    const-string v0, "{ \"jsonrpc\": \"2.0\", \"method\": \"VideoLibrary.GetMovieDetails\", \"params\": { \"movieid\" : %s, \"properties\" : [\"imdbnumber\", \"title\", \"tagline\", \"art\", \"year\", \"runtime\", \"file\", \"plot\", \"trailer\", \"rating\"] }, \"id\": \"%s\" }"

    .line 103
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->RETRIEVE_MOVIE_DETAILS:Ljava/lang/String;

    const-string v0, "{ \"jsonrpc\": \"2.0\", \"method\": \"VideoLibrary.GetEpisodeDetails\", \"params\": { \"episodeid\" : %s, \"properties\" : [\"title\", \"tvshowid\", \"showtitle\", \"season\", \"episode\", \"art\", \"file\", \"plot\", \"rating\", \"runtime\", \"firstaired\"] }, \"id\": \"%s\" }"

    .line 106
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->RETRIEVE_EPISODE_DETAILS:Ljava/lang/String;

    const-string v0, "{ \"jsonrpc\": \"2.0\", \"method\": \"VideoLibrary.GetTVShowDetails\", \"params\": { \"tvshowid\" : %s, \"properties\" : [\"title\", \"studio\", \"art\", \"plot\", \"year\", \"rating\"] }, \"id\": \"%s\" }"

    .line 109
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->RETRIEVE_TVSHOW_DETAILS:Ljava/lang/String;

    const-string v0, "{ \"jsonrpc\": \"2.0\", \"method\": \"AudioLibrary.GetAlbumDetails\", \"params\": { \"albumid\" : %s, \"properties\" : [\"title\", \"displayartist\", \"art\",  \"artistid\"] }, \"id\": \"%s\" }"

    .line 112
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->RETRIEVE_ALBUM_DETAILS:Ljava/lang/String;

    const-string v0, "{ \"jsonrpc\": \"2.0\", \"method\": \"AudioLibrary.GetSongDetails\", \"params\": { \"songid\" : %s, \"properties\" : [\"title\", \"displayartist\", \"art\", \"albumid\", \"artistid\", \"file\"] }, \"id\": \"%s\" }"

    .line 115
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->RETRIEVE_SONG_DETAILS:Ljava/lang/String;

    const-string v0, "{ \"jsonrpc\": \"2.0\", \"method\": \"VideoLibrary.GetMusicVideoDetails\", \"params\": { \"musicvideoid\" : %s, \"properties\" : [\"title\", \"artist\", \"art\", \"file\"] }, \"id\": \"%s\" }"

    .line 118
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->RETRIEVE_MUSICVIDEO_DETAILS:Ljava/lang/String;

    const-string v0, "{ \"jsonrpc\": \"2.0\", \"method\": \"Files.GetDirectory\", \"params\": { \"directory\" : \"%s\" }, \"id\": \"%s\" }"

    .line 121
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->RETRIEVE_FILE_ITEMS:Ljava/lang/String;

    const-string v0, "xbmc.jsonPort"

    const-string v1, "8080"

    .line 128
    invoke-static {v0, v1}, Lorg/xbmc/kodi/XBMCProperties;->getStringProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 129
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "http://localhost:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->m_xbmc_web_url:Ljava/lang/String;

    .line 130
    new-instance v0, Lorg/xbmc/kodi/XBMCTextureCache;

    invoke-direct {v0}, Lorg/xbmc/kodi/XBMCTextureCache;-><init>()V

    iput-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->mTextureCache:Lorg/xbmc/kodi/XBMCTextureCache;

    return-void
.end method

.method private buildPendingAlbumIntent(Landroid/content/Context;Lcom/google/gson/JsonObject;)Landroid/app/PendingIntent;
    .locals 3

    const-string v0, "musicdb://albums/"

    .line 808
    :try_start_0
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lorg/xbmc/kodi/Splash;

    invoke-direct {v1, p1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v2, "android.intent.action.GET_CONTENT"

    .line 809
    invoke-virtual {v1, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 810
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v0, "albumid"

    invoke-virtual {p2, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object p2

    invoke-virtual {p2}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "/"

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p2

    invoke-virtual {v1, p2}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    const/4 p2, 0x0

    const/high16 v0, 0x14000000

    .line 812
    invoke-static {p1, p2, v1, v0}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    .line 815
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    const/4 p1, 0x0

    return-object p1
.end method

.method private buildPendingMovieIntent(Landroid/content/Context;Lcom/google/gson/JsonObject;)Landroid/app/PendingIntent;
    .locals 3

    const-string v0, "videodb://movies/titles/"

    .line 774
    :try_start_0
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lorg/xbmc/kodi/Splash;

    invoke-direct {v1, p1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v2, "android.intent.action.VIEW"

    .line 775
    invoke-virtual {v1, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 776
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v0, "movieid"

    invoke-virtual {p2, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object p2

    invoke-virtual {p2}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "?showinfo=true"

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p2

    invoke-virtual {v1, p2}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    const/4 p2, 0x0

    const/high16 v0, 0x14000000

    .line 780
    invoke-static {p1, p2, v1, v0}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    .line 783
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    const/4 p1, 0x0

    return-object p1
.end method

.method private buildPendingShowIntent(Landroid/content/Context;Lcom/google/gson/JsonObject;)Landroid/app/PendingIntent;
    .locals 3

    const-string v0, "videodb://tvshows/titles/"

    .line 792
    :try_start_0
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lorg/xbmc/kodi/Splash;

    invoke-direct {v1, p1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v2, "android.intent.action.GET_CONTENT"

    .line 793
    invoke-virtual {v1, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 794
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v0, "tvshowid"

    invoke-virtual {p2, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object p2

    invoke-virtual {p2}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "/"

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p2

    invoke-virtual {v1, p2}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    const/4 p2, 0x0

    const/high16 v0, 0x14000000

    .line 796
    invoke-static {p1, p2, v1, v0}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    .line 799
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    const/4 p1, 0x0

    return-object p1
.end method

.method private convertRating(Ljava/lang/Double;)Ljava/lang/String;
    .locals 5

    if-eqz p1, :cond_1

    .line 1437
    invoke-virtual {p1}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmpg-double v4, v0, v2

    if-gtz v4, :cond_0

    goto :goto_0

    .line 1440
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Double;->doubleValue()D

    move-result-wide v0

    const-wide/high16 v2, 0x4000000000000000L    # 2.0

    div-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_1
    :goto_0
    const/4 p1, 0x0

    return-object p1
.end method

.method private createAlbumFromJson(Lcom/google/gson/JsonObject;)Lorg/xbmc/kodi/model/Album;
    .locals 5

    const-string v0, "albumid"

    const-string v1, "musicdb://albums/"

    .line 1022
    new-instance v2, Lorg/xbmc/kodi/model/Album;

    invoke-direct {v2}, Lorg/xbmc/kodi/model/Album;-><init>()V

    .line 1026
    :try_start_0
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v3

    int-to-long v3, v3

    invoke-virtual {v2, v3, v4}, Lorg/xbmc/kodi/model/Album;->setId(J)V

    const-string v3, "title"

    .line 1027
    invoke-virtual {p1, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/Album;->setTitle(Ljava/lang/String;)V

    const-string v3, "displayartist"

    .line 1028
    invoke-virtual {p1, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/Album;->setDescription(Ljava/lang/String;)V

    const-string v3, "thumb"

    .line 1031
    invoke-direct {p0, p1, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 1032
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_0

    .line 1034
    invoke-direct {p0, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/Album;->setCardImageUrl(Ljava/lang/String;)V

    const-string v3, "1:1"

    .line 1035
    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/Album;->setCardImageAspectRatio(Ljava/lang/String;)V

    :cond_0
    const-string v3, "fanart"

    .line 1038
    invoke-direct {p0, p1, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1

    .line 1039
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_1

    .line 1041
    invoke-direct {p0, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/Album;->setBackgroundImageUrl(Ljava/lang/String;)V

    .line 1044
    :cond_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "/"

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Lorg/xbmc/kodi/model/Album;->setXbmcUrl(Ljava/lang/String;)V

    const-string p1, "album"

    .line 1045
    invoke-virtual {v2, p1}, Lorg/xbmc/kodi/model/Album;->setCategory(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method private createMovieFromJson(Lcom/google/gson/JsonObject;)Lorg/xbmc/kodi/model/Movie;
    .locals 5

    const-string v0, "movieid"

    const-string v1, "videodb://movies/titles/"

    .line 858
    new-instance v2, Lorg/xbmc/kodi/model/Movie;

    invoke-direct {v2}, Lorg/xbmc/kodi/model/Movie;-><init>()V

    .line 862
    :try_start_0
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v3

    int-to-long v3, v3

    invoke-virtual {v2, v3, v4}, Lorg/xbmc/kodi/model/Movie;->setId(J)V

    const-string v3, "title"

    .line 863
    invoke-virtual {p1, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/Movie;->setTitle(Ljava/lang/String;)V

    const-string v3, "plot"

    .line 864
    invoke-virtual {p1, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/Movie;->setDescription(Ljava/lang/String;)V

    const-string v3, "poster"

    .line 866
    invoke-direct {p0, p1, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 867
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_0

    .line 869
    invoke-direct {p0, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/Movie;->setCardImageUrl(Ljava/lang/String;)V

    const-string v3, "2:3"

    .line 870
    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/Movie;->setCardImageAspectRatio(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    const-string v3, "thumb"

    .line 875
    invoke-direct {p0, p1, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1

    .line 876
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_1

    .line 878
    invoke-direct {p0, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/Movie;->setCardImageUrl(Ljava/lang/String;)V

    const-string v3, "16:9"

    .line 879
    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/Movie;->setCardImageAspectRatio(Ljava/lang/String;)V

    :cond_1
    :goto_0
    const-string v3, "fanart"

    .line 883
    invoke-direct {p0, p1, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_2

    .line 884
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_2

    .line 886
    invoke-direct {p0, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/Movie;->setBackgroundImageUrl(Ljava/lang/String;)V

    .line 889
    :cond_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "?showinfo=true"

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Lorg/xbmc/kodi/model/Movie;->setXbmcUrl(Ljava/lang/String;)V

    const-string v0, "movie"

    .line 912
    invoke-virtual {v2, v0}, Lorg/xbmc/kodi/model/Movie;->setCategory(Ljava/lang/String;)V

    const-string v0, "year"

    .line 914
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Lorg/xbmc/kodi/model/Movie;->setYear(Ljava/lang/String;)V

    const-string v0, "rating"

    .line 915
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsDouble()D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v0

    invoke-direct {p0, v0}, Lorg/xbmc/kodi/XBMCJsonRPC;->convertRating(Ljava/lang/Double;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Lorg/xbmc/kodi/model/Movie;->setRating(Ljava/lang/String;)V

    const-string v0, "runtime"

    .line 916
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result p1

    mul-int/lit16 p1, p1, 0x3e8

    invoke-virtual {v2, p1}, Lorg/xbmc/kodi/model/Movie;->setDuration(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method private createMusicvideoFromJson(Lcom/google/gson/JsonObject;)Lorg/xbmc/kodi/model/MusicVideo;
    .locals 5

    const-string v0, "musicvideoid"

    const-string v1, "videodb://musicvideos/titles/"

    .line 1137
    new-instance v2, Lorg/xbmc/kodi/model/MusicVideo;

    invoke-direct {v2}, Lorg/xbmc/kodi/model/MusicVideo;-><init>()V

    .line 1141
    :try_start_0
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v3

    int-to-long v3, v3

    invoke-virtual {v2, v3, v4}, Lorg/xbmc/kodi/model/MusicVideo;->setId(J)V

    const-string v3, "title"

    .line 1142
    invoke-virtual {p1, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/MusicVideo;->setTitle(Ljava/lang/String;)V

    const-string v3, "artist"

    .line 1143
    invoke-virtual {p1, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsJsonArray()Lcom/google/gson/JsonArray;

    move-result-object v3

    .line 1144
    invoke-virtual {v3}, Lcom/google/gson/JsonArray;->size()I

    move-result v4

    if-lez v4, :cond_0

    const/4 v4, 0x0

    .line 1145
    invoke-virtual {v3, v4}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/MusicVideo;->setDescription(Ljava/lang/String;)V

    :cond_0
    const-string v3, "thumb"

    .line 1147
    invoke-direct {p0, p1, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1

    .line 1148
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_1

    .line 1150
    invoke-direct {p0, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/MusicVideo;->setCardImageUrl(Ljava/lang/String;)V

    const-string v3, "1:1"

    .line 1151
    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/MusicVideo;->setCardImageAspectRatio(Ljava/lang/String;)V

    :cond_1
    const-string v3, "fanart"

    .line 1154
    invoke-direct {p0, p1, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_2

    .line 1155
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_2

    .line 1157
    invoke-direct {p0, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/MusicVideo;->setBackgroundImageUrl(Ljava/lang/String;)V

    .line 1160
    :cond_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Lorg/xbmc/kodi/model/MusicVideo;->setXbmcUrl(Ljava/lang/String;)V

    const-string v0, "file"

    .line 1162
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCJsonRPC;->getDownloadUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_3

    .line 1163
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_3

    .line 1164
    invoke-direct {p0, p1}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Lorg/xbmc/kodi/model/MusicVideo;->setVideoUrl(Ljava/lang/String;)V

    :cond_3
    const-string p1, "musicvideo"

    .line 1166
    invoke-virtual {v2, p1}, Lorg/xbmc/kodi/model/MusicVideo;->setCategory(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method private createSongFromJson(Lcom/google/gson/JsonObject;)Lorg/xbmc/kodi/model/Song;
    .locals 9

    const-string v0, "albumid"

    const-string v1, "file"

    const-string v2, "songid"

    const-string v3, "musicdb://albums/"

    const-string v4, "musicdb://songs/"

    .line 1057
    new-instance v5, Lorg/xbmc/kodi/model/Song;

    invoke-direct {v5}, Lorg/xbmc/kodi/model/Song;-><init>()V

    .line 1061
    :try_start_0
    invoke-virtual {p1, v2}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v6

    invoke-virtual {v6}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v6

    int-to-long v6, v6

    invoke-virtual {v5, v6, v7}, Lorg/xbmc/kodi/model/Song;->setId(J)V

    const-string v6, "title"

    .line 1062
    invoke-virtual {p1, v6}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v6

    invoke-virtual {v6}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lorg/xbmc/kodi/model/Song;->setTitle(Ljava/lang/String;)V

    const-string v6, "displayartist"

    .line 1063
    invoke-virtual {p1, v6}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v6

    invoke-virtual {v6}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lorg/xbmc/kodi/model/Song;->setDescription(Ljava/lang/String;)V

    const-string v6, "album.thumb"

    .line 1066
    invoke-direct {p0, p1, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v7, "1:1"

    if-eqz v6, :cond_0

    .line 1067
    :try_start_1
    invoke-virtual {v6}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_0

    .line 1069
    invoke-direct {p0, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lorg/xbmc/kodi/model/Song;->setCardImageUrl(Ljava/lang/String;)V

    .line 1070
    invoke-virtual {v5, v7}, Lorg/xbmc/kodi/model/Song;->setCardImageAspectRatio(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    const-string v6, "albumartist.thumb"

    .line 1075
    invoke-direct {p0, p1, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    if-eqz v6, :cond_1

    .line 1076
    invoke-virtual {v6}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_1

    .line 1078
    invoke-direct {p0, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lorg/xbmc/kodi/model/Song;->setCardImageUrl(Ljava/lang/String;)V

    .line 1079
    invoke-virtual {v5, v7}, Lorg/xbmc/kodi/model/Song;->setCardImageAspectRatio(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    const-string v6, "artist.thumb"

    .line 1084
    invoke-direct {p0, p1, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    if-eqz v6, :cond_2

    .line 1085
    invoke-virtual {v6}, Ljava/lang/String;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_2

    .line 1087
    invoke-direct {p0, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lorg/xbmc/kodi/model/Song;->setCardImageUrl(Ljava/lang/String;)V

    .line 1088
    invoke-virtual {v5, v7}, Lorg/xbmc/kodi/model/Song;->setCardImageAspectRatio(Ljava/lang/String;)V

    :cond_2
    :goto_0
    const-string v6, "albumartist.fanart"

    .line 1093
    invoke-direct {p0, p1, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    if-eqz v6, :cond_3

    .line 1094
    invoke-virtual {v6}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_3

    .line 1096
    invoke-direct {p0, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lorg/xbmc/kodi/model/Song;->setBackgroundImageUrl(Ljava/lang/String;)V

    goto :goto_1

    :cond_3
    const-string v6, "artist.fanart"

    .line 1100
    invoke-direct {p0, p1, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    if-eqz v6, :cond_4

    .line 1101
    invoke-virtual {v6}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_4

    .line 1103
    invoke-direct {p0, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lorg/xbmc/kodi/model/Song;->setBackgroundImageUrl(Ljava/lang/String;)V

    :cond_4
    :goto_1
    const-string v6, ""

    .line 1108
    invoke-virtual {p1, v1}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_5

    invoke-virtual {p1, v1}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v7

    invoke-virtual {v7}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_5

    .line 1110
    invoke-virtual {p1, v1}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v1

    const-string v6, "."

    .line 1111
    invoke-virtual {v1, v6}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v6

    invoke-virtual {v1, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v6

    .line 1114
    :cond_5
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_6

    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_6

    .line 1115
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "/"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, v2}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v5, p1}, Lorg/xbmc/kodi/model/Song;->setXbmcUrl(Ljava/lang/String;)V

    goto :goto_2

    .line 1117
    :cond_6
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v2}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v5, p1}, Lorg/xbmc/kodi/model/Song;->setXbmcUrl(Ljava/lang/String;)V

    :goto_2
    const-string p1, "song"

    .line 1125
    invoke-virtual {v5, p1}, Lorg/xbmc/kodi/model/Song;->setCategory(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    return-object v5

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method private createTVEpisodeFromJson(Lcom/google/gson/JsonObject;)Lorg/xbmc/kodi/model/TVEpisode;
    .locals 6

    const-string v0, "episode"

    const-string v1, "episodeid"

    const-string v2, "videodb://tvshows/titles/"

    .line 975
    new-instance v3, Lorg/xbmc/kodi/model/TVEpisode;

    invoke-direct {v3}, Lorg/xbmc/kodi/model/TVEpisode;-><init>()V

    .line 979
    :try_start_0
    invoke-virtual {p1, v1}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v4

    invoke-virtual {v4}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v4

    int-to-long v4, v4

    invoke-virtual {v3, v4, v5}, Lorg/xbmc/kodi/model/TVEpisode;->setId(J)V

    const-string v4, "title"

    .line 980
    invoke-virtual {p1, v4}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v4

    invoke-virtual {v4}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lorg/xbmc/kodi/model/TVEpisode;->setTitle(Ljava/lang/String;)V

    const-string v4, "plot"

    .line 981
    invoke-virtual {p1, v4}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v4

    invoke-virtual {v4}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lorg/xbmc/kodi/model/TVEpisode;->setDescription(Ljava/lang/String;)V

    const-string v4, "thumb"

    .line 984
    invoke-direct {p0, p1, v4}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_0

    .line 985
    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_0

    .line 987
    invoke-direct {p0, v4}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lorg/xbmc/kodi/model/TVEpisode;->setCardImageUrl(Ljava/lang/String;)V

    const-string v4, "16:9"

    .line 988
    invoke-virtual {v3, v4}, Lorg/xbmc/kodi/model/TVEpisode;->setCardImageAspectRatio(Ljava/lang/String;)V

    :cond_0
    const-string v4, "fanart"

    .line 991
    invoke-direct {p0, p1, v4}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_1

    .line 992
    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_1

    .line 994
    invoke-direct {p0, v4}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lorg/xbmc/kodi/model/TVEpisode;->setBackgroundImageUrl(Ljava/lang/String;)V

    .line 997
    :cond_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v2, "tvshowid"

    invoke-virtual {p1, v2}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v2

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, "/"

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, v1}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v1

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "?showinfo=true"

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Lorg/xbmc/kodi/model/TVEpisode;->setXbmcUrl(Ljava/lang/String;)V

    .line 1003
    invoke-virtual {v3, v0}, Lorg/xbmc/kodi/model/TVEpisode;->setCategory(Ljava/lang/String;)V

    const-string v1, "showtitle"

    .line 1005
    invoke-virtual {p1, v1}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Lorg/xbmc/kodi/model/TVEpisode;->setShowTitle(Ljava/lang/String;)V

    const-string v1, "season"

    .line 1006
    invoke-virtual {p1, v1}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v1

    invoke-virtual {v3, v1}, Lorg/xbmc/kodi/model/TVEpisode;->setSeason(I)V

    .line 1007
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v0

    invoke-virtual {v3, v0}, Lorg/xbmc/kodi/model/TVEpisode;->setEpisode(I)V

    const-string v0, "rating"

    .line 1008
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsDouble()D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v0

    invoke-direct {p0, v0}, Lorg/xbmc/kodi/XBMCJsonRPC;->convertRating(Ljava/lang/Double;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lorg/xbmc/kodi/model/TVEpisode;->setRating(Ljava/lang/String;)V

    const-string v0, "runtime"

    .line 1009
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v0

    mul-int/lit16 v0, v0, 0x3e8

    invoke-virtual {v3, v0}, Lorg/xbmc/kodi/model/TVEpisode;->setDuration(I)V

    const-string v0, "firstaired"

    .line 1010
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v3, p1}, Lorg/xbmc/kodi/model/TVEpisode;->setFirstaired(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v3

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method private createTVShowFromJson(Lcom/google/gson/JsonObject;)Lorg/xbmc/kodi/model/TVShow;
    .locals 5

    const-string v0, "tvshowid"

    const-string v1, "videodb://tvshows/titles/"

    .line 928
    new-instance v2, Lorg/xbmc/kodi/model/TVShow;

    invoke-direct {v2}, Lorg/xbmc/kodi/model/TVShow;-><init>()V

    .line 932
    :try_start_0
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v3

    int-to-long v3, v3

    invoke-virtual {v2, v3, v4}, Lorg/xbmc/kodi/model/TVShow;->setId(J)V

    const-string v3, "title"

    .line 933
    invoke-virtual {p1, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/TVShow;->setTitle(Ljava/lang/String;)V

    const-string v3, "plot"

    .line 934
    invoke-virtual {p1, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/TVShow;->setDescription(Ljava/lang/String;)V

    const-string v3, "poster"

    .line 937
    invoke-direct {p0, p1, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 938
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_0

    .line 940
    invoke-direct {p0, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/TVShow;->setCardImageUrl(Ljava/lang/String;)V

    const-string v3, "2:3"

    .line 941
    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/TVShow;->setCardImageAspectRatio(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    const-string v3, "thumb"

    .line 946
    invoke-direct {p0, p1, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1

    .line 947
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_1

    .line 949
    invoke-direct {p0, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/TVShow;->setCardImageUrl(Ljava/lang/String;)V

    const-string v3, "16:9"

    .line 950
    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/TVShow;->setCardImageAspectRatio(Ljava/lang/String;)V

    :cond_1
    :goto_0
    const-string v3, "fanart"

    .line 954
    invoke-direct {p0, p1, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_2

    .line 955
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_2

    .line 957
    invoke-direct {p0, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->getImageUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lorg/xbmc/kodi/model/TVShow;->setBackgroundImageUrl(Ljava/lang/String;)V

    .line 959
    :cond_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, "/"

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Lorg/xbmc/kodi/model/TVShow;->setXbmcUrl(Ljava/lang/String;)V

    const-string v0, "tvshow"

    .line 960
    invoke-virtual {v2, v0}, Lorg/xbmc/kodi/model/TVShow;->setCategory(Ljava/lang/String;)V

    const-string v0, "year"

    .line 962
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Lorg/xbmc/kodi/model/TVShow;->setYear(Ljava/lang/String;)V

    const-string v0, "rating"

    .line 963
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/gson/JsonElement;->getAsDouble()D

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p1

    invoke-direct {p0, p1}, Lorg/xbmc/kodi/XBMCJsonRPC;->convertRating(Ljava/lang/Double;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Lorg/xbmc/kodi/model/TVShow;->setRating(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method private extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    const-string v0, "art"

    .line 1426
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/gson/JsonObject;->isJsonNull()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1427
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v1

    invoke-virtual {v1, p2}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1428
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v1

    invoke-virtual {v1, p2}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1430
    invoke-virtual {p1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCJsonRPC;->getDownloadUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method private getImageUrl(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .line 1445
    sget-object v0, Lorg/xbmc/kodi/XBMCJsonRPC;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "getImageUrl: sUrl = "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "image://video@"

    .line 1446
    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "image://music@"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 1452
    :cond_0
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->mTextureCache:Lorg/xbmc/kodi/XBMCTextureCache;

    invoke-virtual {v0, p1}, Lorg/xbmc/kodi/XBMCTextureCache;->unwrapImageURL(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1453
    sget-object v1, Lorg/xbmc/kodi/XBMCJsonRPC;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "getImageUrl: sUnwrapImageUrl = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v1, "http"

    .line 1454
    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 1456
    invoke-static {p1}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    invoke-virtual {p1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_1
    return-object v0

    .line 1448
    :cond_2
    :goto_0
    sget-object v0, Lorg/xbmc/kodi/XBMCJsonRPC;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "getImageUrl: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " is not unwrapped"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1449
    invoke-static {p1}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    invoke-virtual {p1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public Ping()Z
    .locals 3

    const/4 v0, 0x0

    .line 214
    :try_start_0
    iget-object v1, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->GET_VERSION:Ljava/lang/String;

    invoke-virtual {p0, v1}, Lorg/xbmc/kodi/XBMCJsonRPC;->request_object(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v1

    if-eqz v1, :cond_1

    const-string v2, "result"

    .line 215
    invoke-virtual {v1, v2}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    :catch_0
    :cond_1
    :goto_0
    return v0
.end method

.method native _requestJSON(Ljava/lang/String;)Ljava/lang/String;
.end method

.method public getBitmap(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/Bitmap;
    .locals 0

    .line 192
    :try_start_0
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    .line 193
    invoke-static {p2}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object p1

    .line 194
    invoke-static {p1}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object p2

    .line 195
    invoke-virtual {p1}, Ljava/io/InputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p2

    :catch_0
    move-exception p1

    .line 200
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    const/4 p1, 0x0

    return-object p1
.end method

.method public getDownloadUrl(Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    return-object p1
.end method

.method public getFiles(Ljava/lang/String;)Ljava/util/List;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lorg/xbmc/kodi/model/File;",
            ">;"
        }
    .end annotation

    const-string v0, "id"

    const-string v1, "files"

    const-string v2, "result"

    const-string v3, "type"

    .line 822
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 826
    :try_start_0
    iget-object v5, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->RETRIEVE_FILE_ITEMS:Ljava/lang/String;

    const/4 v6, 0x2

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object p1, v6, v7

    const-string p1, "1"

    const/4 v8, 0x1

    aput-object p1, v6, v8

    invoke-static {v5, v6}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCJsonRPC;->request_object(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object p1

    if-eqz p1, :cond_4

    .line 828
    invoke-virtual {p1, v2}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_0

    goto/16 :goto_1

    .line 831
    :cond_0
    invoke-virtual {p1, v2}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object p1

    .line 832
    invoke-virtual {p1, v1}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    return-object v4

    .line 835
    :cond_1
    invoke-virtual {p1, v1}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/gson/JsonElement;->getAsJsonArray()Lcom/google/gson/JsonArray;

    move-result-object p1

    .line 837
    :goto_0
    invoke-virtual {p1}, Lcom/google/gson/JsonArray;->size()I

    move-result v1

    if-ge v7, v1, :cond_5

    .line 839
    invoke-virtual {p1, v7}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v1

    const-string v2, "file"

    .line 840
    invoke-virtual {v1, v2}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    const-string v5, "label"

    .line 841
    invoke-virtual {v1, v5}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v5

    invoke-virtual {v5}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v5

    const-string v6, "filetype"

    invoke-virtual {v1, v6}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v6

    invoke-virtual {v6}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v2}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v5, v6, v2}, Lorg/xbmc/kodi/model/File;->createFile(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xbmc/kodi/model/File;

    move-result-object v2

    .line 842
    invoke-virtual {v1, v0}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 843
    invoke-virtual {v1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v5

    invoke-virtual {v5}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v5

    int-to-long v5, v5

    invoke-virtual {v2, v5, v6}, Lorg/xbmc/kodi/model/File;->setId(J)V

    .line 844
    :cond_2
    invoke-virtual {v1, v3}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-virtual {v1, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v5

    invoke-virtual {v5}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v5

    const-string v6, "unknown"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_3

    .line 845
    invoke-virtual {v1, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Lorg/xbmc/kodi/model/File;->setMediatype(Ljava/lang/String;)V

    .line 846
    :cond_3
    invoke-interface {v4, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    :cond_4
    :goto_1
    return-object v4

    :catch_0
    move-exception p1

    .line 850
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_5
    return-object v4
.end method

.method public getMedias(Ljava/util/List;)Ljava/util/List;
    .locals 19
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lorg/xbmc/kodi/model/File;",
            ">;)",
            "Ljava/util/List<",
            "Lorg/xbmc/kodi/model/Media;",
            ">;"
        }
    .end annotation

    move-object/from16 v1, p0

    move-object/from16 v0, p1

    const-string v2, "result"

    .line 1325
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    :try_start_0
    const-string v4, "["

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    .line 1331
    :cond_0
    :goto_0
    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v8
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v9, "musicvideo"

    const-string v10, "song"

    const-string v11, "album"

    const-string v12, "tvshow"

    const-string v13, "episode"

    const-string v14, "movie"

    if-ge v6, v8, :cond_7

    const/16 v8, 0x14

    if-ge v7, v8, :cond_7

    .line 1333
    :try_start_1
    invoke-interface {v0, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Lorg/xbmc/kodi/model/File;

    .line 1334
    invoke-virtual {v15}, Lorg/xbmc/kodi/model/File;->getMediatype()Ljava/lang/String;

    move-result-object v8

    .line 1335
    invoke-virtual {v15}, Lorg/xbmc/kodi/model/File;->getId()J

    move-result-wide v16

    .line 1336
    invoke-virtual {v8, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    const/4 v15, 0x2

    const/16 v18, 0x1

    if-eqz v14, :cond_1

    .line 1337
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->RETRIEVE_MOVIE_DETAILS:Ljava/lang/String;

    new-array v9, v15, [Ljava/lang/Object;

    invoke-static/range {v16 .. v17}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v10

    aput-object v10, v9, v5

    add-int/lit8 v7, v7, 0x1

    invoke-static {v7}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v9, v18

    invoke-static {v4, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto/16 :goto_1

    .line 1338
    :cond_1
    invoke-virtual {v8, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_2

    .line 1339
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->RETRIEVE_EPISODE_DETAILS:Ljava/lang/String;

    new-array v9, v15, [Ljava/lang/Object;

    invoke-static/range {v16 .. v17}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v10

    aput-object v10, v9, v5

    add-int/lit8 v7, v7, 0x1

    invoke-static {v7}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v9, v18

    invoke-static {v4, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto/16 :goto_1

    .line 1340
    :cond_2
    invoke-virtual {v8, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    if-eqz v12, :cond_3

    .line 1341
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->RETRIEVE_TVSHOW_DETAILS:Ljava/lang/String;

    new-array v9, v15, [Ljava/lang/Object;

    invoke-static/range {v16 .. v17}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v10

    aput-object v10, v9, v5

    add-int/lit8 v7, v7, 0x1

    invoke-static {v7}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v9, v18

    invoke-static {v4, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto/16 :goto_1

    .line 1342
    :cond_3
    invoke-virtual {v8, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_4

    .line 1343
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->RETRIEVE_ALBUM_DETAILS:Ljava/lang/String;

    new-array v9, v15, [Ljava/lang/Object;

    invoke-static/range {v16 .. v17}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v10

    aput-object v10, v9, v5

    add-int/lit8 v7, v7, 0x1

    invoke-static {v7}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v9, v18

    invoke-static {v4, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto :goto_1

    .line 1344
    :cond_4
    invoke-virtual {v8, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_5

    .line 1345
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->RETRIEVE_SONG_DETAILS:Ljava/lang/String;

    new-array v9, v15, [Ljava/lang/Object;

    invoke-static/range {v16 .. v17}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v10

    aput-object v10, v9, v5

    add-int/lit8 v7, v7, 0x1

    invoke-static {v7}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v9, v18

    invoke-static {v4, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto :goto_1

    .line 1346
    :cond_5
    invoke-virtual {v8, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_6

    .line 1347
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->RETRIEVE_MUSICVIDEO_DETAILS:Ljava/lang/String;

    new-array v9, v15, [Ljava/lang/Object;

    invoke-static/range {v16 .. v17}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v10

    aput-object v10, v9, v5

    add-int/lit8 v7, v7, 0x1

    invoke-static {v7}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v9, v18

    invoke-static {v4, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    :cond_6
    :goto_1
    add-int/lit8 v6, v6, 0x1

    .line 1349
    invoke-interface/range {p1 .. p1}, Ljava/util/List;->size()I

    move-result v8

    if-ge v6, v8, :cond_0

    const/16 v8, 0x14

    if-ge v7, v8, :cond_0

    .line 1350
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ","

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto/16 :goto_0

    .line 1352
    :cond_7
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, "]"

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 1354
    invoke-virtual {v1, v4}, Lorg/xbmc/kodi/XBMCJsonRPC;->request_array(Ljava/lang/String;)Lcom/google/gson/JsonArray;

    move-result-object v4

    if-nez v4, :cond_8

    return-object v3

    .line 1359
    :cond_8
    :goto_2
    invoke-virtual {v4}, Lcom/google/gson/JsonArray;->size()I

    move-result v6

    if-ge v5, v6, :cond_10

    .line 1361
    invoke-virtual {v4, v5}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v6

    invoke-virtual {v6}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v6

    if-eqz v6, :cond_f

    .line 1362
    invoke-virtual {v6, v2}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_9

    goto/16 :goto_3

    .line 1365
    :cond_9
    invoke-interface {v0, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lorg/xbmc/kodi/model/File;

    .line 1366
    invoke-virtual {v7}, Lorg/xbmc/kodi/model/File;->getMediatype()Ljava/lang/String;

    move-result-object v7

    .line 1367
    invoke-virtual {v7, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_a

    .line 1369
    invoke-virtual {v6, v2}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v6

    const-string v7, "moviedetails"

    invoke-virtual {v6, v7}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v6

    .line 1370
    invoke-direct {v1, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->createMovieFromJson(Lcom/google/gson/JsonObject;)Lorg/xbmc/kodi/model/Movie;

    move-result-object v6

    if-eqz v6, :cond_f

    .line 1373
    invoke-interface {v3, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto/16 :goto_3

    .line 1377
    :cond_a
    invoke-virtual {v7, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_b

    .line 1379
    invoke-virtual {v6, v2}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v6

    const-string v7, "episodedetails"

    invoke-virtual {v6, v7}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v6

    .line 1380
    invoke-direct {v1, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->createTVEpisodeFromJson(Lcom/google/gson/JsonObject;)Lorg/xbmc/kodi/model/TVEpisode;

    move-result-object v6

    if-eqz v6, :cond_f

    .line 1383
    invoke-interface {v3, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 1387
    :cond_b
    invoke-virtual {v7, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_c

    .line 1389
    invoke-virtual {v6, v2}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v6

    const-string v7, "tvshowdetails"

    invoke-virtual {v6, v7}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v6

    .line 1390
    invoke-direct {v1, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->createTVShowFromJson(Lcom/google/gson/JsonObject;)Lorg/xbmc/kodi/model/TVShow;

    move-result-object v6

    .line 1391
    invoke-interface {v3, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 1394
    :cond_c
    invoke-virtual {v7, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_d

    .line 1396
    invoke-virtual {v6, v2}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v6

    const-string v7, "albumdetails"

    invoke-virtual {v6, v7}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v6

    .line 1397
    invoke-direct {v1, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->createAlbumFromJson(Lcom/google/gson/JsonObject;)Lorg/xbmc/kodi/model/Album;

    move-result-object v6

    .line 1398
    invoke-interface {v3, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 1401
    :cond_d
    invoke-virtual {v7, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_e

    .line 1403
    invoke-virtual {v6, v2}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v6

    const-string v7, "songdetails"

    invoke-virtual {v6, v7}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v6

    .line 1404
    invoke-direct {v1, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->createSongFromJson(Lcom/google/gson/JsonObject;)Lorg/xbmc/kodi/model/Song;

    move-result-object v6

    .line 1405
    invoke-interface {v3, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 1408
    :cond_e
    invoke-virtual {v7, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_f

    .line 1410
    invoke-virtual {v6, v2}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v6

    const-string v7, "musicvideodetails"

    invoke-virtual {v6, v7}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v6

    .line 1411
    invoke-direct {v1, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->createMusicvideoFromJson(Lcom/google/gson/JsonObject;)Lorg/xbmc/kodi/model/MusicVideo;

    move-result-object v6

    .line 1412
    invoke-interface {v3, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    :cond_f
    :goto_3
    add-int/lit8 v5, v5, 0x1

    goto/16 :goto_2

    :catch_0
    move-exception v0

    .line 1418
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_10
    return-object v3
.end method

.method public getSuggestions(Ljava/lang/String;I)Landroid/database/Cursor;
    .locals 38

    move-object/from16 v1, p0

    move-object/from16 v0, p1

    move/from16 v2, p2

    const-string v3, "_id"

    const-string v4, "suggest_text_1"

    const-string v5, "suggest_text_2"

    const-string v6, "suggest_icon_1"

    const-string v7, "suggest_result_card_image"

    const-string v8, "suggest_intent_action"

    const-string v9, "suggest_intent_data"

    const-string v10, "suggest_video_width"

    const-string v11, "suggest_video_height"

    const-string v12, "suggest_production_year"

    const-string v13, "suggest_duration"

    const-string v14, "suggest_shortcut_id"

    .line 318
    filled-new-array/range {v3 .. v14}, [Ljava/lang/String;

    move-result-object v3

    .line 333
    new-instance v4, Landroid/database/MatrixCursor;

    invoke-direct {v4, v3}, Landroid/database/MatrixCursor;-><init>([Ljava/lang/String;)V

    .line 335
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v5, "["

    invoke-direct {v3, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v5, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->SEARCH_MOVIES_JSON:Ljava/lang/String;

    const/4 v6, 0x2

    new-array v7, v6, [Ljava/lang/Object;

    new-instance v8, Ljava/lang/StringBuilder;

    const-string v9, "\"or\": [{\"operator\": \"contains\", \"field\": \"title\", \"value\": \""

    invoke-direct {v8, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v9, "\"},{\"operator\": \"contains\", \"field\": \"originaltitle\", \"value\": \""

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v9, "\"},{\"operator\": \"contains\", \"field\": \"set\", \"value\": \""

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v9, "\"}]"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    const/4 v10, 0x0

    .line 527
    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    aput-object v8, v7, v10

    const-string v8, "1"

    const/4 v12, 0x1

    aput-object v8, v7, v12

    .line 336
    invoke-static {v5, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, ","

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v7, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->SEARCH_SHOWS_JSON:Ljava/lang/String;

    new-array v8, v6, [Ljava/lang/Object;

    new-instance v13, Ljava/lang/StringBuilder;

    const-string v14, "\"or\": [{\"operator\": \"contains\", \"field\": \"title\", \"value\": \""

    invoke-direct {v13, v14}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v14, "\"},{\"operator\": \"contains\", \"field\": \"originaltitle\", \"value\": \""

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    aput-object v13, v8, v10

    const-string v13, "2"

    aput-object v13, v8, v12

    .line 342
    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v7, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->SEARCH_ALBUMS_JSON:Ljava/lang/String;

    new-array v8, v6, [Ljava/lang/Object;

    new-instance v13, Ljava/lang/StringBuilder;

    const-string v14, "\"or\": [{\"operator\": \"contains\", \"field\": \"album\", \"value\": \""

    invoke-direct {v13, v14}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v14, "\"},{\"operator\": \"contains\", \"field\": \"label\", \"value\": \""

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    aput-object v13, v8, v10

    const-string v13, "3"

    aput-object v13, v8, v12

    .line 347
    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v7, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->SEARCH_ARTISTS_JSON:Ljava/lang/String;

    new-array v8, v6, [Ljava/lang/Object;

    new-instance v13, Ljava/lang/StringBuilder;

    const-string v14, "\"operator\": \"contains\", \"field\": \"artist\", \"value\": \""

    invoke-direct {v13, v14}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v14, "\""

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    aput-object v13, v8, v10

    const-string v13, "4"

    aput-object v13, v8, v12

    .line 352
    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v7, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->SEARCH_MOVIES_JSON:Ljava/lang/String;

    new-array v8, v6, [Ljava/lang/Object;

    new-instance v13, Ljava/lang/StringBuilder;

    const-string v14, "\"or\": [{\"operator\": \"contains\", \"field\": \"actor\", \"value\": \""

    invoke-direct {v13, v14}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v14, "\"},{\"operator\": \"contains\", \"field\": \"director\", \"value\": \""

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    aput-object v13, v8, v10

    const-string v13, "5"

    aput-object v13, v8, v12

    .line 355
    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v5, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->SEARCH_SHOWS_JSON:Ljava/lang/String;

    new-array v7, v6, [Ljava/lang/Object;

    new-instance v8, Ljava/lang/StringBuilder;

    const-string v13, "\"or\": [{\"operator\": \"contains\", \"field\": \"actor\", \"value\": \""

    invoke-direct {v8, v13}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v13, "\"},{\"operator\": \"contains\", \"field\": \"director\", \"value\": \""

    invoke-virtual {v8, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v7, v10

    const-string v0, "6"

    aput-object v0, v7, v12

    .line 360
    invoke-static {v5, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "]"

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 366
    invoke-virtual {v1, v0}, Lorg/xbmc/kodi/XBMCJsonRPC;->request_array(Ljava/lang/String;)Lcom/google/gson/JsonArray;

    move-result-object v3

    if-nez v3, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    const/4 v5, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    .line 372
    :goto_0
    invoke-virtual {v3}, Lcom/google/gson/JsonArray;->size()I

    move-result v0

    if-ge v5, v0, :cond_1f

    .line 378
    :try_start_0
    invoke-virtual {v3, v5}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v0

    if-nez v0, :cond_3

    move-object/from16 v31, v3

    :cond_1
    :goto_1
    move/from16 v34, v7

    :cond_2
    :goto_2
    const/16 v26, 0x2

    const/16 v27, 0x1

    const/16 v28, 0x0

    goto/16 :goto_18

    :cond_3
    const-string v13, "id"

    .line 382
    invoke-virtual {v0, v13}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v13

    invoke-virtual {v13}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v13
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_c

    const-string v14, "1"

    .line 390
    invoke-virtual {v13, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    const-string v15, "year"

    const/16 v16, -0x1

    const/16 v17, 0xb

    const/16 v18, 0xa

    const/16 v19, 0x9

    const/16 v20, 0x8

    const/16 v21, 0x7

    const/16 v22, 0x6

    const-string v23, "android.intent.action.GET_CONTENT"

    const/16 v24, 0x5

    const/16 v25, 0x4

    const-string v6, "title"

    const-string v10, "thumb"

    const-string v29, ""

    const-string v12, "result"

    if-nez v14, :cond_18

    add-int v14, v7, v8

    move-object/from16 v31, v3

    const/4 v3, 0x3

    if-ge v14, v3, :cond_4

    const-string v3, "5"

    invoke-virtual {v13, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    goto/16 :goto_11

    :cond_4
    const-string v3, "2"

    .line 446
    invoke-virtual {v13, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_f

    const/4 v3, 0x3

    if-ge v14, v3, :cond_5

    const-string v3, "6"

    invoke-virtual {v13, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    goto/16 :goto_9

    :cond_5
    const-string v3, "3"

    .line 502
    invoke-virtual {v13, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_a

    .line 506
    :try_start_1
    invoke-virtual {v0, v12}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_6

    goto :goto_1

    .line 508
    :cond_6
    invoke-virtual {v0, v12}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v0

    if-eqz v0, :cond_1

    const-string v3, "albums"

    .line 509
    invoke-virtual {v0, v3}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_7

    goto :goto_1

    :cond_7
    const-string v3, "albums"

    .line 511
    invoke-virtual {v0, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsJsonArray()Lcom/google/gson/JsonArray;

    move-result-object v0

    const/4 v3, 0x0

    .line 513
    :goto_3
    invoke-virtual {v0}, Lcom/google/gson/JsonArray;->size()I

    move-result v12

    if-ge v3, v12, :cond_17

    if-ge v9, v2, :cond_17

    .line 515
    invoke-virtual {v0, v3}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v12

    invoke-virtual {v12}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v12

    .line 516
    invoke-direct {v1, v12, v10}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    const/16 v14, 0xc

    new-array v15, v14, [Ljava/lang/Object;

    const-string v14, "albumid"

    .line 520
    invoke-virtual {v12, v14}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v14

    invoke-virtual {v14}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v14

    const/16 v28, 0x0

    aput-object v14, v15, v28

    .line 521
    invoke-virtual {v12, v6}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v14

    invoke-virtual {v14}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v14

    const/16 v27, 0x1

    aput-object v14, v15, v27

    const-string v14, "displayartist"

    .line 522
    invoke-virtual {v12, v14}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v14

    invoke-virtual {v14}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v14

    const/16 v26, 0x2

    aput-object v14, v15, v26

    if-eqz v13, :cond_8

    .line 523
    invoke-virtual {v13}, Ljava/lang/String;->isEmpty()Z

    move-result v14

    if-nez v14, :cond_8

    move-object v14, v13

    goto :goto_4

    :cond_8
    move-object/from16 v14, v29

    :goto_4
    invoke-virtual {v1, v14}, Lorg/xbmc/kodi/XBMCJsonRPC;->getDownloadUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    invoke-static {v14}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v14

    invoke-virtual {v14}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v14

    const/16 v30, 0x3

    aput-object v14, v15, v30

    if-eqz v13, :cond_9

    .line 524
    invoke-virtual {v13}, Ljava/lang/String;->isEmpty()Z

    move-result v14

    if-nez v14, :cond_9

    goto :goto_5

    :cond_9
    move-object/from16 v13, v29

    :goto_5
    invoke-virtual {v1, v13}, Lorg/xbmc/kodi/XBMCJsonRPC;->getDownloadUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    invoke-static {v13}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v13

    invoke-virtual {v13}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v13

    aput-object v13, v15, v25

    aput-object v23, v15, v24

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "musicdb://albums/"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v14, "albumid"

    .line 526
    invoke-virtual {v12, v14}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v12

    invoke-virtual {v12}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v12, "/"

    invoke-virtual {v13, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v12}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v12

    aput-object v12, v15, v22

    aput-object v11, v15, v21

    aput-object v11, v15, v20

    aput-object v11, v15, v19

    aput-object v11, v15, v18

    .line 531
    invoke-static/range {v16 .. v16}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v12

    aput-object v12, v15, v17

    .line 518
    invoke-virtual {v4, v15}, Landroid/database/MatrixCursor;->addRow([Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    add-int/lit8 v9, v9, 0x1

    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_3

    :catch_0
    move-exception v0

    .line 537
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto/16 :goto_10

    :cond_a
    const-string v3, "4"

    .line 540
    invoke-virtual {v13, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 544
    :try_start_2
    invoke-virtual {v0, v12}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_b

    goto/16 :goto_1

    .line 546
    :cond_b
    invoke-virtual {v0, v12}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v0

    if-eqz v0, :cond_1

    const-string v3, "artists"

    .line 547
    invoke-virtual {v0, v3}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_c

    goto/16 :goto_1

    :cond_c
    const-string v3, "artists"

    .line 549
    invoke-virtual {v0, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsJsonArray()Lcom/google/gson/JsonArray;

    move-result-object v0

    const/4 v3, 0x0

    .line 551
    :goto_6
    invoke-virtual {v0}, Lcom/google/gson/JsonArray;->size()I

    move-result v6

    if-ge v3, v6, :cond_17

    if-ge v9, v2, :cond_17

    .line 553
    invoke-virtual {v0, v3}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v6

    invoke-virtual {v6}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v6

    .line 554
    invoke-direct {v1, v6, v10}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    const/16 v13, 0xc

    new-array v14, v13, [Ljava/lang/Object;

    const-string v13, "artistid"

    .line 558
    invoke-virtual {v6, v13}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v13

    invoke-virtual {v13}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v13

    const/4 v15, 0x0

    aput-object v13, v14, v15

    const-string v13, "artist"

    .line 559
    invoke-virtual {v6, v13}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v13

    invoke-virtual {v13}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v13

    const/4 v15, 0x1

    aput-object v13, v14, v15

    const-string v13, "description"

    .line 560
    invoke-virtual {v6, v13}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v13

    invoke-virtual {v13}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v13

    const/4 v15, 0x2

    aput-object v13, v14, v15

    if-eqz v12, :cond_d

    .line 561
    invoke-virtual {v12}, Ljava/lang/String;->isEmpty()Z

    move-result v13

    if-nez v13, :cond_d

    move-object v13, v12

    goto :goto_7

    :cond_d
    move-object/from16 v13, v29

    :goto_7
    invoke-virtual {v1, v13}, Lorg/xbmc/kodi/XBMCJsonRPC;->getDownloadUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    invoke-static {v13}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v13

    invoke-virtual {v13}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v13

    const/4 v15, 0x3

    aput-object v13, v14, v15

    if-eqz v12, :cond_e

    .line 562
    invoke-virtual {v12}, Ljava/lang/String;->isEmpty()Z

    move-result v13

    if-nez v13, :cond_e

    goto :goto_8

    :cond_e
    move-object/from16 v12, v29

    :goto_8
    invoke-virtual {v1, v12}, Lorg/xbmc/kodi/XBMCJsonRPC;->getDownloadUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    invoke-static {v12}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v12

    invoke-virtual {v12}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v12

    aput-object v12, v14, v25

    aput-object v23, v14, v24

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "musicdb://artists/"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v13, "artistid"

    .line 564
    invoke-virtual {v6, v13}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v6

    invoke-virtual {v6}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v12, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, "/"

    invoke-virtual {v12, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v6

    aput-object v6, v14, v22

    aput-object v11, v14, v21

    aput-object v11, v14, v20

    aput-object v11, v14, v19

    aput-object v11, v14, v18

    .line 569
    invoke-static/range {v16 .. v16}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v14, v17

    .line 556
    invoke-virtual {v4, v14}, Landroid/database/MatrixCursor;->addRow([Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    add-int/lit8 v9, v9, 0x1

    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_6

    :catch_1
    move-exception v0

    .line 575
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto/16 :goto_10

    .line 450
    :cond_f
    :goto_9
    :try_start_3
    invoke-virtual {v0, v12}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_10

    goto/16 :goto_1

    .line 452
    :cond_10
    invoke-virtual {v0, v12}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v0

    if-eqz v0, :cond_1

    const-string v3, "tvshows"

    .line 453
    invoke-virtual {v0, v3}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_11

    goto/16 :goto_1

    :cond_11
    const-string v3, "tvshows"

    .line 455
    invoke-virtual {v0, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsJsonArray()Lcom/google/gson/JsonArray;

    move-result-object v3

    const/4 v12, 0x0

    .line 457
    :goto_a
    invoke-virtual {v3}, Lcom/google/gson/JsonArray;->size()I

    move-result v0

    if-ge v12, v0, :cond_16

    if-ge v9, v2, :cond_16

    .line 459
    invoke-virtual {v3, v12}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v13

    const-string v0, "poster"

    .line 461
    invoke-direct {v1, v13, v0}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 462
    invoke-direct {v1, v13, v10}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v32
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_4

    .line 468
    :try_start_4
    invoke-virtual {v13, v15}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v0
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2

    move-object/from16 v33, v3

    move/from16 v34, v7

    goto :goto_b

    :catch_2
    move-exception v0

    .line 472
    :try_start_5
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_4

    move-object/from16 v33, v3

    move/from16 v34, v7

    const/4 v0, 0x0

    :goto_b
    const/16 v3, 0xc

    :try_start_6
    new-array v7, v3, [Ljava/lang/Object;

    const-string v3, "tvshowid"

    .line 476
    invoke-virtual {v13, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v3

    const/16 v28, 0x0

    aput-object v3, v7, v28

    .line 477
    invoke-virtual {v13, v6}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v3

    const/16 v27, 0x1

    aput-object v3, v7, v27

    const-string v3, "plot"

    .line 478
    invoke-virtual {v13, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v3

    const/16 v26, 0x2

    aput-object v3, v7, v26

    if-eqz v14, :cond_12

    .line 480
    invoke-virtual {v14}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_12

    move-object v3, v14

    goto :goto_c

    :cond_12
    if-eqz v32, :cond_13

    invoke-virtual/range {v32 .. v32}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_13

    move-object/from16 v3, v32

    goto :goto_c

    :cond_13
    move-object/from16 v3, v29

    .line 479
    :goto_c
    invoke-virtual {v1, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->getDownloadUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    .line 481
    invoke-virtual {v3}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v3

    const/16 v30, 0x3

    aput-object v3, v7, v30

    if-eqz v14, :cond_14

    .line 483
    invoke-virtual {v14}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_14

    goto :goto_d

    :cond_14
    if-eqz v32, :cond_15

    invoke-virtual/range {v32 .. v32}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_15

    move-object/from16 v14, v32

    goto :goto_d

    :cond_15
    move-object/from16 v14, v29

    .line 482
    :goto_d
    invoke-virtual {v1, v14}, Lorg/xbmc/kodi/XBMCJsonRPC;->getDownloadUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    .line 484
    invoke-virtual {v3}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v7, v25

    aput-object v23, v7, v24

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "videodb://tvshows/titles/"

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v14, "tvshowid"

    .line 486
    invoke-virtual {v13, v14}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v14

    invoke-virtual {v14}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v14, "?showinfo=true"

    invoke-virtual {v3, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    aput-object v3, v7, v22

    aput-object v11, v7, v21

    aput-object v11, v7, v20

    .line 489
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v7, v19

    const v0, 0x2932e0

    .line 490
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v7, v18

    .line 491
    invoke-static/range {v16 .. v16}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v7, v17

    .line 474
    invoke-virtual {v4, v7}, Landroid/database/MatrixCursor;->addRow([Ljava/lang/Object;)V

    .line 493
    sget-object v0, Lorg/xbmc/kodi/XBMCJsonRPC;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "XBMCJsonRPC: tvshow: "

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13, v6}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v7

    invoke-virtual {v7}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v7, ", "

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13, v15}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v7

    invoke-virtual {v7}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_3

    add-int/lit8 v8, v8, 0x1

    add-int/lit8 v9, v9, 0x1

    add-int/lit8 v12, v12, 0x1

    move-object/from16 v3, v33

    move/from16 v7, v34

    goto/16 :goto_a

    :catch_3
    move-exception v0

    goto :goto_e

    :cond_16
    move/from16 v34, v7

    goto :goto_f

    :catch_4
    move-exception v0

    move/from16 v34, v7

    .line 499
    :goto_e
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_f
    move/from16 v7, v34

    :cond_17
    :goto_10
    const/16 v26, 0x2

    const/16 v27, 0x1

    const/16 v28, 0x0

    goto/16 :goto_19

    :cond_18
    move-object/from16 v31, v3

    :goto_11
    move/from16 v34, v7

    if-eqz v0, :cond_2

    .line 394
    :try_start_7
    invoke-virtual {v0, v12}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_19

    goto/16 :goto_2

    .line 396
    :cond_19
    invoke-virtual {v0, v12}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v0

    if-eqz v0, :cond_2

    const-string v3, "movies"

    .line 397
    invoke-virtual {v0, v3}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1a

    goto/16 :goto_2

    :cond_1a
    const-string v3, "movies"

    .line 399
    invoke-virtual {v0, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsJsonArray()Lcom/google/gson/JsonArray;

    move-result-object v3
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_b

    move/from16 v7, v34

    const/4 v12, 0x0

    .line 401
    :goto_12
    :try_start_8
    invoke-virtual {v3}, Lcom/google/gson/JsonArray;->size()I

    move-result v0

    if-ge v12, v0, :cond_17

    if-ge v9, v2, :cond_17

    .line 403
    invoke-virtual {v3, v12}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v13

    const-string v0, "poster"

    .line 405
    invoke-direct {v1, v13, v0}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 406
    invoke-direct {v1, v13, v10}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v32
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_a

    .line 412
    :try_start_9
    invoke-virtual {v13, v15}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v33
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_6

    :try_start_a
    const-string v0, "runtime"

    .line 413
    invoke-virtual {v13, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsLong()J

    move-result-wide v34
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_5

    const-wide/16 v36, 0x3e8

    mul-long v34, v34, v36

    goto :goto_14

    :catch_5
    move-exception v0

    goto :goto_13

    :catch_6
    move-exception v0

    const/16 v33, 0x0

    .line 417
    :goto_13
    :try_start_b
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    const-wide/16 v34, 0x0

    :goto_14
    const/16 v2, 0xc

    new-array v0, v2, [Ljava/lang/Object;

    const-string v2, "movieid"

    .line 421
    invoke-virtual {v13, v2}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v2
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_a

    const/16 v28, 0x0

    :try_start_c
    aput-object v2, v0, v28

    .line 422
    invoke-virtual {v13, v6}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v2
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_9

    const/16 v27, 0x1

    :try_start_d
    aput-object v2, v0, v27

    const-string v2, "tagline"

    .line 423
    invoke-virtual {v13, v2}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v2
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_8

    const/16 v26, 0x2

    :try_start_e
    aput-object v2, v0, v26

    if-eqz v14, :cond_1b

    .line 425
    invoke-virtual {v14}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1b

    move-object v2, v14

    goto :goto_15

    :cond_1b
    if-eqz v32, :cond_1c

    invoke-virtual/range {v32 .. v32}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1c

    move-object/from16 v2, v32

    goto :goto_15

    :cond_1c
    move-object/from16 v2, v29

    .line 424
    :goto_15
    invoke-virtual {v1, v2}, Lorg/xbmc/kodi/XBMCJsonRPC;->getDownloadUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    .line 426
    invoke-virtual {v2}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v2

    const/16 v30, 0x3

    aput-object v2, v0, v30

    if-eqz v14, :cond_1d

    .line 428
    invoke-virtual {v14}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1d

    goto :goto_16

    :cond_1d
    if-eqz v32, :cond_1e

    invoke-virtual/range {v32 .. v32}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1e

    move-object/from16 v14, v32

    goto :goto_16

    :cond_1e
    move-object/from16 v14, v29

    .line 427
    :goto_16
    invoke-virtual {v1, v14}, Lorg/xbmc/kodi/XBMCJsonRPC;->getDownloadUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    .line 429
    invoke-virtual {v2}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v25

    aput-object v23, v0, v24

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "videodb://movies/titles/"

    invoke-virtual {v2, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v14, "movieid"

    .line 431
    invoke-virtual {v13, v14}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v13

    invoke-virtual {v13}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v13, "?showinfo=true"

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    aput-object v2, v0, v22

    aput-object v11, v0, v21

    aput-object v11, v0, v20

    .line 434
    invoke-static/range {v33 .. v33}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v0, v19

    .line 435
    invoke-static/range {v34 .. v35}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    aput-object v2, v0, v18

    .line 436
    invoke-static/range {v16 .. v16}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v0, v17

    .line 419
    invoke-virtual {v4, v0}, Landroid/database/MatrixCursor;->addRow([Ljava/lang/Object;)V
    :try_end_e
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_7

    add-int/lit8 v7, v7, 0x1

    add-int/lit8 v9, v9, 0x1

    add-int/lit8 v12, v12, 0x1

    move/from16 v2, p2

    goto/16 :goto_12

    :catch_7
    move-exception v0

    goto :goto_17

    :catch_8
    move-exception v0

    const/16 v26, 0x2

    goto :goto_17

    :catch_9
    move-exception v0

    const/16 v26, 0x2

    const/16 v27, 0x1

    goto :goto_17

    :catch_a
    move-exception v0

    const/16 v26, 0x2

    const/16 v27, 0x1

    const/16 v28, 0x0

    goto :goto_17

    :catch_b
    move-exception v0

    const/16 v26, 0x2

    const/16 v27, 0x1

    const/16 v28, 0x0

    move/from16 v7, v34

    .line 443
    :goto_17
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_19

    :catch_c
    move-exception v0

    move-object/from16 v31, v3

    move/from16 v34, v7

    const/16 v26, 0x2

    const/16 v27, 0x1

    const/16 v28, 0x0

    .line 386
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_18
    move/from16 v7, v34

    :goto_19
    add-int/lit8 v5, v5, 0x1

    move/from16 v2, p2

    move-object/from16 v3, v31

    const/4 v6, 0x2

    const/4 v10, 0x0

    const/4 v12, 0x1

    goto/16 :goto_0

    :cond_1f
    return-object v4
.end method

.method public getSuggestions()Ljava/util/List;
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lorg/xbmc/kodi/model/Media;",
            ">;"
        }
    .end annotation

    const-string v0, "albums"

    const-string v1, "tvshows"

    const-string v2, "movies"

    .line 1178
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 1183
    iget-object v4, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->RECOMMENDATION_MOVIES_JSON:Ljava/lang/String;

    invoke-virtual {p0, v4}, Lorg/xbmc/kodi/XBMCJsonRPC;->request_object(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v4

    .line 1184
    new-instance v5, Lcom/google/gson/JsonArray;

    invoke-direct {v5}, Lcom/google/gson/JsonArray;-><init>()V

    const-string v6, "result"

    const/4 v7, 0x1

    const/4 v8, 0x0

    if-eqz v4, :cond_0

    .line 1185
    invoke-virtual {v4, v6}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_0

    .line 1189
    :try_start_0
    invoke-virtual {v4, v6}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v4

    .line 1190
    invoke-virtual {v4, v2}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_0

    .line 1192
    invoke-virtual {v4, v2}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/gson/JsonElement;->getAsJsonArray()Lcom/google/gson/JsonArray;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 1193
    :try_start_1
    invoke-virtual {v2}, Lcom/google/gson/JsonArray;->size()I

    move-result v4
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-object v5, v2

    if-lez v4, :cond_0

    const/4 v2, 0x1

    goto :goto_1

    :catch_0
    nop

    move-object v5, v2

    goto :goto_0

    :catch_1
    nop

    :cond_0
    :goto_0
    const/4 v2, 0x0

    .line 1202
    :goto_1
    iget-object v4, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->RECOMMENDATIONS_SHOWS_JSON:Ljava/lang/String;

    invoke-virtual {p0, v4}, Lorg/xbmc/kodi/XBMCJsonRPC;->request_object(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v4

    .line 1203
    new-instance v9, Lcom/google/gson/JsonArray;

    invoke-direct {v9}, Lcom/google/gson/JsonArray;-><init>()V

    if-eqz v4, :cond_2

    .line 1204
    invoke-virtual {v4, v6}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_2

    .line 1208
    :try_start_2
    invoke-virtual {v4, v6}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v4

    .line 1209
    invoke-virtual {v4, v1}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_2

    .line 1211
    invoke-virtual {v4, v1}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/gson/JsonElement;->getAsJsonArray()Lcom/google/gson/JsonArray;

    move-result-object v1
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_3

    .line 1212
    :try_start_3
    invoke-virtual {v1}, Lcom/google/gson/JsonArray;->size()I

    move-result v4
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2

    if-lez v4, :cond_1

    add-int/lit8 v2, v2, 0x1

    :cond_1
    :goto_2
    move-object v9, v1

    goto :goto_3

    :catch_2
    nop

    goto :goto_2

    :catch_3
    nop

    .line 1221
    :cond_2
    :goto_3
    iget-object v1, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->RECOMMENDATIONS_ALBUMS_JSON:Ljava/lang/String;

    invoke-virtual {p0, v1}, Lorg/xbmc/kodi/XBMCJsonRPC;->request_object(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v1

    .line 1222
    new-instance v4, Lcom/google/gson/JsonArray;

    invoke-direct {v4}, Lcom/google/gson/JsonArray;-><init>()V

    if-eqz v1, :cond_4

    .line 1223
    invoke-virtual {v1, v6}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_4

    .line 1227
    :try_start_4
    invoke-virtual {v1, v6}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v1

    .line 1228
    invoke-virtual {v1, v0}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_4

    .line 1230
    invoke-virtual {v1, v0}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsJsonArray()Lcom/google/gson/JsonArray;

    move-result-object v0
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_5

    .line 1231
    :try_start_5
    invoke-virtual {v0}, Lcom/google/gson/JsonArray;->size()I

    move-result v1
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_4

    if-lez v1, :cond_3

    add-int/lit8 v2, v2, 0x1

    :cond_3
    :goto_4
    move-object v4, v0

    goto :goto_5

    :catch_4
    nop

    goto :goto_4

    :catch_5
    nop

    :cond_4
    :goto_5
    if-ne v2, v7, :cond_5

    const/16 v0, 0xa

    .line 1243
    iput v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->MAX_RECOMMENDATIONS:I

    goto :goto_6

    :cond_5
    const/4 v0, 0x2

    if-ne v2, v0, :cond_6

    const/4 v0, 0x5

    .line 1247
    iput v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->MAX_RECOMMENDATIONS:I

    goto :goto_6

    :cond_6
    const/4 v0, 0x3

    .line 1251
    iput v0, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->MAX_RECOMMENDATIONS:I

    .line 1254
    :goto_6
    invoke-virtual {v5}, Lcom/google/gson/JsonArray;->size()I

    move-result v0

    if-lez v0, :cond_8

    const/4 v0, 0x0

    const/4 v1, 0x0

    .line 1257
    :goto_7
    invoke-virtual {v5}, Lcom/google/gson/JsonArray;->size()I

    move-result v2

    if-ge v0, v2, :cond_8

    iget v2, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->MAX_RECOMMENDATIONS:I

    if-ge v1, v2, :cond_8

    .line 1261
    :try_start_6
    invoke-virtual {v5, v0}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v2

    .line 1262
    invoke-direct {p0, v2}, Lorg/xbmc/kodi/XBMCJsonRPC;->createMovieFromJson(Lcom/google/gson/JsonObject;)Lorg/xbmc/kodi/model/Movie;

    move-result-object v2

    if-eqz v2, :cond_7

    .line 1265
    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_6

    add-int/lit8 v1, v1, 0x1

    :catch_6
    :cond_7
    add-int/lit8 v0, v0, 0x1

    goto :goto_7

    .line 1276
    :cond_8
    invoke-virtual {v9}, Lcom/google/gson/JsonArray;->size()I

    move-result v0

    if-lez v0, :cond_a

    const/4 v0, 0x0

    const/4 v1, 0x0

    .line 1279
    :goto_8
    invoke-virtual {v9}, Lcom/google/gson/JsonArray;->size()I

    move-result v2

    if-ge v0, v2, :cond_a

    iget v2, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->MAX_RECOMMENDATIONS:I

    if-ge v1, v2, :cond_a

    .line 1283
    :try_start_7
    invoke-virtual {v9, v0}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v2

    .line 1284
    invoke-direct {p0, v2}, Lorg/xbmc/kodi/XBMCJsonRPC;->createTVShowFromJson(Lcom/google/gson/JsonObject;)Lorg/xbmc/kodi/model/TVShow;

    move-result-object v2

    if-eqz v2, :cond_9

    .line 1287
    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_7

    add-int/lit8 v1, v1, 0x1

    :catch_7
    :cond_9
    add-int/lit8 v0, v0, 0x1

    goto :goto_8

    .line 1298
    :cond_a
    invoke-virtual {v4}, Lcom/google/gson/JsonArray;->size()I

    move-result v0

    if-lez v0, :cond_c

    const/4 v0, 0x0

    .line 1301
    :goto_9
    invoke-virtual {v4}, Lcom/google/gson/JsonArray;->size()I

    move-result v1

    if-ge v8, v1, :cond_c

    iget v1, p0, Lorg/xbmc/kodi/XBMCJsonRPC;->MAX_RECOMMENDATIONS:I

    if-ge v0, v1, :cond_c

    .line 1305
    :try_start_8
    invoke-virtual {v4, v8}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v1

    invoke-virtual {v1}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v1

    .line 1306
    invoke-direct {p0, v1}, Lorg/xbmc/kodi/XBMCJsonRPC;->createAlbumFromJson(Lcom/google/gson/JsonObject;)Lorg/xbmc/kodi/model/Album;

    move-result-object v1

    if-eqz v1, :cond_b

    .line 1309
    invoke-interface {v3, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_8

    add-int/lit8 v0, v0, 0x1

    :catch_8
    :cond_b
    add-int/lit8 v8, v8, 0x1

    goto :goto_9

    :cond_c
    return-object v3
.end method

.method public request_array(Ljava/lang/String;)Lcom/google/gson/JsonArray;
    .locals 3

    const/4 v0, 0x0

    .line 174
    :try_start_0
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCJsonRPC;->request_string(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_0

    return-object v0

    .line 178
    :cond_0
    invoke-static {p1}, Lcom/google/gson/JsonParser;->parseString(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/gson/JsonElement;->getAsJsonArray()Lcom/google/gson/JsonArray;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    .line 182
    sget-object v1, Lorg/xbmc/kodi/XBMCJsonRPC;->TAG:Ljava/lang/String;

    const-string v2, "XBMCJsonRPC: Failed to parse JSON"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 183
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    return-object v0
.end method

.method public request_object(Ljava/lang/String;)Lcom/google/gson/JsonObject;
    .locals 3

    const/4 v0, 0x0

    .line 156
    :try_start_0
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCJsonRPC;->request_string(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_0

    return-object v0

    .line 160
    :cond_0
    invoke-static {p1}, Lcom/google/gson/JsonParser;->parseString(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    .line 164
    sget-object v1, Lorg/xbmc/kodi/XBMCJsonRPC;->TAG:Ljava/lang/String;

    const-string v2, "XBMCJsonRPC: Failed to parse JSON"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 165
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    return-object v0
.end method

.method public request_string(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    .line 137
    :try_start_0
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCJsonRPC;->_requestJSON(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    .line 147
    :catch_0
    sget-object p1, Lorg/xbmc/kodi/XBMCJsonRPC;->TAG:Ljava/lang/String;

    const-string v1, "XBMCJsonRPC: _requestJSON: Not available"

    invoke-static {p1, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-object v0

    :catch_1
    move-exception p1

    .line 141
    sget-object v1, Lorg/xbmc/kodi/XBMCJsonRPC;->TAG:Ljava/lang/String;

    const-string v2, "XBMCJsonRPC: Failed to read JSON"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 142
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    return-object v0
.end method

.method public search(Ljava/lang/String;)Landroid/database/Cursor;
    .locals 21

    move-object/from16 v1, p0

    move-object/from16 v0, p1

    const-string v2, "\"}]"

    const-string v3, "\"},{\"operator\": \"contains\", \"field\": \"director\", \"value\": \""

    const-string v4, "\"},{\"operator\": \"contains\", \"field\": \"actor\", \"value\": \""

    const-string v5, "result"

    const-string v6, "\"or\": [{\"operator\": \"contains\", \"field\": \"title\", \"value\": \""

    const-string v7, "COLUMN_THUMB"

    const-string v8, "COLUMN_FANART"

    const-string v9, "_id"

    const-string v10, "COLUMN_TITLE"

    const-string v11, "COLUMN_TAGLINE"

    .line 227
    filled-new-array {v9, v10, v11, v7, v8}, [Ljava/lang/String;

    move-result-object v7

    .line 234
    new-instance v8, Landroid/database/MatrixCursor;

    invoke-direct {v8, v7}, Landroid/database/MatrixCursor;-><init>([Ljava/lang/String;)V

    .line 238
    :try_start_0
    iget-object v9, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->SEARCH_MOVIES_JSON:Ljava/lang/String;

    const/4 v10, 0x1

    new-array v11, v10, [Ljava/lang/Object;

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v12, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v13, "\"},{\"operator\": \"contains\", \"field\": \"originaltitle\", \"value\": \""

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v13, "\"},{\"operator\": \"contains\", \"field\": \"set\", \"value\": \""

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    const/4 v13, 0x0

    aput-object v12, v11, v13

    invoke-static {v9, v11}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v1, v9}, Lorg/xbmc/kodi/XBMCJsonRPC;->request_object(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v9

    if-eqz v9, :cond_b

    .line 246
    invoke-virtual {v9, v5}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v11

    if-nez v11, :cond_0

    goto/16 :goto_7

    .line 249
    :cond_0
    invoke-virtual {v9, v5}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v9

    const-string v11, "movies"

    .line 250
    invoke-virtual {v9, v11}, Lcom/google/gson/JsonObject;->getAsJsonArray(Ljava/lang/String;)Lcom/google/gson/JsonArray;

    move-result-object v9

    const/4 v11, 0x0

    .line 252
    :goto_0
    invoke-virtual {v9}, Lcom/google/gson/JsonArray;->size()I

    move-result v12
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    const/16 v16, 0x2

    const-string v7, "title"

    const-string v14, "movieid"

    const-string v10, "fanart"

    const-string v13, "thumb"

    const-string v15, "poster"

    const-string v19, ""

    if-ge v11, v12, :cond_4

    .line 254
    :try_start_1
    invoke-virtual {v9, v11}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v12

    invoke-virtual {v12}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v12

    .line 256
    invoke-direct {v1, v12, v15}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    .line 257
    invoke-direct {v1, v12, v13}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    .line 258
    invoke-direct {v1, v12, v10}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    move-object/from16 v20, v9

    const/4 v9, 0x5

    new-array v9, v9, [Ljava/lang/Object;

    .line 261
    invoke-virtual {v12, v14}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v14

    const/16 v18, 0x0

    aput-object v14, v9, v18

    .line 262
    invoke-virtual {v12, v7}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v7

    const/4 v14, 0x1

    aput-object v7, v9, v14

    const-string v7, "tagline"

    .line 263
    invoke-virtual {v12, v7}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v7

    aput-object v7, v9, v16

    if-eqz v15, :cond_1

    .line 264
    invoke-virtual {v15}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_1

    goto :goto_1

    :cond_1
    if-eqz v13, :cond_2

    invoke-virtual {v13}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_2

    move-object v15, v13

    goto :goto_1

    :cond_2
    move-object/from16 v15, v19

    :goto_1
    const/4 v7, 0x3

    aput-object v15, v9, v7

    if-eqz v10, :cond_3

    .line 265
    invoke-virtual {v10}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_3

    move-object/from16 v19, v10

    :cond_3
    const/4 v7, 0x4

    aput-object v19, v9, v7

    .line 260
    invoke-virtual {v8, v9}, Landroid/database/MatrixCursor;->addRow([Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    add-int/lit8 v11, v11, 0x1

    move-object/from16 v9, v20

    const/4 v10, 0x1

    const/4 v13, 0x0

    goto :goto_0

    .line 276
    :cond_4
    :try_start_2
    iget-object v9, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->SEARCH_SHOWS_JSON:Ljava/lang/String;

    const/4 v11, 0x1

    new-array v12, v11, [Ljava/lang/Object;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v11, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v11, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v11, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    aput-object v0, v12, v2

    invoke-static {v9, v12}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lorg/xbmc/kodi/XBMCJsonRPC;->request_object(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v0

    if-eqz v0, :cond_a

    .line 282
    invoke-virtual {v0, v5}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_5

    goto/16 :goto_5

    .line 285
    :cond_5
    invoke-virtual {v0, v5}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v0

    const-string v2, "tvshows"

    .line 286
    invoke-virtual {v0, v2}, Lcom/google/gson/JsonObject;->getAsJsonArray(Ljava/lang/String;)Lcom/google/gson/JsonArray;

    move-result-object v0

    const/4 v2, 0x0

    .line 288
    :goto_2
    invoke-virtual {v0}, Lcom/google/gson/JsonArray;->size()I

    move-result v3

    if-ge v2, v3, :cond_9

    .line 290
    invoke-virtual {v0, v2}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v3

    invoke-virtual {v3}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v3

    .line 292
    invoke-direct {v1, v3, v15}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 293
    invoke-direct {v1, v3, v13}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 294
    invoke-direct {v1, v3, v10}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const/4 v9, 0x5

    new-array v11, v9, [Ljava/lang/Object;

    .line 297
    invoke-virtual {v3, v14}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v12

    const/16 v18, 0x0

    aput-object v12, v11, v18

    .line 298
    invoke-virtual {v3, v7}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v12

    const/16 v17, 0x1

    aput-object v12, v11, v17

    const-string v12, "plot"

    .line 299
    invoke-virtual {v3, v12}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v3

    aput-object v3, v11, v16

    if-eqz v4, :cond_6

    .line 300
    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_6

    goto :goto_3

    :cond_6
    if-eqz v5, :cond_7

    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_7

    move-object v4, v5

    goto :goto_3

    :cond_7
    move-object/from16 v4, v19

    :goto_3
    const/4 v3, 0x3

    aput-object v4, v11, v3

    if-eqz v6, :cond_8

    .line 301
    invoke-virtual {v6}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_8

    goto :goto_4

    :cond_8
    move-object/from16 v6, v19

    :goto_4
    const/4 v4, 0x4

    aput-object v6, v11, v4

    .line 296
    invoke-virtual {v8, v11}, Landroid/database/MatrixCursor;->addRow([Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_9
    return-object v8

    :cond_a
    :goto_5
    const/4 v2, 0x0

    return-object v2

    :catch_0
    move-exception v0

    .line 306
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_6
    const/4 v2, 0x0

    return-object v2

    :cond_b
    :goto_7
    const/4 v2, 0x0

    return-object v2

    :catch_1
    move-exception v0

    .line 270
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_6
.end method

.method public updateLeanback(Landroid/content/Context;)V
    .locals 17

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    .line 585
    iget-object v0, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->mNotificationManager:Landroid/app/NotificationManager;

    if-nez v0, :cond_0

    const-string v0, "notification"

    .line 587
    invoke-virtual {v2, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    iput-object v0, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->mNotificationManager:Landroid/app/NotificationManager;

    .line 589
    :cond_0
    iget-object v0, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->mRecomendationIds:Ljava/util/HashSet;

    invoke-virtual {v0}, Ljava/util/HashSet;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    .line 590
    iget-object v4, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->mNotificationManager:Landroid/app/NotificationManager;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    invoke-virtual {v4, v3}, Landroid/app/NotificationManager;->cancel(I)V

    goto :goto_0

    .line 591
    :cond_1
    iget-object v0, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->mRecomendationIds:Ljava/util/HashSet;

    invoke-virtual {v0}, Ljava/util/HashSet;->clear()V

    .line 593
    iget-object v0, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->RECOMMENDATION_MOVIES_JSON:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lorg/xbmc/kodi/XBMCJsonRPC;->request_object(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v0

    const-string v3, "poster"

    const-string v4, "title"

    const-string v5, "fanart"

    const-string v6, "thumb"

    const-string v8, "result"

    if-eqz v0, :cond_5

    .line 594
    invoke-virtual {v0, v8}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_5

    .line 598
    :try_start_0
    invoke-virtual {v0, v8}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v0

    const-string v9, "movies"

    .line 599
    invoke-virtual {v0, v9}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsJsonArray()Lcom/google/gson/JsonArray;

    move-result-object v0

    const/4 v9, 0x0

    const/4 v10, 0x0

    .line 602
    :goto_1
    invoke-virtual {v0}, Lcom/google/gson/JsonArray;->size()I

    move-result v11

    if-ge v9, v11, :cond_5

    iget v11, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->MAX_RECOMMENDATIONS:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2

    if-ge v10, v11, :cond_5

    .line 606
    :try_start_1
    invoke-virtual {v0, v9}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v11

    invoke-virtual {v11}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v11

    const-string v12, "movieid"

    .line 607
    invoke-virtual {v11, v12}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v12

    invoke-virtual {v12}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v12

    const v13, 0xf4240

    add-int/2addr v12, v13

    .line 609
    invoke-direct {v1, v11, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    .line 610
    invoke-direct {v1, v11, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 611
    invoke-direct {v1, v11, v5}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    .line 613
    new-instance v7, Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    invoke-direct {v7}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;-><init>()V

    .line 614
    invoke-virtual {v7, v2}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setContext(Landroid/content/Context;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v7
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-object/from16 v16, v0

    :try_start_2
    sget v0, Lorg/xbmc/kodi/R$drawable;->notif_icon:I

    .line 615
    invoke-virtual {v7, v0}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setSmallIcon(I)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v0

    .line 616
    invoke-virtual {v0, v12}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setId(I)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v0

    iget v7, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->MAX_RECOMMENDATIONS:I

    sub-int/2addr v7, v10

    invoke-virtual {v0, v7}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setPriority(I)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v0

    .line 617
    invoke-virtual {v11, v4}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v7

    invoke-virtual {v7}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v7}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setTitle(Ljava/lang/String;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v0

    const-string v7, "tagline"

    .line 618
    invoke-virtual {v11, v7}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v7

    invoke-virtual {v7}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v7}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setDescription(Ljava/lang/String;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v0

    .line 619
    invoke-direct {v1, v2, v11}, Lorg/xbmc/kodi/XBMCJsonRPC;->buildPendingMovieIntent(Landroid/content/Context;Lcom/google/gson/JsonObject;)Landroid/app/PendingIntent;

    move-result-object v7

    invoke-virtual {v0, v7}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setIntent(Landroid/app/PendingIntent;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v0

    if-eqz v15, :cond_2

    .line 621
    invoke-virtual {v15}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_2

    .line 624
    invoke-virtual {v1, v15}, Lorg/xbmc/kodi/XBMCJsonRPC;->getDownloadUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 623
    invoke-static {v7}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v7

    .line 624
    invoke-virtual {v7}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v7

    .line 623
    invoke-virtual {v0, v7}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setBackground(Ljava/lang/String;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    :cond_2
    if-eqz v13, :cond_3

    .line 627
    invoke-virtual {v13}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_3

    .line 629
    invoke-virtual {v1, v2, v13}, Lorg/xbmc/kodi/XBMCJsonRPC;->getBitmap(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v7

    .line 630
    invoke-virtual {v0, v7}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setBitmap(Landroid/graphics/Bitmap;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    goto :goto_2

    :cond_3
    if-eqz v14, :cond_4

    .line 632
    invoke-virtual {v14}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_4

    .line 634
    invoke-virtual {v1, v2, v14}, Lorg/xbmc/kodi/XBMCJsonRPC;->getBitmap(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v7

    .line 635
    invoke-virtual {v0, v7}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setBitmap(Landroid/graphics/Bitmap;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    .line 638
    :cond_4
    :goto_2
    invoke-virtual {v0}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->build()Landroid/app/Notification;

    move-result-object v0

    .line 639
    iget-object v7, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->mNotificationManager:Landroid/app/NotificationManager;

    invoke-virtual {v7, v12, v0}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 640
    iget-object v0, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->mRecomendationIds:Ljava/util/HashSet;

    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v0, v7}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    add-int/lit8 v10, v10, 0x1

    goto :goto_3

    :catch_0
    move-object/from16 v16, v0

    :catch_1
    :goto_3
    add-int/lit8 v9, v9, 0x1

    move-object/from16 v0, v16

    goto/16 :goto_1

    :catch_2
    move-exception v0

    .line 649
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 653
    :cond_5
    iget-object v0, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->RECOMMENDATIONS_SHOWS_JSON:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lorg/xbmc/kodi/XBMCJsonRPC;->request_object(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v0

    if-eqz v0, :cond_9

    .line 654
    invoke-virtual {v0, v8}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_9

    .line 658
    :try_start_3
    invoke-virtual {v0, v8}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v0

    const-string v7, "tvshows"

    .line 659
    invoke-virtual {v0, v7}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsJsonArray()Lcom/google/gson/JsonArray;

    move-result-object v0

    const/4 v7, 0x0

    const/4 v9, 0x0

    .line 662
    :goto_4
    invoke-virtual {v0}, Lcom/google/gson/JsonArray;->size()I

    move-result v10

    if-ge v7, v10, :cond_9

    iget v10, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->MAX_RECOMMENDATIONS:I
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_5

    if-ge v9, v10, :cond_9

    .line 666
    :try_start_4
    invoke-virtual {v0, v7}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v10

    invoke-virtual {v10}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v10

    const-string v11, "tvshowid"

    .line 667
    invoke-virtual {v10, v11}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v11

    invoke-virtual {v11}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v11

    const v12, 0x1e8480

    add-int/2addr v11, v12

    .line 669
    invoke-direct {v1, v10, v3}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .line 670
    invoke-direct {v1, v10, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    .line 671
    invoke-direct {v1, v10, v5}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 673
    new-instance v15, Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    invoke-direct {v15}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;-><init>()V

    .line 674
    invoke-virtual {v15, v2}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setContext(Landroid/content/Context;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v15
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_3

    move-object/from16 v16, v0

    :try_start_5
    sget v0, Lorg/xbmc/kodi/R$drawable;->notif_icon:I

    .line 675
    invoke-virtual {v15, v0}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setSmallIcon(I)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v0

    .line 676
    invoke-virtual {v0, v11}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setId(I)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v0

    iget v15, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->MAX_RECOMMENDATIONS:I

    sub-int/2addr v15, v9

    invoke-virtual {v0, v15}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setPriority(I)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v0

    .line 677
    invoke-virtual {v10, v4}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v15

    invoke-virtual {v15}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v0, v15}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setTitle(Ljava/lang/String;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v0

    const-string v15, "plot"

    .line 678
    invoke-virtual {v10, v15}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v15

    invoke-virtual {v15}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v0, v15}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setDescription(Ljava/lang/String;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v0

    .line 679
    invoke-direct {v1, v2, v10}, Lorg/xbmc/kodi/XBMCJsonRPC;->buildPendingShowIntent(Landroid/content/Context;Lcom/google/gson/JsonObject;)Landroid/app/PendingIntent;

    move-result-object v10

    invoke-virtual {v0, v10}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setIntent(Landroid/app/PendingIntent;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v0

    if-eqz v14, :cond_6

    .line 681
    invoke-virtual {v14}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-nez v10, :cond_6

    .line 684
    invoke-virtual {v1, v14}, Lorg/xbmc/kodi/XBMCJsonRPC;->getDownloadUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 683
    invoke-static {v10}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v10

    .line 684
    invoke-virtual {v10}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v10

    .line 683
    invoke-virtual {v0, v10}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setBackground(Ljava/lang/String;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    :cond_6
    if-eqz v12, :cond_7

    .line 687
    invoke-virtual {v12}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-nez v10, :cond_7

    .line 689
    invoke-virtual {v1, v2, v12}, Lorg/xbmc/kodi/XBMCJsonRPC;->getBitmap(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v10

    .line 690
    invoke-virtual {v0, v10}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setBitmap(Landroid/graphics/Bitmap;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    goto :goto_5

    :cond_7
    if-eqz v13, :cond_8

    .line 692
    invoke-virtual {v13}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-nez v10, :cond_8

    .line 694
    invoke-virtual {v1, v2, v13}, Lorg/xbmc/kodi/XBMCJsonRPC;->getBitmap(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v10

    .line 695
    invoke-virtual {v0, v10}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setBitmap(Landroid/graphics/Bitmap;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    .line 698
    :cond_8
    :goto_5
    invoke-virtual {v0}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->build()Landroid/app/Notification;

    move-result-object v0

    .line 699
    iget-object v10, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->mNotificationManager:Landroid/app/NotificationManager;

    invoke-virtual {v10, v11, v0}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 700
    iget-object v0, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->mRecomendationIds:Ljava/util/HashSet;

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    invoke-virtual {v0, v10}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_4

    add-int/lit8 v9, v9, 0x1

    goto :goto_6

    :catch_3
    move-object/from16 v16, v0

    :catch_4
    :goto_6
    add-int/lit8 v7, v7, 0x1

    move-object/from16 v0, v16

    goto/16 :goto_4

    :catch_5
    move-exception v0

    .line 710
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 714
    :cond_9
    iget-object v0, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->RECOMMENDATIONS_ALBUMS_JSON:Ljava/lang/String;

    invoke-virtual {v1, v0}, Lorg/xbmc/kodi/XBMCJsonRPC;->request_object(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v0

    if-eqz v0, :cond_c

    .line 715
    invoke-virtual {v0, v8}, Lcom/google/gson/JsonObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_c

    .line 719
    :try_start_6
    invoke-virtual {v0, v8}, Lcom/google/gson/JsonObject;->getAsJsonObject(Ljava/lang/String;)Lcom/google/gson/JsonObject;

    move-result-object v0

    const-string v3, "albums"

    .line 720
    invoke-virtual {v0, v3}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/gson/JsonElement;->getAsJsonArray()Lcom/google/gson/JsonArray;

    move-result-object v0

    const/4 v3, 0x0

    const/4 v7, 0x0

    .line 723
    :goto_7
    invoke-virtual {v0}, Lcom/google/gson/JsonArray;->size()I

    move-result v8

    if-ge v7, v8, :cond_c

    iget v8, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->MAX_RECOMMENDATIONS:I
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_7

    if-ge v3, v8, :cond_c

    .line 727
    :try_start_7
    invoke-virtual {v0, v7}, Lcom/google/gson/JsonArray;->get(I)Lcom/google/gson/JsonElement;

    move-result-object v8

    invoke-virtual {v8}, Lcom/google/gson/JsonElement;->getAsJsonObject()Lcom/google/gson/JsonObject;

    move-result-object v8

    const-string v9, "albumid"

    .line 728
    invoke-virtual {v8, v9}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v9

    invoke-virtual {v9}, Lcom/google/gson/JsonElement;->getAsInt()I

    move-result v9

    const v10, 0x2dc6c0

    add-int/2addr v9, v10

    .line 730
    invoke-direct {v1, v8, v6}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 731
    invoke-direct {v1, v8, v5}, Lorg/xbmc/kodi/XBMCJsonRPC;->extractKeyFromArtMap(Lcom/google/gson/JsonObject;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 733
    new-instance v12, Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    invoke-direct {v12}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;-><init>()V

    .line 734
    invoke-virtual {v12, v2}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setContext(Landroid/content/Context;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v12

    sget v13, Lorg/xbmc/kodi/R$drawable;->notif_icon:I

    .line 735
    invoke-virtual {v12, v13}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setSmallIcon(I)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v12

    .line 736
    invoke-virtual {v12, v9}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setId(I)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v12

    iget v13, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->MAX_RECOMMENDATIONS:I

    sub-int/2addr v13, v3

    invoke-virtual {v12, v13}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setPriority(I)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v12

    .line 737
    invoke-virtual {v8, v4}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v13

    invoke-virtual {v13}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setTitle(Ljava/lang/String;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v12

    const-string v13, "displayartist"

    .line 738
    invoke-virtual {v8, v13}, Lcom/google/gson/JsonObject;->get(Ljava/lang/String;)Lcom/google/gson/JsonElement;

    move-result-object v13

    invoke-virtual {v13}, Lcom/google/gson/JsonElement;->getAsString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setDescription(Ljava/lang/String;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v12

    .line 739
    invoke-direct {v1, v2, v8}, Lorg/xbmc/kodi/XBMCJsonRPC;->buildPendingAlbumIntent(Landroid/content/Context;Lcom/google/gson/JsonObject;)Landroid/app/PendingIntent;

    move-result-object v8

    invoke-virtual {v12, v8}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setIntent(Landroid/app/PendingIntent;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    move-result-object v8

    if-eqz v11, :cond_a

    .line 741
    invoke-virtual {v11}, Ljava/lang/String;->isEmpty()Z

    move-result v12

    if-nez v12, :cond_a

    .line 744
    invoke-virtual {v1, v11}, Lorg/xbmc/kodi/XBMCJsonRPC;->getDownloadUrl(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .line 743
    invoke-static {v11}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->buildUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v11

    .line 744
    invoke-virtual {v11}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v11

    .line 743
    invoke-virtual {v8, v11}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setBackground(Ljava/lang/String;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    :cond_a
    if-eqz v10, :cond_b

    .line 746
    invoke-virtual {v10}, Ljava/lang/String;->isEmpty()Z

    move-result v11

    if-nez v11, :cond_b

    .line 748
    invoke-virtual {v1, v2, v10}, Lorg/xbmc/kodi/XBMCJsonRPC;->getBitmap(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v10

    .line 749
    invoke-virtual {v8, v10}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->setBitmap(Landroid/graphics/Bitmap;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;

    .line 752
    :cond_b
    invoke-virtual {v8}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->build()Landroid/app/Notification;

    move-result-object v8

    .line 753
    iget-object v10, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->mNotificationManager:Landroid/app/NotificationManager;

    invoke-virtual {v10, v9, v8}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 754
    iget-object v8, v1, Lorg/xbmc/kodi/XBMCJsonRPC;->mRecomendationIds:Ljava/util/HashSet;

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_6

    add-int/lit8 v3, v3, 0x1

    :catch_6
    add-int/lit8 v7, v7, 0x1

    goto/16 :goto_7

    :catch_7
    move-exception v0

    .line 764
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_c
    return-void
.end method
