
import '../models/tags_model.dart';

import '../services/api_helper.dart';
import '../services/api_response.dart';
import '../services/shared_pref_helper.dart';

class TagsController {
  late ApiResponse _apiResponse;
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<ApiResponse> tagsController() async {
    _apiResponse = ApiResponse.loading('Featching data');
    String? token = await SharedPreferencesHelper.getUserToken();

    var headers = {'Authorization': 'Bearer $token'};

    var response = await _helper.get(
      "/tags",
      headers,
    );
    var getTags = TagsModel.fromJson(response);
    _apiResponse = ApiResponse.completed(getTags);

    return _apiResponse;
  }
}
