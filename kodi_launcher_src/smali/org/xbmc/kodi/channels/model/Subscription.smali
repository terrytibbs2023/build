.class public Lorg/xbmc/kodi/channels/model/Subscription;
.super Ljava/lang/Object;
.source "Subscription.java"


# instance fields
.field private channelId:J

.field private channelLogo:I

.field private name:Ljava/lang/String;

.field private uri:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 0

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    iput-object p1, p0, Lorg/xbmc/kodi/channels/model/Subscription;->name:Ljava/lang/String;

    .line 37
    iput-object p2, p0, Lorg/xbmc/kodi/channels/model/Subscription;->uri:Ljava/lang/String;

    .line 38
    iput p3, p0, Lorg/xbmc/kodi/channels/model/Subscription;->channelLogo:I

    return-void
.end method

.method public static createSubscription(Ljava/lang/String;Ljava/lang/String;I)Lorg/xbmc/kodi/channels/model/Subscription;
    .locals 1

    .line 44
    new-instance v0, Lorg/xbmc/kodi/channels/model/Subscription;

    invoke-direct {v0, p0, p1, p2}, Lorg/xbmc/kodi/channels/model/Subscription;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

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

    if-eqz p1, :cond_4

    .line 91
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    if-eq v2, v3, :cond_1

    goto :goto_1

    .line 93
    :cond_1
    check-cast p1, Lorg/xbmc/kodi/channels/model/Subscription;

    .line 95
    iget-object v2, p0, Lorg/xbmc/kodi/channels/model/Subscription;->name:Ljava/lang/String;

    iget-object p1, p1, Lorg/xbmc/kodi/channels/model/Subscription;->name:Ljava/lang/String;

    if-eqz v2, :cond_2

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_0

    :cond_2
    if-nez p1, :cond_3

    goto :goto_0

    :cond_3
    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_4
    :goto_1
    return v1
.end method

.method public getChannelId()J
    .locals 2

    .line 49
    iget-wide v0, p0, Lorg/xbmc/kodi/channels/model/Subscription;->channelId:J

    return-wide v0
.end method

.method public getChannelLogo()I
    .locals 1

    .line 79
    iget v0, p0, Lorg/xbmc/kodi/channels/model/Subscription;->channelLogo:I

    return v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .line 59
    iget-object v0, p0, Lorg/xbmc/kodi/channels/model/Subscription;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getUri()Ljava/lang/String;
    .locals 1

    .line 69
    iget-object v0, p0, Lorg/xbmc/kodi/channels/model/Subscription;->uri:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 1

    .line 101
    iget-object v0, p0, Lorg/xbmc/kodi/channels/model/Subscription;->name:Ljava/lang/String;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public setChannelId(J)V
    .locals 0

    .line 54
    iput-wide p1, p0, Lorg/xbmc/kodi/channels/model/Subscription;->channelId:J

    return-void
.end method

.method public setChannelLogo(I)V
    .locals 0

    .line 84
    iput p1, p0, Lorg/xbmc/kodi/channels/model/Subscription;->channelLogo:I

    return-void
.end method

.method public setName(Ljava/lang/String;)V
    .locals 0

    .line 64
    iput-object p1, p0, Lorg/xbmc/kodi/channels/model/Subscription;->name:Ljava/lang/String;

    return-void
.end method

.method public setUri(Ljava/lang/String;)V
    .locals 0

    .line 74
    iput-object p1, p0, Lorg/xbmc/kodi/channels/model/Subscription;->uri:Ljava/lang/String;

    return-void
.end method
