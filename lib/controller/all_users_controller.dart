
import '../models/all_users.dart';
import '../services/api_helper.dart';
import '../services/api_response.dart';
import '../services/shared_pref_helper.dart';

class AllUserController {
  late ApiResponse _apiResponse;
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<ApiResponse> allUserController() async {
    _apiResponse = ApiResponse.loading('Featching data');
    String? token = await SharedPreferencesHelper.getUserToken();

    var headers = {'Authorization': 'Bearer $token'};

    var response = await _helper.get(
      "/users",
      headers,
    );

    var getAllUsers = AllUsers.fromJson(response);
    _apiResponse = ApiResponse.completed(getAllUsers);

    return _apiResponse;
  }
}

// class AllUserController {
//   late ApiResponse _apiResponse;
//   final ApiBaseHelper _helper = ApiBaseHelper();

//   Future<ApiResponse> allUserController() async {
//     _apiResponse = ApiResponse.loading('Featching data');
//     String? token = await SharedPreferencesHelper.getUserToken();

//     var headers = {'Authorization': 'Bearer $token'};

//     var response = await _helper.get(
//       "/users",
//       headers,
//     );

//     var getAllUsers = Users.fromJson(response);
//     _apiResponse = ApiResponse.completed(getAllUsers);

//     return _apiResponse;
//   }
// }
