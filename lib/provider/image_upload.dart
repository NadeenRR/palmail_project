import 'package:flutter/foundation.dart';

class ImageUploadProvider with ChangeNotifier {
  int _imageUploadCount = 0;

  int get imageUploadCount => _imageUploadCount;

  void incrementImageUploadCount() {
    _imageUploadCount++;
    notifyListeners();
  }
}
