import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:palmail_project/controller/get_single_mail_controller.dart';
import 'package:palmail_project/models/single_model.dart';

import '../controller/attachment/upload_attachement.dart';
import '../services/api_response.dart';


import '../services/imagePicker/ImagePickerHelper.dart';

class SingleMailProvider extends ChangeNotifier {
  late SingleMailRepository _singleMailRepository;

  late ApiResponse<Mail> _getMail;
  int? _currentMailId;
  final ImagePickerHelper imagePickerHelper = ImagePickerHelper();
  bool isOpenHomeMails = false;
  List<Attachment> attachmentList = [];
  List<File> files = [];
  int? get currentMailId => _currentMailId;
  ApiResponse<Mail> get getMail => _getMail;

  toggleHomeMails() {
    isOpenHomeMails = true;
    notifyListeners();
  }

  SingleMailProvider() {
    _singleMailRepository = SingleMailRepository();
    fetchSingleMail();
  }

  void setCurrentMailId(int? mailId) {
    _currentMailId = mailId;
    // print('in class pov $_currentMailId');
    fetchSingleMail();
  }

  fetchSingleMail() async {
    if (_currentMailId == null) {
      return;
    }

    _getMail = ApiResponse.loading('Fetching Mail');
    print('Fetching mail data...');
    notifyListeners();
    try {
      Mail? mail = await _singleMailRepository.fetchSingleMail(_currentMailId!);
      attachmentList = mail?.attachments ?? [];

      _getMail = ApiResponse.completed(mail);
      notifyListeners();
    } catch (e) {
      _getMail = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  updateMail({
    String? decision,
    String? finalDecision,
    List<int?>? tags,
    String? bodyText,
    int? userId,
    int? statusId,
    int? imageId,
    String? imagePath,
  }) async {
    if (_currentMailId == null) {
      return;
    }
    _getMail = ApiResponse.loading('Updating Mail');
    notifyListeners();
    try {
      await _singleMailRepository.updateSingleMail(_currentMailId!, {
        'decision': decision ?? '',
        'final_decision': finalDecision ?? '',
        'tags': jsonEncode(tags ?? []),
        'activities': jsonEncode([
          {"body": "$bodyText", "user_id": userId}
        ]),
        'status_id': jsonEncode(statusId),
        'idAttachmentsForDelete': jsonEncode([]),
        'pathAttachmentsForDelete': jsonEncode(['']),
      });

      _getMail = ApiResponse.completed(_getMail.data);
      notifyListeners();
    } catch (e) {
      _getMail = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  deleteImageMail({
    int? statusId,
    int? imageId,
    String? imagePath,
  }) async {
    if (_currentMailId == null) {
      return;
    }
    try {
      print('before update');
      print(attachmentList.toString());
      // Remove the attachment from attachmentList first
      attachmentList.removeWhere((attachment) => attachment.id == imageId);

      await _singleMailRepository.updateSingleMail(_currentMailId!, {
        'decision': '',
        'final_decision': "",
        'tags': jsonEncode([]),
        'activities': jsonEncode([]),
        'status_id': jsonEncode(statusId),
        'idAttachmentsForDelete': jsonEncode([imageId]),
        'pathAttachmentsForDelete': jsonEncode([imagePath]),
      });

      print(attachmentList.toString());
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  Future<void> handleGetImages() async {
    List<File> pickedFiles = await imagePickerHelper.getImages();

    files = pickedFiles;

    notifyListeners();
  }

  Future<void> uploadImages() async {
    if (files.isNotEmpty) {
      List<File> filesToUpload = List.from(files);

      for (var pickedFile in filesToUpload) {
        File file = File(pickedFile.path);
        await uploadImage(file, currentMailId);
      }

      files.clear();

      Fluttertoast.showToast(
        msg: 'Images uploaded successfully.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }
    // else {
    //   Fluttertoast.showToast(
    //     msg: 'No images selected.',
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //   );
    // }
  }
}
