import 'package:flutter/cupertino.dart';

import '../controller/categories_controller.dart';
import '../models/categories_model.dart';

class CategoriesProvider extends ChangeNotifier {
  List<CategoryElement>? categoriesList;
  List<CategoryElement>? get getCategories {
    return categoriesList;
  }

  CategoriesProvider() {
    getAllCategories();
  }

  getAllCategories() async {
    try {
      final allCategories = await CategoriesController().categoriesController();
      categoriesList = allCategories.data.categories;
      debugPrint('categoriesList $categoriesList');
    } catch (e) {
      debugPrint('Error in categoriesList  ${e.toString()}');
    }
    notifyListeners();
  }
}
