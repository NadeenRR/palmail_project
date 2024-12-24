
import '../../models/all_role.dart';
import '../../services/api_helper.dart';
import '../../services/shared_pref_helper.dart';

class AllRole {
  Future FetchAllRoles() async {
    final ApiBaseHelper _helper = ApiBaseHelper();
    String? token = await SharedPreferencesHelper.getUserToken();

    final response = await _helper.get(
      '/roles',
      {'Authorization': 'Bearer $token'},
    );

    return AllRoles.fromJson(response).roles;
  }
}
