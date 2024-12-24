import '../../models/all_status.dart';
import '../../services/api_helper.dart';
import '../../services/shared_pref_helper.dart';

class AllStatuesRep {
  Future<List<StatusModal>?> fetchAllStatues() async {
    final ApiBaseHelper helper = ApiBaseHelper();
    String? token = await SharedPreferencesHelper.getUserToken();

    final response = await helper.get(
      '/statuses?',
      {'Authorization': 'Bearer $token'},
    );
    for (int i = 0; i < AllStatues.fromJson(response).statuses!.length; i++) {}

    return AllStatues.fromJson(response).statuses;
  }
}
//
