package com.talkjs.talkjs_flutter_inappwebview.print_job;

import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import com.talkjs.talkjs_flutter_inappwebview.TalkjsInAppWebViewFlutterPlugin;
import com.talkjs.talkjs_flutter_inappwebview.types.Disposable;
import com.talkjs.talkjs_flutter_inappwebview.types.PrintJobInfoExt;

import io.flutter.plugin.common.MethodChannel;

@RequiresApi(api = Build.VERSION_CODES.KITKAT)
public class PrintJobController implements Disposable  {
  protected static final String LOG_TAG = "PrintJob";
  public static final String METHOD_CHANNEL_NAME_PREFIX = "com.talkjs/talkjs_flutter_inappwebview_printjobcontroller_";
  
  @NonNull
  public String id;
  @Nullable
  public TalkjsInAppWebViewFlutterPlugin plugin;
  @Nullable
  public PrintJobChannelDelegate channelDelegate;
  @Nullable
  public android.print.PrintJob job;
  @Nullable
  public PrintJobSettings settings;

  public PrintJobController(@NonNull String id, @Nullable PrintJobSettings settings,
                            @NonNull TalkjsInAppWebViewFlutterPlugin plugin) {
    this.id = id;
    this.plugin = plugin;
    this.settings = settings;
    final MethodChannel channel = new MethodChannel(plugin.messenger, METHOD_CHANNEL_NAME_PREFIX + id);
    this.channelDelegate = new PrintJobChannelDelegate(this, channel);
  }

  public void setJob(@Nullable android.print.PrintJob job) {
    this.job = job;
  }

  public void cancel() {
    if (this.job != null) {
      this.job.cancel();
    }
  }

  public void restart() {
    if (this.job != null) {
      this.job.restart();
    }
  }
  
  @Nullable
  public PrintJobInfoExt getInfo() {
    if (this.job != null) {
      return PrintJobInfoExt.fromPrintJobInfo(this.job.getInfo());
    }
    return null;
  }

  public void disposeNoCancel() {
    if (channelDelegate != null) {
      channelDelegate.dispose();
      channelDelegate  = null;
    }
    if (plugin != null) {
      PrintJobManager printJobManager = plugin.printJobManager;
      if (printJobManager != null && printJobManager.jobs.containsKey(id)) {
        printJobManager.jobs.put(id, null);
      }
    }
    if (job != null) {
      job = null;
    }
    plugin = null;
  }
  
  @Override
  public void dispose() {
    if (channelDelegate != null) {
      channelDelegate.dispose();
      channelDelegate  = null;
    }
    if (plugin != null) {
      PrintJobManager printJobManager = plugin.printJobManager;
      if (printJobManager != null && printJobManager.jobs.containsKey(id)) {
        printJobManager.jobs.put(id, null);
      }
    }
    if (job != null) {
      job.cancel();
      job = null;
    }
    plugin = null;
  }

  public void onComplete(boolean completed, @Nullable String error) {
    if (channelDelegate != null) channelDelegate.onComplete(completed, error);
  }
}
