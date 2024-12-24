import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/attachment/upload_attachement.dart';

class ImagePickerHelper {
  final picker = ImagePicker();
  List<File>? files = [];

  Future<List<File>> getImages() async {
    List<XFile> pickedFiles = [];

    try {
      pickedFiles = await picker.pickMultiImage(
        imageQuality: 100,
        maxHeight: 80,
        maxWidth: 80,
      );

      if (pickedFiles.isNotEmpty) {
        for (var pickedFile in pickedFiles) {
          File file = File(pickedFile.path);
          files?.add(file);
        }
        Fluttertoast.showToast(
          msg: 'Images uploaded successfully.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }
      // } else {
      //   // Fluttertoast.showToast(
      //   //   msg: 'No images selected.',
      //   //   toastLength: Toast.LENGTH_SHORT,
      //   //   gravity: ToastGravity.BOTTOM,
      //   //   timeInSecForIosWeb: 1,
      //   //   backgroundColor: Colors.red,
      //   //   textColor: Colors.white,
      //   );
      // }
    } catch (e) {}

    return files ?? [];
  }
}
