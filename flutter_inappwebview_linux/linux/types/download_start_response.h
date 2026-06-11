#ifndef TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_DOWNLOAD_START_RESPONSE_H_
#define TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_DOWNLOAD_START_RESPONSE_H_

#include <flutter_linux/flutter_linux.h>

#include <optional>
#include <string>

namespace talkjs_flutter_inappwebview_plugin {

enum class DownloadStartResponseAction { CANCEL = 0, ALLOW = 1 };

class DownloadStartResponse {
 public:
  DownloadStartResponseAction action;
  std::optional<std::string> destinationPath;

  DownloadStartResponse();
  DownloadStartResponse(FlValue* map);
  ~DownloadStartResponse() = default;
};

}  // namespace talkjs_flutter_inappwebview_plugin

#endif  // TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_DOWNLOAD_START_RESPONSE_H_
