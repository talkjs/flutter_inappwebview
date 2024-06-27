package com.pichillilorenzo.flutterwebviewexample;

import android.os.Bundle;
import com.talkjs.talkjs_flutter_inappwebview.TalkJSInAppWebViewFlutterPlugin;

@SuppressWarnings("deprecation")
public class EmbedderV1Activity extends io.flutter.app.FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    TalkJSInAppWebViewFlutterPlugin.registerWith(
            registrarFor("com.talkjs.talkjs_flutter_inappwebview.TalkJSInAppWebViewFlutterPlugin"));
  }
}