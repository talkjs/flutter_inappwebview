#ifndef TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_NAVIGATION_ACTION_H_
#define TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_NAVIGATION_ACTION_H_

#include <flutter/standard_method_codec.h>
#include <optional>

#include "url_request.h"

namespace talkjs_flutter_inappwebview_plugin
{
  enum NavigationActionType {
    linkActivated = 0,
    backForward,
    reload,
    other
  };

  class NavigationAction
  {
  public:
    const std::shared_ptr<URLRequest> request;
    const bool isForMainFrame;
    const std::optional<bool> isRedirect;
    const std::optional<NavigationActionType> navigationType;

    NavigationAction(std::shared_ptr<URLRequest> request, const bool& isForMainFrame, const std::optional<bool>& isRedirect, const std::optional<NavigationActionType>& navigationType);
    ~NavigationAction() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_NAVIGATION_ACTION_H_