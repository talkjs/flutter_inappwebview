#ifndef TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_PRINT_JOB_INFO_H_
#define TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_PRINT_JOB_INFO_H_

#include <flutter/standard_method_codec.h>
#include <optional>
#include <string>

namespace talkjs_flutter_inappwebview_plugin
{
  // Forward declaration
  class PrintJobController;

  // Print job state enumeration (matches Dart PrintJobState)
  enum class PrintJobState : int64_t {
    created = 1,
    started = 3,
    completed = 5,
    failed = 6,
    canceled = 7,
  };

  class PrintJobInfo
  {
  public:
    PrintJobState state;
    int64_t creationTime;
    std::optional<std::string> label;
    std::optional<int32_t> numberOfPages;
    std::optional<int32_t> copies;

    PrintJobInfo();
    PrintJobInfo(const PrintJobController* controller);
    ~PrintJobInfo() = default;

    flutter::EncodableMap toEncodableMap() const;
  };
}

#endif //TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_PRINT_JOB_INFO_H_
