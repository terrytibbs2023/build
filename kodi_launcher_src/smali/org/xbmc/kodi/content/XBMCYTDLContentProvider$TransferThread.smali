.class Lorg/xbmc/kodi/content/XBMCYTDLContentProvider$TransferThread;
.super Ljava/lang/Thread;
.source "XBMCYTDLContentProvider.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/xbmc/kodi/content/XBMCYTDLContentProvider;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "TransferThread"
.end annotation


# instance fields
.field in:Ljava/io/InputStream;

.field out:Ljava/io/OutputStream;


# direct methods
.method constructor <init>(Ljava/io/InputStream;Ljava/io/OutputStream;)V
    .locals 0

    .line 155
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 156
    iput-object p1, p0, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider$TransferThread;->in:Ljava/io/InputStream;

    .line 157
    iput-object p2, p0, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider$TransferThread;->out:Ljava/io/OutputStream;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    const/16 v0, 0x2000

    new-array v0, v0, [B

    .line 168
    :goto_0
    :try_start_0
    iget-object v1, p0, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider$TransferThread;->in:Ljava/io/InputStream;

    invoke-virtual {v1, v0}, Ljava/io/InputStream;->read([B)I

    move-result v1

    if-ltz v1, :cond_0

    .line 170
    iget-object v2, p0, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider$TransferThread;->out:Ljava/io/OutputStream;

    const/4 v3, 0x0

    invoke-virtual {v2, v0, v3, v1}, Ljava/io/OutputStream;->write([BII)V

    goto :goto_0

    .line 173
    :cond_0
    iget-object v0, p0, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider$TransferThread;->out:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 180
    :try_start_1
    iget-object v0, p0, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider$TransferThread;->in:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 181
    :goto_1
    iget-object v0, p0, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider$TransferThread;->out:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2

    goto :goto_2

    :catchall_0
    move-exception v0

    .line 180
    :try_start_2
    iget-object v1, p0, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider$TransferThread;->in:Ljava/io/InputStream;

    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    .line 181
    iget-object v1, p0, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider$TransferThread;->out:Ljava/io/OutputStream;

    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 184
    :catch_0
    throw v0

    .line 180
    :catch_1
    :try_start_3
    iget-object v0, p0, Lorg/xbmc/kodi/content/XBMCYTDLContentProvider$TransferThread;->in:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_1

    :catch_2
    :goto_2
    return-void
.end method
