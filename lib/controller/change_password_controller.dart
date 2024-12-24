import 'package:http/http.dart' as http;

import '../services/api_response.dart';
import '../services/shared_pref_helper.dart';

class ChangePasswordController {
  // late ApiResponse _apiResponse;
  // final ApiBaseHelper _helper = ApiBaseHelper();

  Future<ApiResponse> changePasswordController(
      {required int userId,
      required String password,
      required String passwordConfirmation}) async {
    String? token = await SharedPreferencesHelper.getUserToken();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('PUT',
        //http://palmail.gazawar.wiki/api https://palmail.gsgtt.tech/api
        Uri.parse('http://palmail.gazawar.wiki/api/users/$userId/password'));
    request.bodyFields = {
      'password': password,
      'password_confirmation': passwordConfirmation
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return ApiResponse.completed(response);
    } else {
      print(response.reasonPhrase);
      return ApiResponse.error('Errorrr');
    }
    // _apiResponse = ApiResponse.loading('Featching data');
    // String? token = await SharedPreferencesHelper.getUserToken();

    // var headers = {
    //   'Authorization': 'Bearer $token',
    //   'Content-Type': 'application/x-www-form-urlencoded'
    // };

    // var body = {
    //   'password': password,
    //   'password_confirmation': passwordConfirmation
    // };

    // var response = await _helper.put(
    //   "/users/$userId/password",
    //   body,
    //   headers,
    // );
    // var getTags = TagsModel.fromJson(response);
    // _apiResponse = ApiResponse.completed(getTags);

    // return _apiResponse;
  }
}
