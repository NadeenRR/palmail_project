import 'package:flutter/cupertino.dart';

import '../models/user_info.dart';
import '../services/api_helper.dart';
import '../services/api_response.dart';
import '../services/shared_pref_helper.dart';

class UserController {
  late ApiResponse _apiResponse;
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<ApiResponse> userController() async {
    _apiResponse = ApiResponse.loading('Featching data');
    String? token = await SharedPreferencesHelper.getUserToken();

    var headers = {'Authorization': 'Bearer $token'};

    var response = await _helper.get(
      "/user",
      headers,
    );
    debugPrint('API Response: $response');
    var getUser = UserInfo.fromJson(response);
    _apiResponse = ApiResponse.completed(getUser);

    return _apiResponse;
  }
}
