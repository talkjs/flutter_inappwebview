#ifndef TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_WEB_RESOURCE_ERROR_H_
#define TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_WEB_RESOURCE_ERROR_H_

#include <flutter_linux/flutter_linux.h>

#include <cstdint>
#include <string>

namespace talkjs_flutter_inappwebview_plugin {

class WebResourceError {
 public:
  const std::string description;
  const int64_t type;

  WebResourceError(const std::string& description, int64_t type);
  WebResourceError(FlValue* map);
  ~WebResourceError() = default;

  FlValue* toFlValue() const;
};

}  // namespace talkjs_flutter_inappwebview_plugin

#endif  // TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_WEB_RESOURCE_ERROR_H_
