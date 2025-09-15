.class Lorg/xbmc/kodi/Splash$FillCache;
.super Ljava/lang/Object;
.source "Splash.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/xbmc/kodi/Splash;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "FillCache"
.end annotation


# instance fields
.field private executor:Ljava/util/concurrent/ExecutorService;

.field private handler:Landroid/os/Handler;

.field private mProgressStatus:I

.field private mSplash:Lorg/xbmc/kodi/Splash;

.field final synthetic this$0:Lorg/xbmc/kodi/Splash;


# direct methods
.method public constructor <init>(Lorg/xbmc/kodi/Splash;Lorg/xbmc/kodi/Splash;)V
    .locals 0

    .line 243
    iput-object p1, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    .line 238
    iput p1, p0, Lorg/xbmc/kodi/Splash$FillCache;->mProgressStatus:I

    .line 244
    iput-object p2, p0, Lorg/xbmc/kodi/Splash$FillCache;->mSplash:Lorg/xbmc/kodi/Splash;

    .line 245
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object p1

    iput-object p1, p0, Lorg/xbmc/kodi/Splash$FillCache;->executor:Ljava/util/concurrent/ExecutorService;

    .line 246
    new-instance p1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object p2

    invoke-direct {p1, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object p1, p0, Lorg/xbmc/kodi/Splash$FillCache;->handler:Landroid/os/Handler;

    return-void
.end method


# virtual methods
.method DeleteRecursive(Ljava/io/File;)V
    .locals 4

    .line 264
    invoke-virtual {p1}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 265
    invoke-virtual {p1}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget-object v3, v0, v2

    .line 266
    invoke-virtual {p0, v3}, Lorg/xbmc/kodi/Splash$FillCache;->DeleteRecursive(Ljava/io/File;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 268
    :cond_0
    invoke-virtual {p1}, Ljava/io/File;->delete()Z

    return-void
.end method

.method protected doInBackground()Ljava/lang/Integer;
    .locals 12

    .line 273
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v0}, Lorg/xbmc/kodi/Splash;->access$1000(Lorg/xbmc/kodi/Splash;)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    const-string v1, "Kodi"

    if-eqz v0, :cond_0

    .line 276
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v0}, Lorg/xbmc/kodi/Splash;->access$200(Lorg/xbmc/kodi/Splash;)Lorg/xbmc/kodi/Splash$StateMachine;

    move-result-object v0

    const/4 v2, 0x4

    invoke-virtual {v0, v2}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    .line 277
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "Removing existing "

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v2}, Lorg/xbmc/kodi/Splash;->access$1000(Lorg/xbmc/kodi/Splash;)Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 278
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v0}, Lorg/xbmc/kodi/Splash;->access$1000(Lorg/xbmc/kodi/Splash;)Ljava/io/File;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/xbmc/kodi/Splash$FillCache;->DeleteRecursive(Ljava/io/File;)V

    .line 280
    :cond_0
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v0}, Lorg/xbmc/kodi/Splash;->access$1000(Lorg/xbmc/kodi/Splash;)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    .line 282
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "apk: "

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v2}, Lorg/xbmc/kodi/Splash;->access$1200(Lorg/xbmc/kodi/Splash;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 283
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "output: "

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v3}, Lorg/xbmc/kodi/Splash;->access$1300(Lorg/xbmc/kodi/Splash;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v0, 0x1000

    new-array v0, v0, [B

    const/4 v3, -0x1

    .line 290
    :try_start_0
    new-instance v4, Ljava/util/zip/ZipFile;

    iget-object v5, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v5}, Lorg/xbmc/kodi/Splash;->access$1200(Lorg/xbmc/kodi/Splash;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/util/zip/ZipFile;-><init>(Ljava/lang/String;)V

    .line 291
    invoke-virtual {v4}, Ljava/util/zip/ZipFile;->entries()Ljava/util/Enumeration;

    move-result-object v5

    .line 292
    iget-object v6, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v6}, Lorg/xbmc/kodi/Splash;->access$400(Lorg/xbmc/kodi/Splash;)Landroid/widget/ProgressBar;

    move-result-object v6

    const/4 v7, 0x0

    invoke-virtual {v6, v7}, Landroid/widget/ProgressBar;->setProgress(I)V

    .line 293
    iget-object v6, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v6}, Lorg/xbmc/kodi/Splash;->access$400(Lorg/xbmc/kodi/Splash;)Landroid/widget/ProgressBar;

    move-result-object v6

    invoke-virtual {v4}, Ljava/util/zip/ZipFile;->size()I

    move-result v8

    invoke-virtual {v6, v8}, Landroid/widget/ProgressBar;->setMax(I)V

    .line 295
    iget-object v6, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    const/4 v8, 0x5

    invoke-static {v6, v8}, Lorg/xbmc/kodi/Splash;->access$002(Lorg/xbmc/kodi/Splash;I)I

    .line 296
    iget v6, p0, Lorg/xbmc/kodi/Splash$FillCache;->mProgressStatus:I

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-virtual {p0, v6}, Lorg/xbmc/kodi/Splash$FillCache;->publishProgress(Ljava/lang/Integer;)V

    .line 298
    iget-object v6, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v6}, Lorg/xbmc/kodi/Splash;->access$1000(Lorg/xbmc/kodi/Splash;)Ljava/io/File;

    move-result-object v6

    invoke-virtual {v6}, Ljava/io/File;->getCanonicalPath()Ljava/lang/String;

    move-result-object v6

    .line 299
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 301
    :goto_0
    invoke-interface {v5}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v2

    if-eqz v2, :cond_5

    .line 304
    iget v2, p0, Lorg/xbmc/kodi/Splash$FillCache;->mProgressStatus:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lorg/xbmc/kodi/Splash$FillCache;->mProgressStatus:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {p0, v2}, Lorg/xbmc/kodi/Splash$FillCache;->publishProgress(Ljava/lang/Integer;)V

    .line 306
    invoke-interface {v5}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/zip/ZipEntry;

    .line 307
    invoke-virtual {v2}, Ljava/util/zip/ZipEntry;->getName()Ljava/lang/String;

    move-result-object v8

    const-string v9, "assets/"

    .line 309
    invoke-virtual {v8, v9}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v9

    if-nez v9, :cond_1

    goto :goto_0

    .line 312
    :cond_1
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v10, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v10}, Lorg/xbmc/kodi/Splash;->access$1300(Lorg/xbmc/kodi/Splash;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v10, "/"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 313
    new-instance v9, Ljava/io/File;

    invoke-direct {v9, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 316
    invoke-virtual {v9}, Ljava/io/File;->getCanonicalPath()Ljava/lang/String;

    move-result-object v10

    .line 317
    invoke-virtual {v10, v6}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v11

    if-nez v11, :cond_2

    .line 318
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Unsafe unzipping pattern: "

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 322
    :cond_2
    invoke-virtual {v2}, Ljava/util/zip/ZipEntry;->isDirectory()Z

    move-result v10

    if-eqz v10, :cond_3

    .line 324
    invoke-virtual {v9}, Ljava/io/File;->mkdirs()Z

    goto :goto_0

    .line 327
    :cond_3
    invoke-virtual {v9}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v9

    invoke-virtual {v9}, Ljava/io/File;->mkdirs()Z
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 331
    :try_start_1
    invoke-virtual {v4, v2}, Ljava/util/zip/ZipFile;->getInputStream(Ljava/util/zip/ZipEntry;)Ljava/io/InputStream;

    move-result-object v2

    .line 332
    new-instance v9, Ljava/io/FileOutputStream;

    invoke-direct {v9, v8}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V

    .line 333
    :goto_1
    invoke-virtual {v2, v0}, Ljava/io/InputStream;->read([B)I

    move-result v8

    if-lez v8, :cond_4

    .line 334
    invoke-virtual {v9, v0, v7, v8}, Ljava/io/FileOutputStream;->write([BII)V

    goto :goto_1

    .line 336
    :cond_4
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    .line 337
    invoke-virtual {v9}, Ljava/io/FileOutputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_2

    goto/16 :goto_0

    :catch_0
    move-exception v2

    .line 341
    :try_start_2
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto/16 :goto_0

    .line 345
    :cond_5
    invoke-virtual {v4}, Ljava/util/zip/ZipFile;->close()V

    .line 347
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v0}, Lorg/xbmc/kodi/Splash;->access$1000(Lorg/xbmc/kodi/Splash;)Ljava/io/File;

    move-result-object v0

    iget-object v1, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v1}, Lorg/xbmc/kodi/Splash;->access$1100(Lorg/xbmc/kodi/Splash;)Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->lastModified()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/io/File;->setLastModified(J)Z
    :try_end_2
    .catch Ljava/io/FileNotFoundException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    .line 365
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    const/4 v1, 0x6

    invoke-static {v0, v1}, Lorg/xbmc/kodi/Splash;->access$002(Lorg/xbmc/kodi/Splash;I)I

    .line 366
    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/xbmc/kodi/Splash$FillCache;->publishProgress(Ljava/lang/Integer;)V

    .line 368
    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    return-object v0

    :catch_1
    move-exception v0

    .line 358
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 359
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    const-string v1, "Cannot read package."

    invoke-static {v0, v1}, Lorg/xbmc/kodi/Splash;->access$102(Lorg/xbmc/kodi/Splash;Ljava/lang/String;)Ljava/lang/String;

    .line 360
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v1}, Lorg/xbmc/kodi/Splash;->access$1200(Lorg/xbmc/kodi/Splash;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 361
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 362
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    return-object v0

    :catch_2
    move-exception v0

    .line 352
    invoke-virtual {v0}, Ljava/io/FileNotFoundException;->printStackTrace()V

    .line 353
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    const-string v1, "Cannot find package."

    invoke-static {v0, v1}, Lorg/xbmc/kodi/Splash;->access$102(Lorg/xbmc/kodi/Splash;Ljava/lang/String;)Ljava/lang/String;

    .line 354
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    return-object v0
.end method

.method public execute()V
    .locals 2

    .line 251
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache;->executor:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lorg/xbmc/kodi/Splash$FillCache$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0}, Lorg/xbmc/kodi/Splash$FillCache$$ExternalSyntheticLambda2;-><init>(Lorg/xbmc/kodi/Splash$FillCache;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method synthetic lambda$execute$0$org-xbmc-kodi-Splash$FillCache(Ljava/lang/Integer;)V
    .locals 0

    .line 253
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/Splash$FillCache;->onPostExecute(Ljava/lang/Integer;)V

    return-void
.end method

.method synthetic lambda$execute$1$org-xbmc-kodi-Splash$FillCache()V
    .locals 3

    .line 252
    invoke-virtual {p0}, Lorg/xbmc/kodi/Splash$FillCache;->doInBackground()Ljava/lang/Integer;

    move-result-object v0

    .line 253
    iget-object v1, p0, Lorg/xbmc/kodi/Splash$FillCache;->handler:Landroid/os/Handler;

    new-instance v2, Lorg/xbmc/kodi/Splash$FillCache$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0, v0}, Lorg/xbmc/kodi/Splash$FillCache$$ExternalSyntheticLambda0;-><init>(Lorg/xbmc/kodi/Splash$FillCache;Ljava/lang/Integer;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method synthetic lambda$publishProgress$2$org-xbmc-kodi-Splash$FillCache(Ljava/lang/Integer;)V
    .locals 0

    .line 259
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/Splash$FillCache;->onProgressUpdate(Ljava/lang/Integer;)V

    return-void
.end method

.method protected onPostExecute(Ljava/lang/Integer;)V
    .locals 1

    .line 388
    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    if-gez p1, :cond_0

    .line 390
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    const/4 v0, 0x1

    invoke-static {p1, v0}, Lorg/xbmc/kodi/Splash;->access$002(Lorg/xbmc/kodi/Splash;I)I

    .line 393
    :cond_0
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$200(Lorg/xbmc/kodi/Splash;)Lorg/xbmc/kodi/Splash$StateMachine;

    move-result-object p1

    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v0}, Lorg/xbmc/kodi/Splash;->access$000(Lorg/xbmc/kodi/Splash;)I

    move-result v0

    invoke-virtual {p1, v0}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    return-void
.end method

.method protected onProgressUpdate(Ljava/lang/Integer;)V
    .locals 2

    .line 373
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {v0}, Lorg/xbmc/kodi/Splash;->access$000(Lorg/xbmc/kodi/Splash;)I

    move-result v0

    const/4 v1, 0x5

    if-eq v0, v1, :cond_1

    const/4 p1, 0x6

    if-eq v0, p1, :cond_0

    goto :goto_0

    .line 381
    :cond_0
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$FillCache;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$400(Lorg/xbmc/kodi/Splash;)Landroid/widget/ProgressBar;

    move-result-object p1

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/widget/ProgressBar;->setVisibility(I)V

    goto :goto_0

    .line 376
    :cond_1
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {v0}, Lorg/xbmc/kodi/Splash;->access$300(Lorg/xbmc/kodi/Splash;)Landroid/widget/TextView;

    move-result-object v0

    const-string v1, "Preparing for first run. Please wait..."

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 377
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {v0}, Lorg/xbmc/kodi/Splash;->access$400(Lorg/xbmc/kodi/Splash;)Landroid/widget/ProgressBar;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    .line 378
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {v0}, Lorg/xbmc/kodi/Splash;->access$400(Lorg/xbmc/kodi/Splash;)Landroid/widget/ProgressBar;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    invoke-virtual {v0, p1}, Landroid/widget/ProgressBar;->setProgress(I)V

    :goto_0
    return-void
.end method

.method protected publishProgress(Ljava/lang/Integer;)V
    .locals 2

    .line 259
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$FillCache;->handler:Landroid/os/Handler;

    new-instance v1, Lorg/xbmc/kodi/Splash$FillCache$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0, p1}, Lorg/xbmc/kodi/Splash$FillCache$$ExternalSyntheticLambda1;-><init>(Lorg/xbmc/kodi/Splash$FillCache;Ljava/lang/Integer;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
