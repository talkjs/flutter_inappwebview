import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:talkjs_flutter_inappwebview/talkjs_flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';
import '../util.dart';

part 'load_asset_file.dart';

void main() {
  final shouldSkip = kIsWeb;

  skippableGroup('InAppLocalhostServer', () {
    final InAppLocalhostServer localhostServer = InAppLocalhostServer();

    setUpAll(() async {
      await localhostServer.start();
    });

    loadAssetFile(localhostServer);

    tearDownAll(() async {
      await localhostServer.close();
    });
  }, skip: shouldSkip);
}
