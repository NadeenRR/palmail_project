import 'package:flutter/foundation.dart';
import '../controller/senders/allSenders_repositry.dart';
import '../services/api_response.dart';

class SendersProvider extends ChangeNotifier {
  late AllSendersRep _sendersRep;
  late ApiResponse<Map<String, List<List<Map<int?, String?>>>>> _senders;
  SendersProvider() {
    _sendersRep = AllSendersRep();
    fetchSenders();
  }

  ApiResponse<Map<String, List<List<Map<int?, String?>>>>> get getSenders =>
      _senders;

  Future<void> fetchSenders() async {
    _senders = ApiResponse.loading('Loading');
    notifyListeners();

    try {
      final response = await _sendersRep.FetchAllSenders();
      debugPrint('Response: $response');
      _senders = ApiResponse.completed(response);
      notifyListeners();
    } catch (e) {
      _senders = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> refreshData() async {
    await fetchSenders();
  }
}
