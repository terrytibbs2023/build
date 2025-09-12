.class public final Lorg/xbmc/kodi/channels/model/XBMCDatabase;
.super Ljava/lang/Object;
.source "XBMCDatabase.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static findMedia(Ljava/util/List;Lorg/xbmc/kodi/model/Media;)I
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lorg/xbmc/kodi/model/Media;",
            ">;",
            "Lorg/xbmc/kodi/model/Media;",
            ")I"
        }
    .end annotation

    const/4 v0, 0x0

    .line 210
    :goto_0
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v1

    if-ge v0, v1, :cond_1

    .line 212
    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/xbmc/kodi/model/Media;

    .line 213
    invoke-virtual {v1}, Lorg/xbmc/kodi/model/Media;->getId()J

    move-result-wide v1

    invoke-virtual {p1}, Lorg/xbmc/kodi/model/Media;->getId()J

    move-result-wide v3

    cmp-long v5, v1, v3

    if-nez v5, :cond_0

    return v0

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    const/4 p0, -0x1

    return p0
.end method

.method public static findMediaById(Landroid/content/Context;JJ)Lorg/xbmc/kodi/model/Media;
    .locals 2

    .line 244
    invoke-static {p0, p1, p2}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->getMedias(Landroid/content/Context;J)Ljava/util/List;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lorg/xbmc/kodi/model/Media;

    .line 246
    invoke-virtual {p1}, Lorg/xbmc/kodi/model/Media;->getId()J

    move-result-wide v0

    cmp-long p2, v0, p3

    if-nez p2, :cond_0

    return-object p1

    :cond_1
    const/4 p0, 0x0

    return-object p0
.end method

.method private static findOrCreateSubscription(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)Lorg/xbmc/kodi/channels/model/Subscription;
    .locals 0

    .line 54
    invoke-static {p0, p1}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->findSubscriptionByTitle(Landroid/content/Context;Ljava/lang/String;)Lorg/xbmc/kodi/channels/model/Subscription;

    move-result-object p0

    if-eqz p0, :cond_0

    return-object p0

    .line 60
    :cond_0
    invoke-static {p1, p2, p3}, Lorg/xbmc/kodi/channels/model/Subscription;->createSubscription(Ljava/lang/String;Ljava/lang/String;I)Lorg/xbmc/kodi/channels/model/Subscription;

    move-result-object p0

    return-object p0
.end method

.method public static findSubscriptionByChannelId(Landroid/content/Context;J)Lorg/xbmc/kodi/channels/model/Subscription;
    .locals 4

    .line 132
    invoke-static {p0}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->getSubscriptions(Landroid/content/Context;)Ljava/util/List;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/xbmc/kodi/channels/model/Subscription;

    .line 134
    invoke-virtual {v0}, Lorg/xbmc/kodi/channels/model/Subscription;->getChannelId()J

    move-result-wide v1

    cmp-long v3, v1, p1

    if-nez v3, :cond_0

    return-object v0

    :cond_1
    const/4 p0, 0x0

    return-object p0
.end method

.method public static findSubscriptionByName(Landroid/content/Context;Ljava/lang/String;)Lorg/xbmc/kodi/channels/model/Subscription;
    .locals 2

    .line 152
    invoke-static {p0}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->getSubscriptions(Landroid/content/Context;)Ljava/util/List;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/xbmc/kodi/channels/model/Subscription;

    .line 154
    invoke-virtual {v0}, Lorg/xbmc/kodi/channels/model/Subscription;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    return-object v0

    :cond_1
    const/4 p0, 0x0

    return-object p0
.end method

.method private static findSubscriptionByTitle(Landroid/content/Context;Ljava/lang/String;)Lorg/xbmc/kodi/channels/model/Subscription;
    .locals 2

    .line 69
    invoke-static {p0}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->getSubscriptions(Landroid/content/Context;)Ljava/util/List;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/xbmc/kodi/channels/model/Subscription;

    .line 71
    invoke-virtual {v0}, Lorg/xbmc/kodi/channels/model/Subscription;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    return-object v0

    :cond_1
    const/4 p0, 0x0

    return-object p0
.end method

.method public static getMedias(Landroid/content/Context;J)Ljava/util/List;
    .locals 0
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

    .line 230
    invoke-static {p0, p1, p2}, Lorg/xbmc/kodi/channels/util/SharedPreferencesHelper;->readMedias(Landroid/content/Context;J)Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method public static getSubscription(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Lorg/xbmc/kodi/channels/model/Subscription;
    .locals 1

    .line 40
    sget v0, Lorg/xbmc/kodi/R$drawable;->ic_recommendation_80dp:I

    invoke-static {p0, p1, p2, v0}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->findOrCreateSubscription(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)Lorg/xbmc/kodi/channels/model/Subscription;

    move-result-object p0

    return-object p0
.end method

.method public static getSubscriptions(Landroid/content/Context;)Ljava/util/List;
    .locals 0
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

    .line 119
    invoke-static {p0}, Lorg/xbmc/kodi/channels/util/SharedPreferencesHelper;->readSubscriptions(Landroid/content/Context;)Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method public static removeMedias(Landroid/content/Context;J)V
    .locals 1

    .line 183
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    invoke-static {p0, p1, p2, v0}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->saveMedias(Landroid/content/Context;JLjava/util/List;)V

    return-void
.end method

.method public static saveMedia(Landroid/content/Context;JLorg/xbmc/kodi/model/Media;)V
    .locals 3

    .line 196
    invoke-static {p0, p1, p2}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->getMedias(Landroid/content/Context;J)Ljava/util/List;

    move-result-object v0

    .line 197
    invoke-static {v0, p3}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->findMedia(Ljava/util/List;Lorg/xbmc/kodi/model/Media;)I

    move-result v1

    const/4 v2, -0x1

    if-ne v1, v2, :cond_0

    .line 200
    invoke-interface {v0, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 203
    :cond_0
    invoke-interface {v0, v1, p3}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 205
    :goto_0
    invoke-static {p0, p1, p2, v0}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->saveMedias(Landroid/content/Context;JLjava/util/List;)V

    return-void
.end method

.method public static saveMedias(Landroid/content/Context;JLjava/util/List;)V
    .locals 0
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

    .line 171
    invoke-static {p0, p1, p2, p3}, Lorg/xbmc/kodi/channels/util/SharedPreferencesHelper;->storeMedias(Landroid/content/Context;JLjava/util/List;)V

    return-void
.end method

.method public static saveSubscription(Landroid/content/Context;Lorg/xbmc/kodi/channels/model/Subscription;)V
    .locals 3

    .line 99
    invoke-static {p0}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->getSubscriptions(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    .line 100
    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v1

    const/4 v2, -0x1

    if-ne v1, v2, :cond_0

    .line 103
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 106
    :cond_0
    invoke-interface {v0, v1, p1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 108
    :goto_0
    invoke-static {p0, v0}, Lorg/xbmc/kodi/channels/model/XBMCDatabase;->saveSubscriptions(Landroid/content/Context;Ljava/util/List;)V

    return-void
.end method

.method public static saveSubscriptions(Landroid/content/Context;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lorg/xbmc/kodi/channels/model/Subscription;",
            ">;)V"
        }
    .end annotation

    .line 87
    invoke-static {p0, p1}, Lorg/xbmc/kodi/channels/util/SharedPreferencesHelper;->storeSubscriptions(Landroid/content/Context;Ljava/util/List;)V

    return-void
.end method
