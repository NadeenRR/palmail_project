import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

import '../controller/search_controller.dart';
import '../models/mails_model.dart';
import '../services/api_response.dart';

class SearchProvider extends ChangeNotifier {
  bool isShowPressed = true;
  bool isClosed = false;
  bool isBottomSheetOpen = false;
  bool refreshPage = false;
  bool isFilterPressed = false;
  bool isSearchApplied = false;
  bool isOpenSenderMails = false;
  TextEditingController searchController = TextEditingController();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  int selectedStatusIndex = 0;
  late final List<ExpandedTileController> controllers = [];

  final ExpandedTileController fromDateController =
      ExpandedTileController(isExpanded: false);

  final ExpandedTileController toDateController =
      ExpandedTileController(isExpanded: false);
  SearchRepository searchRepository = SearchRepository();
  ApiResponse<List<Mail>> _searchList = ApiResponse.completed([]);

  ApiResponse<List<Mail>> get searchList => _searchList;
  toggleSenderMails() {
    isOpenSenderMails = !isOpenSenderMails;
    notifyListeners();
  }

  void resetFilter() {
    selectedStatusIndex = -1;
    fromDate = DateTime(2023);
    toDate = DateTime.now();
    notifyListeners();
  }

  void togglePressed() {
    isShowPressed = !isShowPressed;
    notifyListeners();
  }

  void toggleRefresh() {
    isShowPressed = false;
    isClosed = false;
    _searchList = ApiResponse<List<Mail>>.completed([]);
    searchController.clear();
    notifyListeners();
  }

  Future<void> searchRefresh() async {
    isBottomSheetOpen = false;
    notifyListeners();

    if (isFilterApplied) {
      await filterSearchList();
    } else {
      await fetchSearchList();
    }
    notifyListeners();
  }

  void toggleBottomSheet() {
    isBottomSheetOpen = true;
    notifyListeners();
  }

  void noToggleBottomSheet() {
    isBottomSheetOpen = false;
    notifyListeners();
  }

  void setToDate(DateTime date) {
    toDate = date;
    notifyListeners();
  }

  void setStatusIndex(int status) {
    selectedStatusIndex = status;
    notifyListeners();
  }

  void setFromDate(DateTime date) {
    fromDate = date;
    notifyListeners();
  }

  bool isFilterApplied = false;

  void updateState() {
    notifyListeners();
  }

  void resetSearchResults() {
    _searchList = ApiResponse<List<Mail>>.completed([]);
  }

  void closePressed() {
    isClosed = true;
    if (isClosed) {
      searchController.clear();
    }
    notifyListeners();
  }

  Future<void> fetchSearchList() async {
    _searchList = ApiResponse.loading('Fetching Mail List');
    notifyListeners();
    try {
      List<Mail>? mails =
          await searchRepository.fetchSearchList(searchController.text);
      if (mails != null && mails.isNotEmpty) {
        _searchList = ApiResponse.completed(mails);
      } else {
        _searchList = ApiResponse.completed([]);
        _searchList.message = 'No Mails Found';
      }
    } catch (e) {
      _searchList = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  Future<void> filterSearchList() async {
    _searchList = ApiResponse.loading('Fetching Mail List Filter');
    notifyListeners();
    try {
      List<Mail>? mails = await searchRepository.filterSearchList(
          startDate: fromDate, endDate: toDate, statusID: selectedStatusIndex);
      if (mails != null && mails.isNotEmpty) {
        _searchList = ApiResponse.completed(mails);
      } else {
        _searchList = ApiResponse.completed([]);
        _searchList.message = 'No Mails Found';
      }
    } catch (e) {
      _searchList = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  deleteMail(int mailId) async {
    _searchList = ApiResponse.loading('Delete Mail');
    notifyListeners();
    try {
      List<Mail>? mails = await searchRepository.deleteMail(mailId);
      notifyListeners();
      _searchList = ApiResponse.completed(mails);
      notifyListeners();
    } catch (e) {
      _searchList = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> editMail({
    required int mailId,
    String? decision,
    List<int>? tags,
    String? txt,
    int? userId,
    int? statusId,
    List<int>? idAttach,
    List<String>? pathAttach,
  }) async {
    _searchList = ApiResponse.loading('EDIT Mail');
    notifyListeners();
    try {
      String idAttachJson = jsonEncode(idAttach);
      String pathAttachJson = jsonEncode(pathAttach);

      List<Mail>? mails = await searchRepository.editMail(mailId, {
        'decision': decision.toString(),
        'final_decision': '',
        'tags': tags.toString(),
        'activities': '[{"body": "$txt", "user_id": $userId}]',
        'status_id': statusId.toString(),
        'idAttachmentsForDelete': idAttachJson,
        'pathAttachmentsForDelete': pathAttachJson,
      });
      notifyListeners();
      _searchList = ApiResponse.completed(mails);
      notifyListeners();
    } catch (e) {
      _searchList = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  bool _imageAdded = false;

  bool get imageAdded => _imageAdded;

  void setImageAdded(bool value) {
    _imageAdded = value;
    notifyListeners();
  }
}
//
