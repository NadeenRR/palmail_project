import '../models/statuses_model.dart';
import '../services/api_helper.dart';
import '../services/api_response.dart';
import '../services/shared_pref_helper.dart';

class StatuesController {
  late ApiResponse _apiResponse;
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<ApiResponse> statuesController() async {
    _apiResponse = ApiResponse.loading('Featching data');
    String? token = await SharedPreferencesHelper.getUserToken();

    var headers = {'Authorization': 'Bearer $token'};

    var response = await _helper.get(
      "/statuses?mail=true",
      headers,
    );
    var getStatus = StatusesModel.fromJson(response);
    _apiResponse = ApiResponse.completed(getStatus);

    return _apiResponse;
  }
}
//
