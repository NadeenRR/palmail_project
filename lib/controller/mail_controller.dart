import '../models/mail_model.dart';
import '../services/api_helper.dart';
import '../services/api_response.dart';
import '../services/shared_pref_helper.dart';

class MailsController {
  late ApiResponse _apiResponse;
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<ApiResponse> mailsController() async {
    _apiResponse = ApiResponse.loading('Featching data');
    String? token = await SharedPreferencesHelper.getUserToken();

    var headers = {'Authorization': 'Bearer $token'};

    var response = await _helper.get(
      "/mails",
      headers,
    );
    var getMail = MailModel.fromJson(response);
    _apiResponse = ApiResponse.completed(getMail);

    return _apiResponse;
  }
}
//
