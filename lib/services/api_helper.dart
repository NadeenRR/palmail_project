import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:palmail_project/constant/app_constant.dart';
// import 'package:palmailnadeenflutter327/constant/app_constant.dart';

import 'app_exception.dart';

class ApiBaseHelper {
  // https://palmail.gsgtt.tech/api
  final String _baseUrl = 'http://palmail.gazawar.wiki/api';
  Future<dynamic> get(String endPoint, Map<String, String> header) async {
    var responseJson;
    try {
      final response =
          await http.get(Uri.parse(_baseUrl + endPoint), headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String endPoint, Map<String, String> body,
      Map<String, String> header) async {
    var responseJson;

    try {
      final response = await http.post(
        Uri.parse(_baseUrl + endPoint),
        body: body,
        headers: header,
      );

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String endPoint, Map<String, dynamic> body,
      Map<String, String> header) async {
    var responseJson;
    try {
      print('inside put controller');
      final response = await http.put(Uri.parse(AppConstant.baseUrl + endPoint),
          body: body, headers: header);
      print(AppConstant.baseUrl + endPoint);
      print(response.body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String endPoint, Map<String, String> header) async {
    var responseJson;
    try {
      print('in api controller');
      print(Uri.parse(_baseUrl + endPoint));

      final response =
          await http.delete(Uri.parse(_baseUrl + endPoint), headers: header);
      responseJson = _returnResponse(response);
      print(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());
        //  print(responseJson);
        return responseJson;
      case 302:
        throw BadRequestException('Errrooorrr');
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
