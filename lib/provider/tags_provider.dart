import 'package:flutter/cupertino.dart';
import '../controller/tag_controller.dart';
import '../models/tags_model.dart';

class TagsProvider extends ChangeNotifier {
  List<Tag>? tagsList;

  List<Tag>? get getTags {
    return tagsList;
  }

  TagsProvider() {
    getAllTags();
  }

  getAllTags() async {
    try {
      final allTags = await TagsController().tagsController();
      tagsList = allTags.data.tags;
    } catch (e) {
      debugPrint('Error in tags ${e.toString()}');

    }
    notifyListeners();
  }
}
