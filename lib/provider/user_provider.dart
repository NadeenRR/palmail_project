import 'package:flutter/cupertino.dart';
import '../controller/user_controller.dart';
import '../models/user_info.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  User? get getUser {
    return user;
  }

  UserProvider() {
    getSingleUser();
  }

  getSingleUser() async {
    try {
      final singleUser = await UserController().userController();
      debugPrint('singleUser $singleUser');
      user = singleUser.data.user;
    } catch (e) {
      debugPrint('Error in user  ${e.toString()}');
    }
    notifyListeners();
  }
}
