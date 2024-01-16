import 'dart:ui';

import 'package:share_plus/share_plus.dart';

abstract class ShareService {
  Future<void> shareLink(String content, {required Rect? sharePositionOrigin});
}

class ShareServiceImpl extends ShareService {
  @override
  Future<void> shareLink(String content, {required Rect? sharePositionOrigin}) {
    return Share.share(content, sharePositionOrigin: sharePositionOrigin);
  }
}
