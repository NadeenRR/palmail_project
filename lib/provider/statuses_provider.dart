import 'package:flutter/material.dart';

import '../controller/statues_controller.dart';
import '../models/statuses_model.dart';

class StatusesProvider extends ChangeNotifier {
  List<StatusElement>? statusesList;
  List<StatusElement>? get getStatuses {
    return statusesList;
  }

  StatusesProvider() {
    getAllStatuses();
  }

  getAllStatuses() async {
    try {
      final allStatues = await StatuesController().statuesController();
      statusesList = allStatues.data.statuses;
    } catch (e) {
      debugPrint('Error in statues ${e.toString()}');
    }
    notifyListeners();
  }
}
