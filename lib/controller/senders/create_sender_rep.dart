import '../../models/create_sender.dart';
import '../../services/api_helper.dart';
import '../../services/shared_pref_helper.dart';

Future<CreateSender> createSender(Map<String, String> body) async {
  final ApiBaseHelper _helper = ApiBaseHelper();
  String? token = await SharedPreferencesHelper.getUserToken();
  final response = await _helper.post(
    '/senders',
    body,
    {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  return CreateSender.fromJson(response);
}
