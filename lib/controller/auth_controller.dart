import 'dart:convert';

import '../constant/app_constant.dart';
import '../models/users.dart';
import '../services/api_response.dart';
import 'package:http/http.dart' as http;

import '../services/shared_pref_helper.dart';

class AuthController {
  late ApiResponse _apiResponse;
  Future<ApiResponse> loginUser({
    required String email,
    required String password,
  }) async {
    _apiResponse = ApiResponse.loading('Featching data');
    var response = await http.post(Uri.parse(AppConstant.loginUrl), body: {
      'email': email,
      'password': password,
    });
    try {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var user = Users.fromJson(jsonResponse);
        SharedPreferencesHelper.saveUserToken('${user.token}');
        _apiResponse = ApiResponse<Users>.completed(user);
      } else {
        _apiResponse = ApiResponse<Users>.error('Invalid credentials.');
      }
    } catch (e) {
      _apiResponse = ApiResponse<Users>.error('Invalid credentials.');
    }

    return _apiResponse;
  }

  Future<ApiResponse> registerUser({
    required String email,
    required String password,
    required String name,
    required String passwordConfirmation,
  }) async {
    _apiResponse = ApiResponse.loading('Featching data');

    var response = await http.post(Uri.parse(AppConstant.registerUrl), body: {
      'email': email,
      'password': password,
      'name': name,
      'password_confirmation': passwordConfirmation,
    });

    try {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var user = Users.fromJson(jsonResponse);
        print('user $user');
        SharedPreferencesHelper.saveUserToken('${user.token}');
        _apiResponse = ApiResponse<Users>.completed(user);
        print('_apiResponse $_apiResponse');
      } else {
        _apiResponse =
            ApiResponse<Users>.error('Email address is already registered.');
        print('_apiResponse $_apiResponse');
      }
    } catch (e) {
      _apiResponse =
          ApiResponse<Users>.error('Email address is already registered.');
      print('_apiResponse $_apiResponse');
    }
    print(_apiResponse);

    return _apiResponse;
  }

  Future<bool> logout() async {
    //http://palmail.gazawar.wiki/api https://palmail.gsgtt.tech/api
    var url = Uri.parse("http://palmail.gazawar.wiki/api/logout");

    String? token = await SharedPreferencesHelper.getUserToken();

    var headers = {'Authorization': 'Bearer $token'};

    var response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return SharedPreferencesHelper.cleanUser();
    } else {
      return false;
    }
  }
}
