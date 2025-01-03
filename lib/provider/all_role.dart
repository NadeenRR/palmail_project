import 'package:flutter/foundation.dart';

import '../controller/role/all_role.dart';
import '../models/all_role.dart';
import '../services/api_response.dart';

class RoleProvider extends ChangeNotifier {
  late AllRole _roles;
  late ApiResponse<List<Role>> _roles_users;
  RoleProvider() {
    _roles = AllRole();
    fetchRole();
  }

  ApiResponse<List<Role>> get getRoles => _roles_users;

  Future<void> fetchRole() async {
    _roles_users = ApiResponse.loading('Loading');
    notifyListeners();

    try {
      final response = await _roles.FetchAllRoles();
      _roles_users = ApiResponse.completed(response);
      print('Role: $response');
      print('_roles_users: $_roles_users');
      notifyListeners();
    } catch (e) {
      _roles_users = ApiResponse.error(e.toString());
      print('_roles_users: $_roles_users');
      notifyListeners();
    }
  }

  Future<void> refreshData() async {
    await fetchRole();
  }
}
