import 'package:flutter/foundation.dart';
import '../models/all_categorey.dart';

import '../controller/Categorey/all_categorey_cont.dart';
import '../services/api_response.dart';

class CategoreyProvider extends ChangeNotifier {
  late AllCategoreyCont _CateogeryController;
  late ApiResponse<List<CategoryElement>> _Categories;
  CategoreyProvider() {
    _CateogeryController = AllCategoreyCont();
    _fetchCateogrey();
  }

  ApiResponse<List<CategoryElement>> get Categories => _Categories;

  void _fetchCateogrey() async {
    _Categories = ApiResponse.loading('Loading');
    notifyListeners();

    try {
      final response = await _CateogeryController.FetchCategories();
      _Categories = ApiResponse.completed(response);
      notifyListeners();
    } catch (e) {
      _Categories = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
