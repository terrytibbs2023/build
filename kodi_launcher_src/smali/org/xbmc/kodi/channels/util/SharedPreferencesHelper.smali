.class public final Lorg/xbmc/kodi/channels/util/SharedPreferencesHelper;
.super Ljava/lang/Object;
.source "SharedPreferencesHelper.java"


# static fields
.field private static final PREFS_NAME:Ljava/lang/String; = "org.xbmc.kodi"

.field private static final PREFS_SUBSCRIBED_MediaS_PREFIX:Ljava/lang/String; = "org.xbmc.kodi.prefs.SUBSCRIBED_MediaS_"

.field private static final PREFS_SUBSCRIPTIONS_KEY:Ljava/lang/String; = "org.xbmc.kodi.prefs.SUBSCRIPTIONS"

.field private static final TAG:Ljava/lang/String; = "Kodi"

.field private static final mGson:Lcom/google/gson/Gson;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 50
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    sput-object v0, Lorg/xbmc/kodi/channels/util/SharedPreferencesHelper;->mGson:Lcom/google/gson/Gson;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static getList(Landroid/content/Context;Ljava/lang/Class;Ljava/lang/String;)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Landroid/content/Context;",
            "Ljava/lang/Class<",
            "TT;>;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "TT;>;"
        }
    .end annotation

    const-string v0, "org.xbmc.kodi"

    const/4 v1, 0x0

    .line 107
    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    .line 108
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    invoke-interface {p0, p2, v0}, Landroid/content/SharedPreferences;->getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;

    move-result-object p0

    .line 109
    invoke-interface {p0}, Ljava/util/Set;->isEmpty()Z

    move-result p2

    if-eqz p2, :cond_0

    .line 111
    new-instance p0, Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/util/ArrayList;-><init>()V

    return-object p0

    .line 113
    :cond_0
    new-instance p2, Ljava/util/ArrayList;

    invoke-interface {p0}, Ljava/util/Set;->size()I

    move-result v0

    invoke-direct {p2, v0}, Ljava/util/ArrayList;-><init>(I)V

    .line 115
    :try_start_0
    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 116
    sget-object v1, Lorg/xbmc/kodi/channels/util/SharedPreferencesHelper;->mGson:Lcom/google/gson/Gson;

    invoke-virtual {v1, v0, p1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Lcom/google/gson/JsonSyntaxException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :cond_1
    return-object p2

    :catch_0
    move-exception p0

    const-string p1, "Kodi"

    const-string p2, "SharedPreferencesHelper: Could not parse json."

    .line 119
    invoke-static {p1, p2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 120
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method public static readMedias(Landroid/content/Context;J)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "J)",
            "Ljava/util/List<",
            "Lorg/xbmc/kodi/model/Media;",
            ">;"
        }
    .end annotation

    .line 80
    const-class v0, Lorg/xbmc/kodi/model/Media;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "org.xbmc.kodi.prefs.SUBSCRIBED_MediaS_"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, v0, p1}, Lorg/xbmc/kodi/channels/util/SharedPreferencesHelper;->getList(Landroid/content/Context;Ljava/lang/Class;Ljava/lang/String;)Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method public static readSubscriptions(Landroid/content/Context;)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/List<",
            "Lorg/xbmc/kodi/channels/model/Subscription;",
            ">;"
        }
    .end annotation

    .line 59
    const-class v0, Lorg/xbmc/kodi/channels/model/Subscription;

    const-string v1, "org.xbmc.kodi.prefs.SUBSCRIPTIONS"

    invoke-static {p0, v0, v1}, Lorg/xbmc/kodi/channels/util/SharedPreferencesHelper;->getList(Landroid/content/Context;Ljava/lang/Class;Ljava/lang/String;)Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method private static setList(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "TT;>;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    const-string v0, "org.xbmc.kodi"

    const/4 v1, 0x0

    .line 135
    invoke-virtual {p0, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    .line 136
    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p0

    .line 138
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/util/LinkedHashSet;-><init>(I)V

    .line 139
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    .line 140
    sget-object v2, Lorg/xbmc/kodi/channels/util/SharedPreferencesHelper;->mGson:Lcom/google/gson/Gson;

    invoke-virtual {v2, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 142
    :cond_0
    invoke-interface {p0, p2, v0}, Landroid/content/SharedPreferences$Editor;->putStringSet(Ljava/lang/String;Ljava/util/Set;)Landroid/content/SharedPreferences$Editor;

    .line 143
    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method public static storeMedias(Landroid/content/Context;JLjava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "J",
            "Ljava/util/List<",
            "Lorg/xbmc/kodi/model/Media;",
            ">;)V"
        }
    .end annotation

    .line 91
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "org.xbmc.kodi.prefs.SUBSCRIBED_MediaS_"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p3, p1}, Lorg/xbmc/kodi/channels/util/SharedPreferencesHelper;->setList(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;)V

    return-void
.end method

.method public static storeSubscriptions(Landroid/content/Context;Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lorg/xbmc/kodi/channels/model/Subscription;",
            ">;)V"
        }
    .end annotation

    const-string v0, "org.xbmc.kodi.prefs.SUBSCRIPTIONS"

    .line 69
    invoke-static {p0, p1, v0}, Lorg/xbmc/kodi/channels/util/SharedPreferencesHelper;->setList(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;)V

    return-void
.end method
