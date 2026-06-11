#ifndef TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_NOTIFICATION_RECEIVED_REQUEST_H_
#define TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_NOTIFICATION_RECEIVED_REQUEST_H_

#include <flutter/standard_method_codec.h>
#include <memory>
#include <optional>
#include <string>

#include "../utils/flutter.h"
#include "web_notification.h"

namespace talkjs_flutter_inappwebview_plugin
{
  class NotificationReceivedRequest
  {
  public:
    const std::optional<std::string> senderOrigin;
    const std::string notificationControllerId;
    const std::shared_ptr<WebNotification> notification;

    NotificationReceivedRequest(const std::optional<std::string>& senderOrigin, const std::string& notificationControllerId, const std::shared_ptr<WebNotification> notification);
    ~NotificationReceivedRequest() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_NOTIFICATION_RECEIVED_REQUEST_H_