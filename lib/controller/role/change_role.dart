import '../../models/change_role.dart';
import '../../services/api_helper.dart';
import '../../services/shared_pref_helper.dart';

class ChangeRoleRep {
  final ApiBaseHelper _helper = ApiBaseHelper();
  Future<ChangeRole> ChangeRoleReps(
      String id, Map<String, dynamic> body) async {
    String? token = await SharedPreferencesHelper.getUserToken();
    final response = await _helper.put('/users/$id/role', body, {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    return ChangeRole.fromJson(response);
  }
}
