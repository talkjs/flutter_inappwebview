#ifndef TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_FIND_SESSION_H_
#define TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_FIND_SESSION_H_

#include <flutter_linux/flutter_linux.h>
#include <string>

namespace talkjs_flutter_inappwebview_plugin {

class FindSession {
 public:
  int resultCount;
  int highlightedResultIndex;

  FindSession(int resultCount, int highlightedResultIndex);
  explicit FindSession(FlValue* value);
  ~FindSession() = default;

  FlValue* toFlValue() const;
};

}  // namespace talkjs_flutter_inappwebview_plugin

#endif  // TALKJS_FLUTTER_INAPPWEBVIEW_PLUGIN_FIND_SESSION_H_
