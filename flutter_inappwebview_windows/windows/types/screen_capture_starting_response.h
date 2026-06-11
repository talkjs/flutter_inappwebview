#ifndef TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_SCREEN_CAPTURE_STARTING_RESPONSE_H_
#define TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_SCREEN_CAPTURE_STARTING_RESPONSE_H_

#include <flutter/standard_method_codec.h>
#include <optional>

#include "../utils/flutter.h"

namespace talkjs_flutter_inappwebview_plugin
{
  class ScreenCaptureStartingResponse
  {
  public:
    const std::optional<bool> cancel;
    const std::optional<bool> handled;

    ScreenCaptureStartingResponse(const std::optional<bool>& cancel,
      const std::optional<bool>& handled);
    ScreenCaptureStartingResponse(const flutter::EncodableMap& map);
    ~ScreenCaptureStartingResponse() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_SCREEN_CAPTURE_STARTING_RESPONSE_H_