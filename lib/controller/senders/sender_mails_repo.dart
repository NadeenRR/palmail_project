import '../../models/mail_sender_model.dart';
import '../../services/api_helper.dart';
import '../../services/shared_pref_helper.dart';

class MailsSenderRepositry {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Mail>?> fetchSingleMailSender(int senderId) async {
    String? userToken = await SharedPreferencesHelper.getUserToken();

    final response = await _helper.get("/senders/$senderId?mail=true", {
      'Authorization': 'Bearer $userToken',
    });

    final mailSenderlResponse = MailSenderlResponse.fromJson(response);
    final mailList = mailSenderlResponse.sender?.mails;

    if (mailList != null) {
      return mailList;
    } else {
      return null;
    }
  }
}
