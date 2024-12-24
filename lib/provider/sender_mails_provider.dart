import 'package:flutter/material.dart';
import 'package:palmail_project/models/mail_sender_model.dart';

import '../controller/senders/sender_mails_repo.dart';
import '../services/api_response.dart';

class SenderMailsProvider extends ChangeNotifier {
  late MailsSenderRepositry _mailsSenderRepositry;

  late ApiResponse<List<Mail>> _getMails;
  int? _senderId;

  SenderMailsProvider() {
    _mailsSenderRepositry = MailsSenderRepositry();
    fetchMails();
  }

  int? get currentSenderId => _senderId;
  ApiResponse<List<Mail>> get getMails => _getMails;

  void setCurrentMailId(int? mailId) {
    _senderId = mailId;
    fetchMails();
  }

  fetchMails() async {
    if (_senderId == null) {
      return;
    }

    _getMails = ApiResponse.loading('Fetching Mail');
    notifyListeners();
    try {
      List<Mail>? mail =
          await _mailsSenderRepositry.fetchSingleMailSender(_senderId!);
      _getMails = ApiResponse.completed(mail);
      notifyListeners();
    } catch (e) {
      _getMails = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
