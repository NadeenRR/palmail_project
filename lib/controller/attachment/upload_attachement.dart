import 'dart:io';

import 'package:http/http.dart' as http;

import '../../services/shared_pref_helper.dart';

Future<int> uploadImage(File file, mailId) async {
  String? token = await SharedPreferencesHelper.getUserToken();

  var request = http.MultipartRequest(
    // http://palmail.gazawar.wiki/api https://palmail.gsgtt.tech/api
      "POST", Uri.parse('http://palmail.gazawar.wiki/api/attachments'));
  var pic = await http.MultipartFile.fromPath('image', file.path);
  request.fields['mail_id'] = mailId.toString();
  request.fields['title'] = 'image_${DateTime.now()}';
  request.files.add(pic);
  request.headers
      .addAll({'Accept': 'application/json', 'Authorization': 'Bearer $token'});
  var response = await request.send();
  print('in upload');

  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
  print(responseString);
  return response.statusCode;
}
