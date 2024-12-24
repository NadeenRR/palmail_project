import 'package:flutter/foundation.dart';

import '../controller/Tags/tag_mails.dart';
import '../models/mail_tags.dart';
import '../services/api_response.dart';

class MailTagsProvider extends ChangeNotifier {
  late MailsTags _tags;
  late ApiResponse<List<Mail>?> _tagsMails;
  List<int> ids = [];
  MailTagsProvider() {
    _tags = MailsTags();
    fetchTagsMails(ids);
  }

  ApiResponse<List<Mail>?> get getMails => _tagsMails;

  Future<void> fetchTagsMails(List<int> id) async {
    _tagsMails = ApiResponse.loading('Loading');
    notifyListeners();

    try {
      final response = await _tags.FetchAllTags(id);
      _tagsMails = ApiResponse.completed(response);
      notifyListeners();
    } catch (e) {
      _tagsMails = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
