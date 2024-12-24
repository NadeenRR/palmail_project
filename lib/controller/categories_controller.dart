import '../models/categories_model.dart';
import '../services/api_helper.dart';
import '../services/api_response.dart';
import '../services/shared_pref_helper.dart';

class CategoriesController {
  late ApiResponse _apiResponse;
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<ApiResponse> categoriesController() async {
    _apiResponse = ApiResponse.loading('Featching data');
    String? token = await SharedPreferencesHelper.getUserToken();

    var headers = {'Authorization': 'Bearer $token'};

    var response = await _helper.get(
      "/categories",
      headers,
    );
    var getStatus = CategoriesModel.fromJson(response);
    _apiResponse = ApiResponse.completed(getStatus);

    return _apiResponse;
  }
}
//
