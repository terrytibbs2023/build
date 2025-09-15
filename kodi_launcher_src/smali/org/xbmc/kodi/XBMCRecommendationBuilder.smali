.class public Lorg/xbmc/kodi/XBMCRecommendationBuilder;
.super Ljava/lang/Object;
.source "XBMCRecommendationBuilder.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "Kodi"


# instance fields
.field final API_NOTIFICATION_CATEGORY_RECOMMENDATION:Ljava/lang/String;

.field final API_NOTIFICATION_EXTRA_BACKGROUND_IMAGE_URI:Ljava/lang/String;

.field private mBackgroundUri:Ljava/lang/String;

.field private mBitmap:Landroid/graphics/Bitmap;

.field private mContext:Landroid/content/Context;

.field private mDescription:Ljava/lang/String;

.field private mId:I

.field private mIntent:Landroid/app/PendingIntent;

.field private mPriority:I

.field private mSmallIcon:I

.field private mTitle:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "android.backgroundImageUri"

    .line 31
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->API_NOTIFICATION_EXTRA_BACKGROUND_IMAGE_URI:Ljava/lang/String;

    const-string v0, "recommendation"

    .line 32
    iput-object v0, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->API_NOTIFICATION_CATEGORY_RECOMMENDATION:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public build()Landroid/app/Notification;
    .locals 5

    .line 95
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Building notification - "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Kodi"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 97
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 98
    iget-object v2, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mBackgroundUri:Ljava/lang/String;

    if-eqz v2, :cond_0

    .line 100
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Background - "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mBackgroundUri:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v1, "android.backgroundImageUri"

    .line 101
    iget-object v2, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mBackgroundUri:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 104
    :cond_0
    new-instance v1, Landroid/app/Notification$BigPictureStyle;

    new-instance v2, Landroid/app/Notification$Builder;

    iget-object v3, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mContext:Landroid/content/Context;

    invoke-direct {v2, v3}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V

    iget-object v3, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mTitle:Ljava/lang/String;

    .line 106
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v2

    iget-object v3, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mDescription:Ljava/lang/String;

    .line 107
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v2

    iget v3, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mPriority:I

    .line 108
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setPriority(I)Landroid/app/Notification$Builder;

    move-result-object v2

    const/4 v3, 0x1

    .line 109
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setLocalOnly(Z)Landroid/app/Notification$Builder;

    move-result-object v2

    .line 110
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;

    move-result-object v2

    iget-object v3, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mContext:Landroid/content/Context;

    .line 111
    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    sget v4, Lorg/xbmc/kodi/R$color;->recommendation_color:I

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getColor(I)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setColor(I)Landroid/app/Notification$Builder;

    move-result-object v2

    const-string v3, "recommendation"

    .line 112
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setCategory(Ljava/lang/String;)Landroid/app/Notification$Builder;

    move-result-object v2

    iget-object v3, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mBitmap:Landroid/graphics/Bitmap;

    .line 113
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setLargeIcon(Landroid/graphics/Bitmap;)Landroid/app/Notification$Builder;

    move-result-object v2

    iget v3, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mSmallIcon:I

    .line 114
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v2

    iget-object v3, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mIntent:Landroid/app/PendingIntent;

    .line 115
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v2

    .line 116
    invoke-virtual {v2, v0}, Landroid/app/Notification$Builder;->setExtras(Landroid/os/Bundle;)Landroid/app/Notification$Builder;

    move-result-object v0

    const/4 v2, 0x0

    .line 117
    invoke-virtual {v0, v2}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;

    move-result-object v0

    invoke-direct {v1, v0}, Landroid/app/Notification$BigPictureStyle;-><init>(Landroid/app/Notification$Builder;)V

    .line 118
    invoke-virtual {v1}, Landroid/app/Notification$BigPictureStyle;->build()Landroid/app/Notification;

    move-result-object v0

    return-object v0
.end method

.method public setBackground(Ljava/lang/String;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;
    .locals 0

    .line 76
    iput-object p1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mBackgroundUri:Ljava/lang/String;

    return-object p0
.end method

.method public setBitmap(Landroid/graphics/Bitmap;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;
    .locals 0

    .line 70
    iput-object p1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mBitmap:Landroid/graphics/Bitmap;

    return-object p0
.end method

.method public setContext(Landroid/content/Context;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;
    .locals 0

    .line 40
    iput-object p1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mContext:Landroid/content/Context;

    return-object p0
.end method

.method public setDescription(Ljava/lang/String;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;
    .locals 0

    .line 64
    iput-object p1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mDescription:Ljava/lang/String;

    return-object p0
.end method

.method public setId(I)Lorg/xbmc/kodi/XBMCRecommendationBuilder;
    .locals 0

    .line 46
    iput p1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mId:I

    return-object p0
.end method

.method public setIntent(Landroid/app/PendingIntent;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;
    .locals 0

    .line 82
    iput-object p1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mIntent:Landroid/app/PendingIntent;

    return-object p0
.end method

.method public setPriority(I)Lorg/xbmc/kodi/XBMCRecommendationBuilder;
    .locals 0

    .line 52
    iput p1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mPriority:I

    return-object p0
.end method

.method public setSmallIcon(I)Lorg/xbmc/kodi/XBMCRecommendationBuilder;
    .locals 0

    .line 88
    iput p1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mSmallIcon:I

    return-object p0
.end method

.method public setTitle(Ljava/lang/String;)Lorg/xbmc/kodi/XBMCRecommendationBuilder;
    .locals 0

    .line 58
    iput-object p1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mTitle:Ljava/lang/String;

    return-object p0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 126
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "RecommendationBuilder{, mId="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mId:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", mPriority="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mPriority:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", mSmallIcon="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mSmallIcon:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", mTitle=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mTitle:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\', mDescription=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mDescription:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\', mBitmap=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mBitmap:Landroid/graphics/Bitmap;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, "\', mBackgroundUri=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mBackgroundUri:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\', mIntent="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lorg/xbmc/kodi/XBMCRecommendationBuilder;->mIntent:Landroid/app/PendingIntent;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
