import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../views/details_feature/shmmier_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/app_constant.dart';
import '../../constant/app_string.dart';
import '../../models/single_model.dart';
import '../../services/archive_maile/archive_maile_sharedpref.dart';
import '../home/widgets/category_expansion_tile.dart';

class ArchivedMailScreen extends StatefulWidget {
  static const id = '/archiveMails';
  const ArchivedMailScreen({super.key});

  @override
  State<ArchivedMailScreen> createState() => _ArchivedMailScreenState();
}

class _ArchivedMailScreenState extends State<ArchivedMailScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Future<List<Mail>> getArchivedMailsFromSharedPreferences() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? archivedMailJsonString = prefs.getString('archived_mails');
      if (archivedMailJsonString == null) {
        return [];
      }

      final List<dynamic> archivedMailList =
          json.decode(archivedMailJsonString);
      final List<Mail> archivedMails =
          archivedMailList.map((item) => Mail.fromJson(item)).toList();
      return archivedMails;
    }

    Future<void> deleteMails() async {
      await clearArchivedMails();
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(
            AppString.archivedMails.tr(),
            style: AppConstant().titleStyle,
          ),
           leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        AppString.deleteArchivedMails.tr(),
                        style: AppConstant().titleStyle,
                      ),
                      content: Text(
                        AppString.confirmDeleteArchive.tr(),
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            AppString.cancel.tr(),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                            AppString.deleteMail.tr(),
                          ),
                          onPressed: () {
                            deleteMails();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            )
          ]),
      body: FutureBuilder<List<Mail>>(
        future: getArchivedMailsFromSharedPreferences(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerLoading.shimmerLoadingList(context);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Lottie.asset('assets/json/empty_box.json',
                  width: MediaQuery.of(context).size.width, height: 800),
            );
          } else {
            List<Mail> archivedMails = snapshot.data!;
            archivedMails.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

            return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: archivedMails.length,
                  itemBuilder: (context, index) {
                    final mail = archivedMails[index];
                    return Column(
                      children: [
                        ExpansionTileCustome(
                          size: size,
                          color: int.parse(mail.status?.color ?? '0'),
                          date: AppConstant().formatDate(mail.createdAt ?? ''),
                          organizationName: mail.sender?.name ?? '',
                          subTitle: mail.description ?? '',
                          subject: mail.subject ?? '',
                          tag:
                              mail.tags!.map((e) => e.name).toList().join(' #'),
                          imageList: SizedBox(
                            height: 30,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: mail.attachments!.length,
                              itemBuilder: (context, attachmentIndex) {
                                final attachment =
                                    mail.attachments![attachmentIndex];
                                final imageUrl =
                                    'http://palmail.gazawar.wiki/${attachment.image}';
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  height: size.height / 20,
                                  width: size.width / 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image:
                                          CachedNetworkImageProvider(imageUrl),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ));
          }
        },
      ),
    );
  }
}
//
