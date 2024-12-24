import 'package:flutter/cupertino.dart';
import '../controller/mail_controller.dart';
import '../models/mail_model.dart';

class MailsProvider extends ChangeNotifier {
  List<Mail>? mailList;
  List<Mail>? get getMails {
    return mailList;
  }

  MailsProvider() {
    getAllMails();
  }

  getAllMails() async {
    try {
      final allMails = await MailsController().mailsController();
      mailList = allMails.data.mails;
    } catch (e) {
     
    }
    notifyListeners();
  }
}
