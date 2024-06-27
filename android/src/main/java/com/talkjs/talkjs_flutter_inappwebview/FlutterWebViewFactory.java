package com.talkjs.talkjs_flutter_inappwebview;

import android.content.Context;

import com.talkjs.talkjs_flutter_inappwebview.headless_in_app_webview.HeadlessInAppWebView;
import com.talkjs.talkjs_flutter_inappwebview.headless_in_app_webview.HeadlessInAppWebViewManager;
import com.talkjs.talkjs_flutter_inappwebview.webview.in_app_webview.FlutterWebView;
import com.talkjs.talkjs_flutter_inappwebview.webview.PlatformWebView;
import com.talkjs.talkjs_flutter_inappwebview.types.WebViewImplementation;

import java.util.HashMap;

import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class FlutterWebViewFactory extends PlatformViewFactory {
  public static final String VIEW_TYPE_ID = "com.talkjs/talkjs_flutter_inappwebview";
  private final TalkJSInAppWebViewFlutterPlugin plugin;

  public FlutterWebViewFactory(final TalkJSInAppWebViewFlutterPlugin plugin) {
    super(StandardMessageCodec.INSTANCE);
    this.plugin = plugin;
  }

  @Override
  public PlatformView create(Context context, int id, Object args) {
    HashMap<String, Object> params = (HashMap<String, Object>) args;
    PlatformWebView flutterWebView = null;

    String headlessWebViewId = (String) params.get("headlessWebViewId");
    if (headlessWebViewId != null) {
      HeadlessInAppWebView headlessInAppWebView = HeadlessInAppWebViewManager.webViews.get(headlessWebViewId);
      if (headlessInAppWebView != null) {
        flutterWebView = headlessInAppWebView.disposeAndGetFlutterWebView();
      }
    }

    if (flutterWebView == null) {
      WebViewImplementation implementation = WebViewImplementation.fromValue((Integer) params.get("implementation"));
      switch (implementation) {
        case NATIVE:
        default:
          flutterWebView = new FlutterWebView(plugin, context, id, params);
      }
      flutterWebView.makeInitialLoad(params);
    }
    
    return flutterWebView;
  }
}

