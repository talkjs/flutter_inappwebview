#ifndef TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_URL_PROTECTION_SPACE_H_
#define TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_URL_PROTECTION_SPACE_H_

#include <flutter/standard_method_codec.h>
#include <optional>
#include <string>

#include "ssl_certificate.h"
#include "ssl_error.h"

namespace talkjs_flutter_inappwebview_plugin
{
  class URLProtectionSpace
  {
  public:
    const std::string host;
    const std::string protocol;
    const std::optional<std::string> realm;
    const int64_t port;
    const std::optional<std::shared_ptr<SslCertificate>> sslCertificate;
    const std::optional<std::shared_ptr<SslError>> sslError;

    URLProtectionSpace(const std::string& host, const std::string& protocol,
      const std::optional<std::string>& realm, const int64_t& port,
      const std::optional<std::shared_ptr<SslCertificate>> sslCertificate,
      const std::optional<std::shared_ptr<SslError>> sslError);
    ~URLProtectionSpace() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_URL_PROTECTION_SPACE_H_