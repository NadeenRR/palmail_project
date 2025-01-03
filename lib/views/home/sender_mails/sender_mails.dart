import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../constant/app_constant.dart';
import '../../../constant/app_string.dart';
import '../../../models/mails_model.dart';
import '../../../provider/search_provider.dart';
import '../../../provider/sender_mails_provider.dart';
import '../../../provider/single_mail_provider.dart';
import '../../../provider/user_provider.dart';
import '../../../services/api_response.dart';
import '../../../widgets/container_bottomSheet.dart';
import '../../../widgets/my_bottomSheet.dart';
import '../../details_feature/details_screen.dart';
import '../../details_feature/shmmier_loading.dart';
import '../widgets/category_expansion_tile.dart';

class senderMailsScreen extends StatefulWidget {
  static const id = '/senderMails';
  senderMailsScreen({super.key});

  @override
  State<senderMailsScreen> createState() => _senderMailsScreenState();
}

class _senderMailsScreenState extends State<senderMailsScreen> {
  List<Mail> mails = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final searchProvider = Provider.of<SearchProvider>(context);
    final user = Provider.of<UserProvider>(context).getUser?.role?.id;
    final mailSender = Provider.of<SenderMailsProvider>(context, listen: false);
    return container_bottomSheet(context,
        clip: AppConstant.isSelected ? Clip.hardEdge : Clip.none,
        radius: AppConstant.isSelected
            ? BorderRadius.circular(25)
            : BorderRadius.zero,
        margin: AppConstant.isSelected
            ? const EdgeInsets.only(top: 45, left: 12, right: 12)
            : EdgeInsets.zero,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                AppString.senderMails.tr(),
                style: AppConstant().titleStyle,
              ),
            ),
            body: Consumer<SenderMailsProvider>(
              builder: (context, mailProvider, _) {
                final mails = mailProvider.getMails;
                if (mailProvider.getMails.status == ApiStatus.LOADING) {
                  return ShimmerLoading.detailsPageShimmer();
                }
                if (mailProvider.getMails.status == ApiStatus.ERROR) {
                  return Center(
                    child: Text('${mailProvider.getMails.message}'),
                  );
                }
                if (mails.data == null || mails.data!.isEmpty) {
                  return SizedBox(
                    child: Center(
                        child: Lottie.asset('assets/json/empty_box.json',
                            width: MediaQuery.of(context).size.width,
                            height: 800)),
                  );
                }

                return ListView.builder(
                  itemCount: mails.data!.length,
                  itemBuilder: (context, index) {
                    final mail = mails.data?[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (user != 1) {
                              Provider.of<SingleMailProvider>(context,
                                      listen: false)
                                  .setCurrentMailId(mail?.id!);
                              searchProvider.toggleSenderMails();
                              setState(() {
                                AppConstant.isSelected = true;
                              });
                              await mybottomsheet(
                                context,
                                const DetailsScreen(),
                              ).whenComplete(() {
                                mailSender.fetchMails();
                                setState(() {
                                  AppConstant.isSelected = false;
                                });
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTileCustome(
                              size: size,
                              color: int.parse(mail?.status?.color ?? '0'),
                              date: AppConstant()
                                  .formatDate(mail?.createdAt ?? ''),
                              organizationName: mail?.sender?.name ?? '',
                              subTitle: mail?.description ?? '',
                              subject: mail?.subject ?? '',
                              tag: mail?.tags!
                                      .map((e) => e.name)
                                      .toList()
                                      .join(' #') ??
                                  '',
                              imageList: SizedBox(
                                height: 30,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: mail?.attachments!.length,
                                  itemBuilder: (context, attachmentIndex) {
                                    final attachment =
                                        mail?.attachments![attachmentIndex];
                                    final imageUrl =
                                        'http://palmail.gazawar.wiki/${attachment.image}';
                                    return Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      height: size.height / 20,
                                      width: size.width / 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              imageUrl),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                );
              },
            )));
  }
}
