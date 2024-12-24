// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
//
// import '../../controller/attachment/upload_attachement.dart';
//
// File? imageFile ;
//
// Future<void> getImages(
//     int mailId, BuildContext context, VoidCallback refreshCallback) async {
//   final picker = ImagePicker();
//   List<XFile>? pickedFiles;
//
//   try {
//     pickedFiles = await picker.pickMultiImage(
//       imageQuality: 100,
//       maxHeight: 80,
//       maxWidth: 80,
//     );
//
//     if (pickedFiles.isNotEmpty) {
//       for (var pickedFile in pickedFiles) {
//         File file = File(pickedFile.path);
//         await uploadImage(file, mailId);
//       }
//
//       Navigator.pop(context, pickedFiles);
//       await Future.delayed(Duration(seconds: 10));
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Images uploaded successfully.'),
//         ),
//       );
//
//       refreshCallback();
//     } else {
//       // No images selected.
//     }
//   } catch (e) {
//     // Handle errors if any.
//     print(e);
//   }
// }
// Future getImages() async {
//   final pickedFile = await picker.pickImage(
//       imageQuality: 100,
//       maxHeight: 80,
//       maxWidth: 80,
//       source: ImageSource.gallery);
//   // List<XFile> xfilePick = pickedFile;
//
//   setState(
//         () {
//       if (pickedFile != null) {
//         print('here');
//         file = File(pickedFile.path);
//         print('$file');
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Nothing is selected')));
//       }
//     },
//   );
// }
