.class public Lorg/xbmc/kodi/XBMCSearchableActivity;
.super Landroid/app/Activity;
.source "XBMCSearchableActivity.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "Kodi"


# instance fields
.field private mListView:Landroid/widget/ListView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method private doAction(Landroid/content/Intent;)V
    .locals 3

    .line 59
    invoke-virtual {p1}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    .line 60
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "XBMCSearchableActivity: LAUNCH: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "Kodi"

    invoke-static {v2, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 62
    new-instance v1, Landroid/content/Intent;

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v1, p1, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    const-string p1, "video/*"

    .line 63
    invoke-virtual {v1, v0, p1}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 64
    const-class p1, Lorg/xbmc/kodi/Main;

    invoke-virtual {v1, p0, p1}, Landroid/content/Intent;->setClass(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    const/high16 p1, 0x1000000

    .line 65
    invoke-virtual {v1, p1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 66
    invoke-virtual {p0, v1}, Lorg/xbmc/kodi/XBMCSearchableActivity;->startActivity(Landroid/content/Intent;)V

    .line 67
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCSearchableActivity;->finish()V

    return-void
.end method

.method private handleIntent(Landroid/content/Intent;)V
    .locals 2

    .line 72
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "XBMCSearchableActivity: NEW INTENT: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "; DATA="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Kodi"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "android.intent.action.SEARCH"

    .line 74
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "query"

    .line 76
    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lorg/xbmc/kodi/XBMCSearchableActivity;->search(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    const-string v0, "android.intent.action.VIEW"

    .line 78
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "android.intent.action.GET_CONTENT"

    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 81
    :cond_1
    invoke-direct {p0, p1}, Lorg/xbmc/kodi/XBMCSearchableActivity;->doAction(Landroid/content/Intent;)V

    :cond_2
    :goto_0
    return-void
.end method

.method private search(Ljava/lang/String;)V
    .locals 12

    .line 38
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCSearchableActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "content://org.xbmc.kodi.media/search/"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 39
    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    .line 38
    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v9

    const-string p1, "COLUMN_TITLE"

    const-string v0, "COLUMN_TAGLINE"

    .line 43
    filled-new-array {p1, v0}, [Ljava/lang/String;

    move-result-object v10

    .line 47
    sget p1, Lorg/xbmc/kodi/R$id;->title:I

    sget v0, Lorg/xbmc/kodi/R$id;->tagline:I

    filled-new-array {p1, v0}, [I

    move-result-object v11

    .line 52
    new-instance p1, Landroid/widget/SimpleCursorAdapter;

    sget v8, Lorg/xbmc/kodi/R$layout;->result:I

    move-object v6, p1

    move-object v7, p0

    invoke-direct/range {v6 .. v11}, Landroid/widget/SimpleCursorAdapter;-><init>(Landroid/content/Context;ILandroid/database/Cursor;[Ljava/lang/String;[I)V

    .line 54
    iget-object v0, p0, Lorg/xbmc/kodi/XBMCSearchableActivity;->mListView:Landroid/widget/ListView;

    invoke-virtual {v0, p1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    return-void
.end method


# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .locals 0

    .line 22
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 23
    sget p1, Lorg/xbmc/kodi/R$layout;->search_result:I

    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCSearchableActivity;->setContentView(I)V

    .line 25
    sget p1, Lorg/xbmc/kodi/R$id;->searchList:I

    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCSearchableActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ListView;

    iput-object p1, p0, Lorg/xbmc/kodi/XBMCSearchableActivity;->mListView:Landroid/widget/ListView;

    .line 27
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCSearchableActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-direct {p0, p1}, Lorg/xbmc/kodi/XBMCSearchableActivity;->handleIntent(Landroid/content/Intent;)V

    return-void
.end method

.method public onNewIntent(Landroid/content/Intent;)V
    .locals 0

    .line 32
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/XBMCSearchableActivity;->setIntent(Landroid/content/Intent;)V

    .line 33
    invoke-virtual {p0}, Lorg/xbmc/kodi/XBMCSearchableActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-direct {p0, p1}, Lorg/xbmc/kodi/XBMCSearchableActivity;->handleIntent(Landroid/content/Intent;)V

    return-void
.end method
