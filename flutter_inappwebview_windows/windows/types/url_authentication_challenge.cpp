#include "../utils/flutter.h"
#include "url_authentication_challenge.h"

namespace talkjs_flutter_inappwebview_plugin
{
  URLAuthenticationChallenge::URLAuthenticationChallenge(const std::shared_ptr<URLProtectionSpace> protectionSpace)
    : protectionSpace(protectionSpace)
  {}

  flutter::EncodableMap URLAuthenticationChallenge::toEncodableMap() const
  {
    return flutter::EncodableMap{
    {"protectionSpace", protectionSpace->toEncodableMap()},
    };
  }
}