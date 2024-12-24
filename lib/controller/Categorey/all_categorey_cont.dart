
import '../../models/all_categorey.dart';
import '../../services/api_helper.dart';
import '../../services/shared_pref_helper.dart';

class AllCategoreyCont {
  Future<List<CategoryElement>?> FetchCategories() async {
    final ApiBaseHelper _helper = ApiBaseHelper();
    String? token = await SharedPreferencesHelper.getUserToken();

    final response = await _helper.get(
      '/categories',
      {'Authorization': 'Bearer $token'},
    );

    List<CategoryElement> categories =
        AllCategorey.fromJson(response).categories!;

    return categories;
  }
}
