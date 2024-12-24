import '../../models/mail_tags.dart';
import '../../services/api_helper.dart';
import '../../services/shared_pref_helper.dart';

class MailsTags {
  Future<List<Mail>> FetchAllTags(List<int> ids) async {
    // var headers = {
    //   'Authorization': 'Bearer 124|BSdCrbF72NxDtvDOvJc2LSWczuH3YTMGSSA8tGN2'
    // };
    // var request = http.Request(
    //     'GET', Uri.parse('https://palmail.gsgtt.tech/api/tags?tags=$ids'));
    //
    // request.headers.addAll(headers);
    //
    // http.StreamedResponse response = await request.send();
    //
    // if (response.statusCode == 200) {
    //   print('${await response.stream.bytesToString()}    test 200');
    // } else {
    //   print(response.reasonPhrase);
    // }
    final ApiBaseHelper _helper = ApiBaseHelper();
    String? token = await SharedPreferencesHelper.getUserToken();

    final response = await _helper.get(
      '/tags?tags=$ids',
      {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    List<int> mail_id = [];
    List<Mail> mail = [];
    print(MailTags.fromJson(response).tags!);
    for (int i = 0; i < MailTags.fromJson(response).tags!.length; i++) {
      for (int j = 0;
          j < MailTags.fromJson(response).tags![i].mails!.length;
          j++) {
        if (!mail_id
            .contains(MailTags.fromJson(response).tags![i].mails![j].id)) {
          mail_id.add(MailTags.fromJson(response).tags![i].mails![j].id!);
          mail.add(MailTags.fromJson(response).tags![i].mails![j]);
        }
      }
    }

    return mail;
  }
}
