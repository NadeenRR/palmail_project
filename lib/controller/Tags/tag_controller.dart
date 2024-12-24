import '../../models/all_tags.dart';
import '../../services/api_helper.dart';
import '../../services/shared_pref_helper.dart';

class AllTagsRep {
  Future<List<Tag>?> FetchAllTags() async {
    final ApiBaseHelper _helper = ApiBaseHelper();
    String? token = await SharedPreferencesHelper.getUserToken();

    final response = await _helper.get(
      '/tags',
      {'Authorization': 'Bearer $token'},
    );

    return AllTags.fromJson(response).tags;
  }
}
