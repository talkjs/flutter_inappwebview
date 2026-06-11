#ifndef TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_JS_PROMPT_RESPONSE_H_
#define TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_JS_PROMPT_RESPONSE_H_

#include <flutter_linux/flutter_linux.h>

#include <optional>
#include <string>

namespace talkjs_flutter_inappwebview_plugin {

/**
 * Response action for JS prompt dialogs.
 */
enum class JsPromptResponseAction { CANCEL = 0, CONFIRM = 1 };

/**
 * Response to a JavaScript prompt() dialog.
 */
class JsPromptResponse {
 public:
  bool handledByClient;
  JsPromptResponseAction action;
  std::optional<std::string> value;

  JsPromptResponse();
  JsPromptResponse(FlValue* map);
  ~JsPromptResponse() = default;
};

}  // namespace talkjs_flutter_inappwebview_plugin

#endif  // TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_JS_PROMPT_RESPONSE_H_
