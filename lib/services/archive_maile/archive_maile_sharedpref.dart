import 'dart:convert';

// import 'package:palmailnadeenflutter327/models/single_model.dart';
import 'package:palmail_project/models/single_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Mail>> getArchivedMailsFromSharedPreferences(
    SharedPreferences prefs) async {
  final String? archivedMailJsonString =
      prefs.getString('archived_mails') ?? '[]';
  final List<dynamic> archivedMailList = json.decode(archivedMailJsonString!);
  return archivedMailList.map((item) => Mail.fromJson(item)).toList();
}

Future<void> saveMailsToSharedPreferences(
    SharedPreferences prefs, List<Mail> archivedMails) async {
  final List<Map<String, dynamic>> archivedMailList =
      archivedMails.map((mail) => mail.toJson()).toList();
  final archivedMailJsonString = jsonEncode(archivedMailList);
  await prefs.setString('archived_mails', archivedMailJsonString);
}

Future<void> clearArchivedMails() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('archived_mails'); // Remove the 'archived_mails' key
}
