import 'package:intl/intl.dart';
import '../models/mails_model.dart';
import '../services/api_helper.dart';
import '../services/shared_pref_helper.dart';

class SearchRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Mail>?> fetchSearchList(String text) async {
    String? token = await SharedPreferencesHelper.getUserToken();

    try {
      final response =
          await _helper.get("/search?text=$text&start&end&status_id", {
        'Authorization': 'Bearer $token',
      });

      final mailResponse = MailResponse.fromJson(response);

      if (mailResponse.mails != null && mailResponse.mails!.isNotEmpty) {
        return mailResponse.mails;
      } else {
        print('No Mails Found');
        return null;
      }
    } catch (e) {
      print('Error fetching and parsing mail list: $e');
      return null;
    }
  }

  Future<List<Mail>?> filterSearchList({
    DateTime? startDate,
    DateTime? endDate,
    required int statusID,
  }) async {
    try {
      print('before response');
      String? token = await SharedPreferencesHelper.getUserToken();
      final formattedStartDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate!);
      final formattedEndDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(endDate!);
      final response = await _helper.get(
        '/search?text&start=$formattedStartDate&end=$formattedEndDate'
        '&status_id=${++statusID}',
        {
          'Authorization': 'Bearer $token',
        },
      );

      print('API Response:');
      print(response);

      final mailResponse = MailResponse.fromJson(response);

      if (mailResponse.mails != null && mailResponse.mails!.isNotEmpty) {
        print('Parsed Mail List:');
        print(mailResponse.mails);
        return mailResponse.mails;
      } else {
        print('No Mails Found');
        return null;
      }
    } catch (e) {
      // print(response);
      print('Error in Conttroller : $e');
      return null;
    }
  }

  Future<List<Mail>?> deleteMail(int mailId) async {
    String? token = await SharedPreferencesHelper.getUserToken();
    try {
      final response = await _helper.delete("/mails/$mailId", {
        'Authorization': 'Bearer $token',
      });

      print('API Response:');
      print(response);

      final mailResponse = MailResponse.fromJson(response);

      return mailResponse.mails;
    } catch (e) {
      print('Error fetching and parsing mail list: $e');
      return null;
    }
  }

  Future<List<Mail>?> editMail(int mailId, Map<String, dynamic> body) async {
    String? token = await SharedPreferencesHelper.getUserToken();
    try {
      print(body);
      final response = await _helper.put("/mails/$mailId", body, {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      print(response);

      final mailResponse = MailResponse.fromJson(response);

      return mailResponse.mails;
    } catch (e) {
      print('Error fetching in Edit Mail: $e');
      return null;
    }
  }
}
