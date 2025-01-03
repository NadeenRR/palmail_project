import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:palmail_project/services/screenshot_image/share_image.dart';
// import 'package:palmailnadeenflutter327/services/screenshot_image/share_image.dart';

Future<void> capturePng(BuildContext context, GlobalKey globalKey) async {
  RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

  // await Future.delayed(const Duration(milliseconds: 20));
  ui.Image image = await boundary.toImage();
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List? pngBytes = byteData!.buffer.asUint8List();

  if (kDebugMode) {
    print(pngBytes);
  }

  onShareXFileFromAssets(context, byteData);
  // }
}
