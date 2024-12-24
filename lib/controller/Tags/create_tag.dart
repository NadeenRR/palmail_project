import '../../models/create_tag.dart';
import '../../services/api_helper.dart';
import '../../services/shared_pref_helper.dart';

Future<Tag?> createTag(Map<String, String> body) async {
  final ApiBaseHelper _helper = ApiBaseHelper();
  String? token = await SharedPreferencesHelper.getUserToken();
  final response = await _helper.post(
    '/tags',
    body,
    {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  return CreateTag.fromJson(response).tag;
}
