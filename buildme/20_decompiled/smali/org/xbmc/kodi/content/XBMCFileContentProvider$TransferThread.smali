.class Lorg/xbmc/kodi/content/XBMCFileContentProvider$TransferThread;
.super Ljava/lang/Thread;
.source "XBMCFileContentProvider.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/xbmc/kodi/content/XBMCFileContentProvider;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "TransferThread"
.end annotation


# instance fields
.field out:Ljava/io/OutputStream;

.field path:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/io/OutputStream;)V
    .locals 0

    .line 150
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 151
    iput-object p1, p0, Lorg/xbmc/kodi/content/XBMCFileContentProvider$TransferThread;->path:Ljava/lang/String;

    .line 152
    iput-object p2, p0, Lorg/xbmc/kodi/content/XBMCFileContentProvider$TransferThread;->out:Ljava/io/OutputStream;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .line 160
    :try_start_0
    new-instance v0, Lorg/xbmc/kodi/XBMCFile;

    invoke-direct {v0}, Lorg/xbmc/kodi/XBMCFile;-><init>()V

    .line 161
    iget-object v1, p0, Lorg/xbmc/kodi/content/XBMCFileContentProvider$TransferThread;->path:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lorg/xbmc/kodi/XBMCFile;->Open(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 163
    iget-object v0, p0, Lorg/xbmc/kodi/content/XBMCFileContentProvider$TransferThread;->out:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V

    .line 164
    iget-object v0, p0, Lorg/xbmc/kodi/content/XBMCFileContentProvider$TransferThread;->out:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V

    return-void

    .line 168
    :cond_0
    :goto_0
    invoke-virtual {v0}, Lorg/xbmc/kodi/XBMCFile;->Eof()Z

    move-result v1

    if-nez v1, :cond_1

    .line 170
    invoke-virtual {v0}, Lorg/xbmc/kodi/XBMCFile;->Read()[B

    move-result-object v1

    .line 171
    iget-object v2, p0, Lorg/xbmc/kodi/content/XBMCFileContentProvider$TransferThread;->out:Ljava/io/OutputStream;

    array-length v3, v1

    const/4 v4, 0x0

    invoke-virtual {v2, v1, v4, v3}, Ljava/io/OutputStream;->write([BII)V

    goto :goto_0

    .line 174
    :cond_1
    invoke-virtual {v0}, Lorg/xbmc/kodi/XBMCFile;->Close()V

    .line 175
    iget-object v0, p0, Lorg/xbmc/kodi/content/XBMCFileContentProvider$TransferThread;->out:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V

    .line 176
    iget-object v0, p0, Lorg/xbmc/kodi/content/XBMCFileContentProvider$TransferThread;->out:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    .line 180
    invoke-static {}, Lorg/xbmc/kodi/content/XBMCFileContentProvider;->access$000()Ljava/lang/String;

    move-result-object v1

    const-string v2, "XBMCFileContentProvider: Exception transferring file"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_1
    return-void
.end method
