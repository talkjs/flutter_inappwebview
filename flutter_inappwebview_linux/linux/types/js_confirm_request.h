#ifndef TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_JS_CONFIRM_REQUEST_H_
#define TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_JS_CONFIRM_REQUEST_H_

#include <flutter_linux/flutter_linux.h>

#include <optional>
#include <string>

namespace talkjs_flutter_inappwebview_plugin {

/**
 * Represents a JavaScript confirm() dialog request.
 */
class JsConfirmRequest {
 public:
  std::optional<std::string> url;
  std::string message;
  bool isMainFrame;

  JsConfirmRequest(const std::optional<std::string>& url, const std::string& message,
                   bool isMainFrame);
  ~JsConfirmRequest() = default;

  FlValue* toFlValue() const;
};

}  // namespace talkjs_flutter_inappwebview_plugin

#endif  // TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_JS_CONFIRM_REQUEST_H_
