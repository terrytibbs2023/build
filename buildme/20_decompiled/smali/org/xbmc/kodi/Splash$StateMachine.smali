.class Lorg/xbmc/kodi/Splash$StateMachine;
.super Landroid/os/Handler;
.source "Splash.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/xbmc/kodi/Splash;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "StateMachine"
.end annotation


# instance fields
.field private mSplash:Lorg/xbmc/kodi/Splash;

.field final synthetic this$0:Lorg/xbmc/kodi/Splash;


# direct methods
.method constructor <init>(Lorg/xbmc/kodi/Splash;Lorg/xbmc/kodi/Splash;)V
    .locals 0

    .line 94
    iput-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    .line 95
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object p1

    invoke-direct {p0, p1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 96
    iput-object p2, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 8

    .line 103
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    iget p1, p1, Landroid/os/Message;->what:I

    invoke-static {v0, p1}, Lorg/xbmc/kodi/Splash;->access$002(Lorg/xbmc/kodi/Splash;I)I

    .line 104
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$000(Lorg/xbmc/kodi/Splash;)I

    move-result p1

    const/4 v0, 0x1

    if-eq p1, v0, :cond_9

    const/4 v1, 0x4

    const/16 v2, 0x63

    if-eq p1, v2, :cond_8

    const/4 v3, 0x6

    const/4 v4, 0x0

    packed-switch p1, :pswitch_data_0

    goto/16 :goto_1

    .line 125
    :pswitch_0
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$300(Lorg/xbmc/kodi/Splash;)Landroid/widget/TextView;

    move-result-object p1

    const-string v0, "Asking for permissions..."

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 126
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$400(Lorg/xbmc/kodi/Splash;)Landroid/widget/ProgressBar;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    .line 128
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    const-string v0, "android.permission.RECORD_AUDIO"

    filled-new-array {v0}, [Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x22f2

    invoke-static {p1, v0, v1}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m(Lorg/xbmc/kodi/Splash;[Ljava/lang/String;I)V

    goto/16 :goto_1

    :pswitch_1
    const-string p1, "mounted"

    .line 179
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 181
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {p1, v0}, Lorg/xbmc/kodi/Splash;->access$802(Lorg/xbmc/kodi/Splash;Z)Z

    const/16 p1, 0x8

    .line 182
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    goto/16 :goto_1

    .line 186
    :cond_0
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-virtual {p1}, Lorg/xbmc/kodi/Splash;->startWatchingExternalStorage()V

    const/4 p1, 0x7

    .line 187
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    goto/16 :goto_1

    .line 110
    :pswitch_2
    new-instance p1, Landroid/app/AlertDialog$Builder;

    iget-object v0, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-direct {p1, v0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object p1

    .line 111
    invoke-virtual {p1, v4}, Landroid/app/AlertDialog;->setCancelable(Z)V

    const-string v0, "Info"

    .line 112
    invoke-virtual {p1, v0}, Landroid/app/AlertDialog;->setTitle(Ljava/lang/CharSequence;)V

    const-string v0, "Kodi requires access to your device media and files to function. Please allow this via the following dialogue box or Kodi will exit."

    .line 113
    invoke-virtual {p1, v0}, Landroid/app/AlertDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 114
    new-instance v0, Lorg/xbmc/kodi/Splash$StateMachine$1;

    invoke-direct {v0, p0}, Lorg/xbmc/kodi/Splash$StateMachine$1;-><init>(Lorg/xbmc/kodi/Splash$StateMachine;)V

    const/4 v1, -0x3

    const-string v2, "continue"

    invoke-virtual {p1, v1, v2, v0}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    .line 122
    invoke-virtual {p1}, Landroid/app/AlertDialog;->show()V

    goto/16 :goto_1

    .line 153
    :pswitch_3
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$600(Lorg/xbmc/kodi/Splash;)Z

    move-result p1

    if-eqz p1, :cond_1

    const/16 p1, 0xc

    .line 154
    invoke-virtual {p0, p1}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    goto/16 :goto_1

    .line 157
    :cond_1
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    const-string v1, "Permission denied!! Exiting..."

    invoke-static {p1, v1}, Lorg/xbmc/kodi/Splash;->access$102(Lorg/xbmc/kodi/Splash;Ljava/lang/String;)Ljava/lang/String;

    .line 158
    invoke-virtual {p0, v0}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    goto/16 :goto_1

    .line 132
    :pswitch_4
    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    const/16 v2, 0x22f3

    if-ge p1, v1, :cond_3

    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt p1, v1, :cond_2

    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$500(Lorg/xbmc/kodi/Splash;)Z

    move-result p1

    if-nez p1, :cond_2

    goto :goto_0

    .line 148
    :cond_2
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    const-string v0, "android.permission.WRITE_EXTERNAL_STORAGE"

    filled-new-array {v0}, [Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0, v2}, Lorg/xbmc/kodi/Main$$ExternalSyntheticApiModelOutline0;->m(Lorg/xbmc/kodi/Splash;[Ljava/lang/String;I)V

    goto/16 :goto_1

    .line 136
    :cond_3
    :goto_0
    :try_start_0
    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1}, Landroid/content/Intent;-><init>()V

    const-string v1, "android.settings.MANAGE_APP_ALL_FILES_ACCESS_PERMISSION"

    .line 137
    invoke-virtual {p1, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "package:%s"

    new-array v0, v0, [Ljava/lang/Object;

    .line 138
    iget-object v3, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-virtual {v3}, Lorg/xbmc/kodi/Splash;->getPackageName()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v0, v4

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 139
    iget-object v0, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-virtual {v0, p1, v2}, Lorg/xbmc/kodi/Splash;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_1

    :catch_0
    move-exception p1

    .line 143
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Exception asking for permissions: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "Kodi"

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    .line 195
    :pswitch_5
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$300(Lorg/xbmc/kodi/Splash;)Landroid/widget/TextView;

    move-result-object p1

    const-string v1, "External storage OK..."

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 196
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {p1, v0}, Lorg/xbmc/kodi/Splash;->access$802(Lorg/xbmc/kodi/Splash;Z)Z

    .line 197
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-virtual {p1}, Lorg/xbmc/kodi/Splash;->stopWatchingExternalStorage()V

    .line 198
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$700(Lorg/xbmc/kodi/Splash;)Z

    move-result p1

    if-eqz p1, :cond_4

    .line 199
    invoke-virtual {p0, v2}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    goto/16 :goto_1

    .line 202
    :cond_4
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$900(Lorg/xbmc/kodi/Splash;)V

    .line 204
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$000(Lorg/xbmc/kodi/Splash;)I

    move-result p1

    if-ne p1, v0, :cond_5

    .line 206
    invoke-virtual {p0, v0}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    .line 208
    :cond_5
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$1000(Lorg/xbmc/kodi/Splash;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_6

    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$1000(Lorg/xbmc/kodi/Splash;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->lastModified()J

    move-result-wide v4

    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$1100(Lorg/xbmc/kodi/Splash;)Ljava/io/File;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/File;->lastModified()J

    move-result-wide v6

    cmp-long p1, v4, v6

    if-ltz p1, :cond_6

    .line 210
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {p1, v3}, Lorg/xbmc/kodi/Splash;->access$002(Lorg/xbmc/kodi/Splash;I)I

    .line 211
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {p1, v0}, Lorg/xbmc/kodi/Splash;->access$702(Lorg/xbmc/kodi/Splash;Z)Z

    .line 213
    invoke-virtual {p0, v2}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    goto/16 :goto_1

    .line 217
    :cond_6
    new-instance p1, Lorg/xbmc/kodi/Splash$FillCache;

    iget-object v0, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    iget-object v1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-direct {p1, v0, v1}, Lorg/xbmc/kodi/Splash$FillCache;-><init>(Lorg/xbmc/kodi/Splash;Lorg/xbmc/kodi/Splash;)V

    invoke-virtual {p1}, Lorg/xbmc/kodi/Splash$FillCache;->execute()V

    goto/16 :goto_1

    .line 191
    :pswitch_6
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$300(Lorg/xbmc/kodi/Splash;)Landroid/widget/TextView;

    move-result-object p1

    const-string v0, "Waiting for external storage..."

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 192
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$400(Lorg/xbmc/kodi/Splash;)Landroid/widget/ProgressBar;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    goto :goto_1

    .line 175
    :pswitch_7
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {p1, v0}, Lorg/xbmc/kodi/Splash;->access$702(Lorg/xbmc/kodi/Splash;Z)Z

    .line 176
    invoke-virtual {p0, v2}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    goto :goto_1

    .line 169
    :pswitch_8
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$700(Lorg/xbmc/kodi/Splash;)Z

    move-result p1

    if-nez p1, :cond_7

    .line 170
    new-instance p1, Lorg/xbmc/kodi/Splash$FillCache;

    iget-object v0, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    iget-object v1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-direct {p1, v0, v1}, Lorg/xbmc/kodi/Splash$FillCache;-><init>(Lorg/xbmc/kodi/Splash;Lorg/xbmc/kodi/Splash;)V

    invoke-virtual {p1}, Lorg/xbmc/kodi/Splash$FillCache;->execute()V

    goto :goto_1

    .line 172
    :cond_7
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$200(Lorg/xbmc/kodi/Splash;)Lorg/xbmc/kodi/Splash$StateMachine;

    move-result-object p1

    invoke-virtual {p1, v3}, Lorg/xbmc/kodi/Splash$StateMachine;->sendEmptyMessage(I)Z

    goto :goto_1

    .line 165
    :pswitch_9
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$300(Lorg/xbmc/kodi/Splash;)Landroid/widget/TextView;

    move-result-object p1

    const-string v0, "Clearing cache..."

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 166
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$400(Lorg/xbmc/kodi/Splash;)Landroid/widget/ProgressBar;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    goto :goto_1

    .line 223
    :cond_8
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$300(Lorg/xbmc/kodi/Splash;)Landroid/widget/TextView;

    move-result-object p1

    const-string v0, "Starting Kodi..."

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 224
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$400(Lorg/xbmc/kodi/Splash;)Landroid/widget/ProgressBar;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    .line 225
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    invoke-virtual {p1}, Lorg/xbmc/kodi/Splash;->startXBMC()V

    goto :goto_1

    .line 107
    :cond_9
    iget-object p1, p0, Lorg/xbmc/kodi/Splash$StateMachine;->this$0:Lorg/xbmc/kodi/Splash;

    iget-object v0, p0, Lorg/xbmc/kodi/Splash$StateMachine;->mSplash:Lorg/xbmc/kodi/Splash;

    const-string v1, "Error"

    invoke-static {p1}, Lorg/xbmc/kodi/Splash;->access$100(Lorg/xbmc/kodi/Splash;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v0, v1, v2}, Lorg/xbmc/kodi/Splash;->showErrorDialog(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)V

    :goto_1
    return-void

    :pswitch_data_0
    .packed-switch 0x4
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
