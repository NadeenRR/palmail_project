import 'package:flutter/cupertino.dart';
import '../controller/all_users_controller.dart';

import '../models/all_users.dart';

class AllUserProvider extends ChangeNotifier {
  List<User>? users;
  List<User>? get getAllUsers {
    return users;
  }

  AllUserProvider() {
    getAll_Users();
  }

  getAll_Users() async {
    try {
      final allUsers = await AllUserController().allUserController();
      users = allUsers.data.users;
    } catch (e) {
      debugPrint('Error in allUsers ${e.toString()}');
    }
    notifyListeners();
  }
}


// class AllUserProvider extends ChangeNotifier {
//   List<User>? allUsersList;
//   List<User>? get getAllUsers {
//     return allUsersList;
//   }

//   AllUserProvider() {
//     getAll_Users();
//   }

//   getAll_Users() async {
//     try {
//       final allUsers = await AllUserController().allUserController();
//       allUsersList = allUsers.data.users;
//     } catch (e) {
//       debugPrint('erroorrrrrsssssss ${e.toString()}');
//     }
//     notifyListeners();
//   }
// }
