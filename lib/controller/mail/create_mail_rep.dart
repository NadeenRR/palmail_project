

import '../../models/create_mail.dart';
import '../../services/api_helper.dart';
import '../../services/shared_pref_helper.dart';

Future<CreateMail> createEmail(Map<String, String> body) async {
  final ApiBaseHelper _helper = ApiBaseHelper();
  String? token = await SharedPreferencesHelper.getUserToken();
  final response = await _helper.post(
    '/mails',
    body,
    {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  return CreateMail.fromJson(response);
}
