import 'package:palmail_project/models/single_model.dart';
import 'package:palmail_project/services/api_helper.dart';
import 'package:palmail_project/services/shared_pref_helper.dart';

class SingleMailRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Mail?> fetchSingleMail(int mailId) async {
    String? userToken = await SharedPreferencesHelper.getUserToken();

    final response = await _helper.get("/mails/$mailId", {
      'Authorization': 'Bearer $userToken',
    });

    final singleMailResponse = SingleMailResponse.fromJson(response);
    final mailList = singleMailResponse.mail;

    if (mailList != null) {
      return mailList;
    } else {
      return null;
    }
  }

  Future<void> updateSingleMail(int mailId, Map<String, dynamic> body) async {
    String? userToken = await SharedPreferencesHelper.getUserToken();
    print(body);
    final response = await _helper.put("/mails/$mailId", body, {
      'Authorization': 'Bearer $userToken',
      'Accept': 'application/json',
    });
    print(body);
    if (response.statusCode == 200) {
      print('Mail updated successfully.');
    } else {
      print('Failed to update mail. Status code: ${response.statusCode}');
    }
  }
}
//
