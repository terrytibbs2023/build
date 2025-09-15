.class public final synthetic Lorg/xbmc/kodi/Splash$FillCache$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lorg/xbmc/kodi/Splash$FillCache;

.field public final synthetic f$1:Ljava/lang/Integer;


# direct methods
.method public synthetic constructor <init>(Lorg/xbmc/kodi/Splash$FillCache;Ljava/lang/Integer;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lorg/xbmc/kodi/Splash$FillCache$$ExternalSyntheticLambda0;->f$0:Lorg/xbmc/kodi/Splash$FillCache;

    iput-object p2, p0, Lorg/xbmc/kodi/Splash$FillCache$$ExternalSyntheticLambda0;->f$1:Ljava/lang/Integer;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache$$ExternalSyntheticLambda0;->f$0:Lorg/xbmc/kodi/Splash$FillCache;

    iget-object v1, p0, Lorg/xbmc/kodi/Splash$FillCache$$ExternalSyntheticLambda0;->f$1:Ljava/lang/Integer;

    invoke-virtual {v0, v1}, Lorg/xbmc/kodi/Splash$FillCache;->lambda$execute$0$org-xbmc-kodi-Splash$FillCache(Ljava/lang/Integer;)V

    return-void
.end method
