import 'package:flutter/foundation.dart';

import '../controller/Tags/all_tag_Repositry.dart';
import '../models/all_tags.dart';
import '../services/api_response.dart';

class TagProvider extends ChangeNotifier {
  late AllTagsRep _tagRes;
  late ApiResponse<List<Tag>> _tags;
  TagProvider() {
    _tagRes = AllTagsRep();
    _fetchTag();
  }

  ApiResponse<List<Tag>> get getTags => _tags;

  Future<void> _fetchTag() async {
    _tags = ApiResponse.loading('Loading');
    notifyListeners();

    try {
      final response = await _tagRes.FetchAllTags();
      _tags = ApiResponse.completed(response);
      notifyListeners();
    } catch (e) {
      _tags = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> refreshData() async {
    await _fetchTag();
    notifyListeners();
  }
}
//
