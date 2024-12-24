import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import '../../../services/api_response.dart';
import '../../../views/search/filter_view.dart';
import 'package:provider/provider.dart';
import '../../constant/app_color.dart';
import '../../constant/app_constant.dart';
import '../../constant/app_string.dart';
import '../../models/mails_model.dart';
import '../../provider/search_provider.dart';
import '../../provider/single_mail_provider.dart';
import '../../provider/user_provider.dart';
import '../../widgets/container_bottomSheet.dart';
import '../../widgets/details_widget/custom_expansion_tile.dart';
import '../../widgets/my_bottomSheet.dart';
import '../details_feature/details_screen.dart';

class SearchScreen extends StatefulWidget {
  static const id = '/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(minutes: 2));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    final user = Provider.of<UserProvider>(context).getUser?.role?.id;

    return container_bottomSheet(context,
        clip: AppConstant.isSelected ? Clip.hardEdge : Clip.none,
        radius: AppConstant.isSelected
            ? BorderRadius.circular(25)
            : BorderRadius.zero,
        margin: AppConstant.isSelected
            ? const EdgeInsets.only(top: 45, left: 12, right: 12)
            : EdgeInsets.zero,
        child: Scaffold(
            backgroundColor: AppColors.bcColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.bcColor,
              leading: IconButton(
                  onPressed: () {
                    searchProvider.toggleRefresh();
                    Navigator.pop(context);
                  },
                  icon: const Icon(CupertinoIcons.back)),
              title: Center(
                child: Text(AppString.search.tr(),
                    style: AppConstant().tagsStyle.copyWith(fontSize: 20)),
              ),
            ),
            body: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextField(
                          focusNode: focusNode,
                          controller: searchProvider.searchController,
                          decoration: InputDecoration(
                            fillColor: AppColors.grey4Color,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  const BorderSide(color: AppColors.grey4Color),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  const BorderSide(color: AppColors.grey4Color),
                            ),
                            prefixIcon: const Icon(
                              CupertinoIcons.search,
                              color: AppColors.grey3Color,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                searchProvider.closePressed();
                                searchProvider.searchController.clear();
                                searchProvider.resetSearchResults();
                              },
                              child: Icon(
                                CupertinoIcons.clear_circled_solid,
                                color: searchProvider.isClosed
                                    ? AppColors.blueColor
                                    : AppColors.grey3Color,
                              ),
                            ),
                            hintText: AppString.search.tr(),
                          ),
                          onChanged: (text) {
                            searchProvider.fetchSearchList();
                            searchProvider.isFilterApplied = false;
                            searchProvider.notifyListeners();
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        searchProvider.isFilterPressed = true;
                        setState(() {
                          AppConstant.isSelected = true;
                        });
                        showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return const FilterScreen();
                          },
                        ).whenComplete(() {
                          setState(() {
                            AppConstant.isSelected = false;
                          });
                          // searchProvider.noToggleBottomSheet();
                          Provider.of<SearchProvider>(context, listen: false)
                              .filterSearchList();
                        });
                      },
                      icon: AppConstant().filterIcon,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Consumer<SearchProvider>(
                        builder: (_, searchProvider, __) {
                          if (searchProvider.searchList.status ==
                              ApiStatus.LOADING) {
                            return AppConstant().buildLoading();
                          }
                          if (searchProvider.searchList.status ==
                              ApiStatus.ERROR) {
                            return Center(
                              child:
                                  Text('${searchProvider.searchList.message}'),
                            );
                          }

                          List<Mail>? mails = searchProvider.searchList.data;
                          if (mails!.isEmpty) {
                            return SizedBox(
                                height: height * .6,
                                child: Center(
                                    child: Lottie.asset(
                                        'assets/svg/no_mails_found.json')));
                          }
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${mails.length} ${AppString.completed.tr()} ',
                                      style: AppConstant().resultStyle,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        searchProvider.togglePressed();
                                      },
                                      child: Text(
                                        AppString.show.tr(),
                                        style: AppConstant()
                                            .resultStyle
                                            .copyWith(
                                                color: AppColors.blueColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              if (searchProvider.isShowPressed)
                                Column(
                                  children: List.generate(
                                    mails.length,
                                    (index) {
                                      Mail? mail = mails[index];
                                      bool isLengthGreaterThan15 = (mail.sender
                                                  ?.category?.name?.length ??
                                              0) >
                                          15;
                                      String formattedDate =
                                          isLengthGreaterThan15
                                              ? DateFormat('dd-M-yy').format(
                                                  DateTime.parse(
                                                      mail.createdAt ?? ''))
                                              : DateFormat('dd-MM-yyyy').format(
                                                  DateTime.parse(
                                                      mail.createdAt ?? ''));
                                      searchProvider.controllers.add(
                                          ExpandedTileController(
                                              isExpanded: false));

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8, bottom: 8),
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (user != 1) {
                                              Provider.of<SingleMailProvider>(
                                                      context,
                                                      listen: false)
                                                  .setCurrentMailId(mail.id);
                                              setState(() {
                                                AppConstant.isSelected = true;
                                              });
                                              // searchProvider.toggleBottomSheet();

                                              await mybottomsheet(
                                                context,
                                                const DetailsScreen(),
                                              ).whenComplete(() {
                                                Provider.of<SearchProvider>(
                                                        context,
                                                        listen: false)
                                                    .searchList;
                                                setState(() {
                                                  AppConstant.isSelected =
                                                      false;
                                                });
                                              });
                                            }
                                          },
                                          child: MailExpandedTile(
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor: AppConstant()
                                                              .getCircleAvatarBackgroundColor(
                                                                  mail.status?[
                                                                      'color']),
                                                          radius: 8,
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          mail.sender?.category
                                                                  ?.name ??
                                                              "N/A",
                                                          style: AppConstant()
                                                              .titleNameStyle
                                                              .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      formattedDate,
                                                      style: AppConstant()
                                                          .resultStyle,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  mail.subject ?? '',
                                                  style: AppConstant()
                                                      .resultStyle
                                                      .copyWith(
                                                        color: Colors.black,
                                                      ),
                                                ),
                                                Text(
                                                  mail.description ?? '',
                                                  style: AppConstant()
                                                      .resultStyle
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                Wrap(
                                                  spacing: 12.0,
                                                  children:
                                                      mail.tags?.map((tag) {
                                                            return Text(
                                                              '#${tag.name}',
                                                              style:
                                                                  AppConstant()
                                                                      .tagsStyle,
                                                            );
                                                          }).toList() ??
                                                          [],
                                                ),
                                                Wrap(
                                                  spacing: 8.0,
                                                  children: mail.attachments
                                                          ?.map((attachment) {
                                                        return CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                            'https://palmail.gsgtt.tech/storage/${attachment.image}',
                                                          ),
                                                          radius: 16,
                                                        );
                                                      }).toList() ??
                                                      [],
                                                ),
                                              ],
                                            ),
                                            content: Container(),
                                            onLongTap: () {},
                                            controller: searchProvider
                                                .controllers[index],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              else
                                ScaleTransition(
                                  scale:
                                      Tween<double>(begin: 0, end: 1).animate(
                                    CurvedAnimation(
                                      parent: animationController,
                                      curve: Curves.easeInOut,
                                    ),
                                  ),
                                  child: const Text(''),
                                )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ])));
  }

  Map<String, int> getCategoryCounts(List<Mail> mails) {
    final categoryCounts = <String, int>{};

    for (final mail in mails) {
      final category = mail.sender?.category?.name ?? 'N/A';
      categoryCounts[category] = (categoryCounts[category] ?? 0) + 1;
    }

    return categoryCounts;
  }
}
