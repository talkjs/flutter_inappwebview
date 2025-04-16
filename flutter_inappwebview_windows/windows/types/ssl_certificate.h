#ifndef TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_SSL_CERTIFICATE_H_
#define TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_SSL_CERTIFICATE_H_

#include <flutter/standard_method_codec.h>

namespace talkjs_flutter_inappwebview_plugin
{
  class SslCertificate
  {
  public:
    const std::string x509Certificate;

    SslCertificate(std::string x509Certificate);
    ~SslCertificate() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_SSL_CERTIFICATE_H_