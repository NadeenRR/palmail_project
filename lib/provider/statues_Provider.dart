import 'package:flutter/foundation.dart';

import '../controller/statues/statuse_repositry.dart';
import '../models/all_status.dart';
import '../services/api_response.dart';

class StatueProvider extends ChangeNotifier {
  late AllStatuesRep _statuesRep;
  late ApiResponse<List<StatusModal>> _statues;
  StatueProvider() {
    _statuesRep = AllStatuesRep();
    _fetchStatues();
  }

  ApiResponse<List<StatusModal>> get getStatues => _statues;

  void _fetchStatues() async {
    _statues = ApiResponse.loading('Loading');
    notifyListeners();

    try {
      final response = await _statuesRep.fetchAllStatues();
      _statues = ApiResponse.completed(response);
      print(_statues.data);
      notifyListeners();
    } catch (e) {
      _statues = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
