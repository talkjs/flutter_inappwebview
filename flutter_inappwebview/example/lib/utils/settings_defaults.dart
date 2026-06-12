import 'package:talkjs_flutter_inappwebview/talkjs_flutter_inappwebview.dart';

InAppWebViewSettings defaultInAppWebViewSettings() {
  return InAppWebViewSettings();
}

WebViewEnvironmentSettings defaultWebViewEnvironmentSettings() {
  return WebViewEnvironmentSettings();
}

Map<String, dynamic> defaultInAppWebViewSettingsMap() {
  return defaultInAppWebViewSettings().toMap(
    enumMethod: EnumMethod.nativeValue,
  );
}

Map<String, dynamic> defaultWebViewEnvironmentSettingsMap() {
  return defaultWebViewEnvironmentSettings().toMap(
    enumMethod: EnumMethod.nativeValue,
  );
}
