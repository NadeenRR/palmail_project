import '../../models/all_senders.dart';
import '../../services/api_helper.dart';
import '../../services/shared_pref_helper.dart';

class AllSendersRep {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Map<String, List<List<Map<int?, String>>>>> FetchAllSenders() async {
    String? token = await SharedPreferencesHelper.getUserToken();
    Map<String, List<List<Map<int?, String>>>> filters = {
      'name': [],
      'Foreign': [],
      'NGOs': [],
      'Other': [],
      'Official Organizations': [],
    };
    final response = await _helper.get(
      '/senders?mail=false',
      {'Authorization': 'Bearer $token'},
    );
    print('Response: $response');
    for (int i = 0;
        i < AllSenders.fromJson(response).senders!.data!.length;
        i++) {
      List<Map<int?, String>> mailsList = [];

      for (var mail
          in AllSenders.fromJson(response).senders!.data![i].mails ?? []) {
        Map<int?, String> mailData = {mail.id: mail.id};
        mailsList.add(mailData);
      }
      filters['name']?.add([
        {
          AllSenders.fromJson(response).senders!.data![i].id:
              AllSenders.fromJson(response).senders!.data![i].name!
        },
        {
          AllSenders.fromJson(response).senders!.data![i].id:
              AllSenders.fromJson(response).senders!.data![i].mobile!
        },
      ]);
      if (AllSenders.fromJson(response).senders!.data![i].category!.id == 1) {
        filters['Other']!.add([
          {
            AllSenders.fromJson(response).senders!.data![i].id:
                AllSenders.fromJson(response).senders!.data![i].name!
          },
          {
            AllSenders.fromJson(response).senders!.data![i].id:
                AllSenders.fromJson(response).senders!.data![i].mobile!
          }
        ]);
      } else if (AllSenders.fromJson(response).senders!.data![i].category!.id ==
          2) {
        filters['Official Organizations']!.add([
          {
            AllSenders.fromJson(response).senders!.data![i].id:
                AllSenders.fromJson(response).senders!.data![i].name!
          },
          {
            AllSenders.fromJson(response).senders!.data![i].id:
                AllSenders.fromJson(response).senders!.data![i].mobile!
          }
        ]);
      } else if (AllSenders.fromJson(response).senders!.data![i].category!.id ==
          3) {
        filters['NGOs']!.add([
          {
            AllSenders.fromJson(response).senders!.data![i].id:
                AllSenders.fromJson(response).senders!.data![i].name!
          },
          {
            AllSenders.fromJson(response).senders!.data![i].id:
                AllSenders.fromJson(response).senders!.data![i].mobile!
          }
        ]);
      } else {
        filters['Foreign']!.add([
          {
            AllSenders.fromJson(response).senders!.data![i].id:
                AllSenders.fromJson(response).senders!.data![i].name!
          },
          {
            AllSenders.fromJson(response).senders!.data![i].id:
                AllSenders.fromJson(response).senders!.data![i].mobile!
            // AllSenders.fromJson(response).senders!.data![i].mobile!
          }
        ]);
      }
    }
    return filters;
  }
}
