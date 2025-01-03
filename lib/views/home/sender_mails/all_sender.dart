import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../constant/app_color.dart';
import '../../../constant/app_constant.dart';
import '../../../controller/senders/allSenders_repositry.dart';
import '../../../provider/sender_provider.dart';
import '../../../services/api_response.dart';
import '../../../widgets/container_bottomSheet.dart';
import 'package:provider/provider.dart';
import '../../../views/home/sender_mails/sender_mails.dart';
import '../../../constant/Shimmer_app.dart';
import '../../../constant/app_string.dart';
import '../../../provider/sender_mails_provider.dart';

class sendersView extends StatefulWidget {
  static const id = '/senderView';

  const sendersView({Key? key}) : super(key: key);

  @override
  State<sendersView> createState() => _sendersViewState();
}

class _sendersViewState extends State<sendersView> {
  FocusNode myFocusNode = FocusNode();
  AllSendersRep senders = AllSendersRep();
  int? id;
  String? name;
  String? mobile;
  @override
  void initState() {
    senders.FetchAllSenders();

    super.initState();
  }

  String searchvalue = '';
  TextEditingController _searchController = TextEditingController();

  Widget build(BuildContext context) {
    return container_bottomSheet(context,
        clip: AppConstant.isSelected ? Clip.hardEdge : Clip.none,
        margin: EdgeInsets.zero,
        radius: AppConstant.isSelected
            ? BorderRadius.circular(25)
            : BorderRadius.zero,
        child: Scaffold(
          backgroundColor: AppColors.bcColor,
          appBar: AppBar(
            backgroundColor: AppColors.bcColor,
            leadingWidth: 100,
            elevation: 0,
            centerTitle: true,
            leading: TextButton(
              child: Text(
                AppString.cancel.tr(),
                style: const TextStyle(
                  color: Color(0xff6589FF),
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              AppString.senderMails.tr(),
              style: const TextStyle(
                color: Color(0xff272727),
                fontSize: 22,
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  AppString.done.tr(),
                  style: const TextStyle(
                    color: Color(0xff6589FF),
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  senders.FetchAllSenders();
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchvalue = _searchController.text;
                        });
                      },
                      focusNode: myFocusNode,
                      cursorColor: Colors.black,
                      controller: _searchController,
                      decoration: InputDecoration(
                        suffixStyle: const TextStyle(
                          fontSize: 18,
                        ),
                        suffixIcon: Visibility(
                          visible: myFocusNode.hasFocus,
                          child: IconButton(
                            icon: const Icon(
                              Icons.cancel,
                              size: 32,
                            ),
                            onPressed: () {
                              _searchController.clear();
                            },
                          ),
                        ),
                        suffixIconColor: MaterialStateColor.resolveWith(
                            (states) => states.contains(MaterialState.focused)
                                ? Colors.black
                                : Colors.grey),
                        filled: true,
                        fillColor: const Color(0xffEAEAF5),
                        labelText: AppString.search.tr(),
                        labelStyle: TextStyle(
                          color: myFocusNode.hasFocus
                              ? Colors.black
                              : const Color(0xffAFAFAF),
                        ),
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: MaterialStateColor.resolveWith(
                            (states) => states.contains(MaterialState.focused)
                                ? Colors.black
                                : Colors.grey),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  if (_searchController.text == "") ...{
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(),
                    Consumer<SendersProvider>(
                      builder: (_, senderProvidr, __) {
                        if (senderProvidr.getSenders.status ==
                            ApiStatus.LOADING) {
                          return ShimmerApp.SendersShimmer();
                        }
                        if (senderProvidr.getSenders.status ==
                            ApiStatus.COMPLETED) {
                          return GestureDetector(
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppString.other.tr(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.grey2Color,
                                      ),
                                    ),
                                    for (int i = 0;
                                        i <
                                            senderProvidr.getSenders
                                                .data!['Other']!.length;
                                        i++) ...{
                                      buildPadding(senderProvidr, i, 'Other')
                                    },
                                    const Divider(),
                                    Text(
                                      AppString.officialOrganizations.tr(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.grey2Color,
                                      ),
                                    ),
                                    for (int i = 0;
                                        i <
                                            senderProvidr
                                                .getSenders
                                                .data![
                                                    'Official Organizations']!
                                                .length;
                                        i++) ...{
                                      buildPadding(senderProvidr, i,
                                          'Official Organizations')
                                    },
                                    const Divider(),
                                    Text(
                                      AppString.NGOs.tr(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.grey2Color,
                                      ),
                                    ),
                                    for (int i = 0;
                                        i <
                                            senderProvidr.getSenders
                                                .data!['NGOs']!.length;
                                        i++) ...{
                                      buildPadding(senderProvidr, i, 'NGOs')
                                    },
                                    const Divider(),
                                    Text(
                                      AppString.foreign.tr(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.grey2Color,
                                      ),
                                    ),
                                    for (int i = 0;
                                        i <
                                            senderProvidr.getSenders
                                                .data!['Foreign']!.length;
                                        i++) ...{
                                      buildPadding(senderProvidr, i, 'Foreign')
                                    }
                                  ]),
                            ),
                          );
                        }
                        return Text(
                            '${senderProvidr.getSenders.message} error');
                      },
                    ),
                  } else ...{
                    Consumer<SendersProvider>(
                      builder: (_, poviderSender, __) {
                        if (poviderSender.getSenders.status ==
                            ApiStatus.LOADING) {
                          return ShimmerApp.SendersShimmer();
                        }
                        if (poviderSender.getSenders.status ==
                            ApiStatus.COMPLETED) {
                          return SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        name = _searchController.text;
                                      },
                                      child: Text(
                                        '" ${_searchController.text}"',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.grey2Color,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  for (int i = 0;
                                      i <
                                          poviderSender
                                              .getSenders.data!['name']!.length;
                                      i++) ...{
                                    if ((poviderSender.getSenders
                                                .data!['name']?[i].first[
                                            poviderSender
                                                .getSenders
                                                .data!['name']?[i]
                                                .first
                                                .keys
                                                .first])!
                                        .contains(_searchController.text)) ...{
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: GestureDetector(
                                          onTap: () {
                                            id = poviderSender
                                                .getSenders
                                                .data!['name']?[i]
                                                .first
                                                .keys
                                                .first;
                                            name = poviderSender.getSenders
                                                    .data!['name']?[i].first[
                                                poviderSender
                                                    .getSenders
                                                    .data!['name']?[i]
                                                    .first
                                                    .keys
                                                    .first];
                                            mobile = mobile = poviderSender
                                                    .getSenders
                                                    .data!['name']?[i]
                                                    .last[
                                                poviderSender
                                                    .getSenders
                                                    .data!['name']?[i]
                                                    .first
                                                    .keys
                                                    .first];
                                            print(id);
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.person_outline,
                                                  size: 28,
                                                  color:
                                                      AppColors.greyboldColor,
                                                ),
                                                const SizedBox(width: 24),
                                                Text(
                                                  '${poviderSender.getSenders.data!['name']?[i].first[poviderSender.getSenders.data!['name']?[i].first.keys.first]}',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.greyboldColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    }
                                  },
                                ]),
                          );
                        }
                        return Text('${poviderSender.getSenders.message}');
                      },
                    )
                  }
                ],
              ),
            ),
          ),
        ));
  }

  Padding buildPadding(SendersProvider senderProvidr, int i, String catogrey) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            id = senderProvidr.getSenders.data![catogrey]?[i].first.keys.first;
            Provider.of<SenderMailsProvider>(context, listen: false)
                .setCurrentMailId(id);
            Navigator.pushNamed(context, senderMailsScreen.id);
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 28,
                  color: AppColors.greyboldColor,
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${senderProvidr.getSenders.data![catogrey]?[i].first[senderProvidr.getSenders.data![catogrey]?[i].first.keys.first]}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyboldColor,
                      ),
                    ),
                    Text(
                      '${senderProvidr.getSenders.data![catogrey]?[i].last[senderProvidr.getSenders.data![catogrey]?[i].first.keys.first]}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyboldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
