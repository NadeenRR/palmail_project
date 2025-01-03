import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constant/app_color.dart';
import '../../constant/app_constant.dart';
import '../../constant/app_string.dart';
import '../../constant/shimmer.dart';
import '../../controller/auth_controller.dart';
import '../../provider/categories_provider.dart';
import '../../provider/mail_provider.dart';
import '../../provider/search_provider.dart';
import '../../provider/single_mail_provider.dart';
import '../../provider/statuses_provider.dart';
import '../../provider/tags_provider.dart';
import '../../provider/user_provider.dart';
import '../../services/mange_language.dart';
import '../../widgets/container_bottomSheet.dart';
import '../../widgets/my_bottomSheet.dart';
import '../details_feature/details_screen.dart';
import '../new_mail/mail/new_mail.dart';
import '../search/search_screen.dart';
import '../splah/splash_screen.dart';
import 'change_password.dart';
import 'drawer_screen.dart';
import 'mails_for_single_statues.dart';
import 'widgets/add_new_inbox_widget.dart';
import 'widgets/add_new_tag.dart';
import 'widgets/category_expansion_tile.dart';
import 'widgets/category_widget.dart';
import 'widgets/mail_tags.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const id = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;
  List<int> tags = [];

  bool isContainerVisible = false;

  void toggleContainerVisibility() {
    setState(() {
      isContainerVisible = !isContainerVisible;
    });
  }

  @override
  void initState() {
    Provider.of<StatusesProvider>(context, listen: false).getAllStatuses();
    Provider.of<CategoriesProvider>(context, listen: false).getAllCategories();
    Provider.of<MailsProvider>(context, listen: false).getAllMails();
    Provider.of<TagsProvider>(context, listen: false).getAllTags();
    Provider.of<UserProvider>(context, listen: false).getSingleUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final id_role = Provider.of<UserProvider>(context).getUser;

    final singleMailProvider =
        Provider.of<SingleMailProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context).getUser?.role?.id;
    return container_bottomSheet(context,
        clip: AppConstant.isSelected ? Clip.hardEdge : Clip.none,
        radius: AppConstant.isSelected
            ? BorderRadius.circular(25)
            : BorderRadius.zero,
        margin: AppConstant.isSelected
            ? const EdgeInsets.only(top: 45, left: 12, right: 12)
            : EdgeInsets.zero,
        child: GestureDetector(
            onTap: () {
              setState(() {
                isContainerVisible = false;
              });
            },
            child: Scaffold(
              body: Stack(
                children: [
                  DrawerScreen(
                    onTap: () {
                      setState(() {
                        xOffset = 0;
                        yOffset = 0;
                        scaleFactor = 1;
                        isDrawerOpen = false;
                      });
                    },
                  ),
                  AnimatedContainer(
                    height: size.height,
                    transform: Matrix4.translationValues(
                        isRtl(context)
                            ? (isDrawerOpen
                                ? (isRtl(context)
                                    ? -0.3 * xOffset
                                    : 0.5 * xOffset)
                                : 0)
                            : (isDrawerOpen ? xOffset : 0),
                        yOffset,
                        0)
                      ..scale(scaleFactor)
                      ..rotateY(
                          isDrawerOpen ? (isRtl(context) ? 0.5 : -0.5) : 0),
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x4dcdccf1),
                          offset: Offset(0, 5),
                          blurRadius: 8,
                        ),
                      ],
                      color: AppColors.bcColor,
                      borderRadius:
                          BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
                    ),
                    child: SafeArea(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 12, right: 12, left: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        isDrawerOpen
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    xOffset = 0;
                                                    yOffset = 0;
                                                    scaleFactor = 1;
                                                    isDrawerOpen = false;
                                                  });
                                                },
                                                child: Transform(
                                                  transform: Matrix4.rotationY(
                                                      isRtl(context)
                                                          ? math.pi
                                                          : 0),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    width: 40,
                                                    height: 40,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: SvgPicture.asset(
                                                      'assets/svg/cloas.svg',
                                                    ),
                                                  ),
                                                ))
                                            : GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    xOffset = 270;
                                                    // xOffset = size.width - 200;
                                                    yOffset = 150;
                                                    scaleFactor = 0.6;
                                                    isDrawerOpen = true;
                                                  });
                                                },
                                                child: SvgPicture.asset(
                                                  'assets/svg/menu.svg',
                                                ),
                                              ),
                                        const Spacer(),
                                        Text(
                                          AppString.nameApp.tr(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            Provider.of<SearchProvider>(context,
                                                    listen: false)
                                                .noToggleBottomSheet();
                                            Navigator.pushNamed(
                                                context, SearchScreen.id);
                                          },
                                          icon:
                                              const Icon(CupertinoIcons.search),
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              width: 45,
                                              height: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Consumer<UserProvider>(
                                              builder: (BuildContext context,
                                                  value, Widget? child) {
                                                    //http://palmail.gazawar.wiki/
                                                final user = value.getUser;
                                                final backgroundImage = user
                                                            ?.image !=
                                                        null
                                                    ? CachedNetworkImageProvider(
                                                        'http://palmail.gazawar.wiki/${user!.image}')
                                                    : const AssetImage(
                                                        'assets/images/user.jpg');

                                                return GestureDetector(
                                                  onTap:
                                                      toggleContainerVisibility,
                                                  child: CircleAvatar(
                                                    radius: 20,
                                                    backgroundImage:
                                                        backgroundImage
                                                            as ImageProvider,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Consumer<StatusesProvider>(
                                      builder: (BuildContext context, value,
                                          Widget? child) {
                                        final allEmailStatuses =
                                            value.getStatuses;
                                        print(
                                            'allEmailStatuses $allEmailStatuses');
                                        if (allEmailStatuses != null) {
                                          return GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 5 / 3,
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 8,
                                              mainAxisSpacing: 12,
                                            ),
                                            itemCount: 4,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          MailsForSingleStatues(
                                                        statusId:
                                                            allEmailStatuses[
                                                                    index]
                                                                .id!,
                                                        name: allEmailStatuses[
                                                                index]
                                                            .name!,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: CategoryWidget(
                                                  categoryName:
                                                      allEmailStatuses[index]
                                                          .name!,
                                                  backgroundColor: Color(
                                                    int.parse(
                                                        allEmailStatuses[index]
                                                            .color!),
                                                  ),
                                                  number:
                                                      allEmailStatuses[index]
                                                          .mailsCount!,
                                                  size: size,
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          return ShimmerApp.statusesShimmer(
                                              size);
                                        }
                                        //   if(mounted){

                                        //   }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    GestureDetector(
                                      onTap: () async {},
                                      child: Consumer2<CategoriesProvider,
                                          MailsProvider>(
                                        builder:
                                            (context, value, mailValue, child) {
                                          final allCategories =
                                              value.getCategories;
                                          final allMails = mailValue.getMails;

                                          if (allCategories != null &&
                                              allMails != null) {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemCount: allCategories.length,
                                              itemBuilder: (context, index) {
                                                if (index >=
                                                    allCategories.length) {
                                                  return const SizedBox();
                                                }

                                                final category =
                                                    allCategories[index];

                                                final filter = allMails
                                                    .where((mail) =>
                                                        mail.sender?.category
                                                            ?.name ==
                                                        category.name)
                                                    .toList();

                                                return CategoryExpansionTile(
                                                  organization: category.name!,
                                                  count: filter.length,
                                                  child: ListView.separated(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: filter.length,
                                                    itemBuilder:
                                                        (context, subIndex) {
                                                      if (subIndex >=
                                                          filter.length) {
                                                        return const SizedBox();
                                                      }

                                                      final mail =
                                                          filter[subIndex];
                                                      final color = int.parse(
                                                          mail.status?.color ??
                                                              '0');

                                                      DateTime parsedDateTime;

                                                      try {
                                                        parsedDateTime =
                                                            DateTime.parse(mail
                                                                .createdAt!);
                                                      } catch (e) {
                                                        parsedDateTime =
                                                            DateTime.now();
                                                      }
                                                      return GestureDetector(
                                                        onTap: () async {
                                                          if (user != 1) {
                                                            setState(() {
                                                              AppConstant
                                                                      .isSelected =
                                                                  true;
                                                              AppConstant
                                                                      .isOpenHomecreen =
                                                                  true;
                                                            });
                                                            singleMailProvider
                                                                .setCurrentMailId(
                                                                    mail.id!);
                                                            singleMailProvider
                                                                .toggleHomeMails();

                                                            await mybottomsheet(
                                                              context,
                                                              const DetailsScreen(),
                                                            ).whenComplete(() {
                                                              setState(() {
                                                                AppConstant
                                                                        .isSelected =
                                                                    false;
                                                                AppConstant
                                                                        .isOpenHomecreen =
                                                                    false;
                                                              });
                                                              Provider.of<MailsProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .getAllMails();
                                                            });
                                                          }
                                                        },
                                                        child:
                                                            ExpansionTileCustome(
                                                                size: size,
                                                                color: color,
                                                                date: DateFormat('dd-MM-yyyy')
                                                                    .format(
                                                                        parsedDateTime),
                                                                organizationName:
                                                                    mail.sender
                                                                            ?.name ??
                                                                        '',
                                                                subTitle:
                                                                    mail.description ??
                                                                        '',
                                                                subject:
                                                                    mail.subject ??
                                                                        '',
                                                                tag: mail.tags!
                                                                    .map((e) =>
                                                                        e.name)
                                                                    .toList()
                                                                    .join(' #'),
                                                                imageList:
                                                                    SizedBox(
                                                                  height: 50,
                                                                  child: ListView
                                                                      .builder(
                                                                          scrollDirection: Axis
                                                                              .horizontal,
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: mail
                                                                              .attachments!
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, attachmentIndex) {
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
                                                                                  image: CachedNetworkImageProvider(imageUrl),
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }),
                                                                )),
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (context, subIndex) =>
                                                            const SizedBox(
                                                                height: 20),
                                                  ),
                                                );
                                              },
                                            );
                                          } else {
                                            return ShimmerApp
                                                .categoriesShimmer();
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      AppString.tags.tr(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        color: const Color(0xff272727),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffffffff),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Consumer<TagsProvider>(
                                        builder: (context, value, child) {
                                          final allTags = value.getTags;

                                          if (allTags != null) {
                                            return Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Wrap(
                                                spacing: 8.0,
                                                runSpacing: 8.0,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      List<int> tags = [];
                                                      for (var i = 0;
                                                          i < allTags.length;
                                                          i++) {
                                                        tags.add(
                                                            allTags[i].id!);
                                                      }

                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return MailOfTags(
                                                          ids: tags,
                                                        );
                                                      }));
                                                      print(tags);
                                                    },
                                                    child: const AddNewTag(
                                                      tag: 'All Tags',
                                                    ),
                                                  ),
                                                  for (var i = 0;
                                                      i < allTags.length;
                                                      i++) ...[
                                                    GestureDetector(
                                                      onTap: () {
                                                        tags.add(
                                                          allTags[i].id!,
                                                        );
                                                        // #///////////////////////////////////////////////////////////////////////
                                                        print(allTags[i].id);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return MailOfTags(
                                                            ids: tags,
                                                          );
                                                        }));
                                                      },
                                                      child: AddNewTag(
                                                        tag: allTags[i]
                                                            .name
                                                            .toString(),
                                                      ),
                                                    )
                                                  ]
                                                ],
                                              ),
                                            );
                                          } else {
                                            return ShimmerApp.tagsShimmer();
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: id_role?.role?.id == 4 ||
                                id_role?.role?.id == 3,
                            child: GestureDetector(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    isDrawerOpen ? 40 : 0.0),
                                child: AddNewInboxWidget(
                                  size: size,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  AppConstant.isSelected = true;
                                  mybottomsheet(context, const NewMail())
                                      .whenComplete(() {
                                    setState(() {
                                      AppConstant.isSelected = false;
                                    });
                                  });
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    //   right: 12,
                    right: isRtl(context) ? null : 12,
                    left: isRtl(context) ? 12 : null,

                    child: Visibility(
                      visible: isContainerVisible,
                      child: Container(
                        width: size.height * 0.3,
                        height: size.height * 0.48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x4dcdccf1),
                              offset: Offset(0, 5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Consumer<UserProvider>(
                          builder: (context, value, child) {
                            final userInfo = value.getUser;
                            print('userInfo image ${userInfo?.image}');

                            final backgroundImage = userInfo?.image != null
                                ? CachedNetworkImageProvider(
                                    'http://palmail.gazawar.wiki/${userInfo!.image}')
                                : const AssetImage('assets/images/user.jpg');
                            //    if (userInfo != null) {

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      backgroundImage as ImageProvider,
                                ),
                                Text(
                                  userInfo?.name ?? 'Nadeen',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  userInfo?.role?.name ?? '',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                ListTile(
                                  onTap: () async {
                                    final localization =
                                        EasyLocalization.of(context);
                                    if (localization != null) {
                                      print(
                                          'log out'); // Print a message to confirm the logout action
                                      AuthController().logout().then((value) {
                                        if (value) {
                                          // After successful logout, change the language
                                          final newLocale =
                                              localization.locale ==
                                                      const Locale('en', 'US')
                                                  ? const Locale('ar', 'SA')
                                                  : const Locale('en', 'US');
                                          localization.setLocale(newLocale);
                                          Phoenix.rebirth(context);
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            SplashScreen.id,
                                            (_) => false,
                                          );
                                        }
                                      });
                                    }
                                  },
                                  title: Text(AppString.lang.tr()),
                                  leading: const Icon(Icons.language),
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      ChanagePassword.id,
                                    );
                                  },
                                  title: Text(AppString.chnagePassword.tr()),
                                  leading: const Icon(Icons.edit),
                                ),
                                ListTile(
                                  onTap: () {
                                    AppConstant.dialogBuilder(context, () {
                                      AuthController().logout().then((value) {
                                        if (value) {
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            SplashScreen.id,
                                            (_) => false,
                                          );
                                        }
                                      });
                                    });
                                  },
                                  title: Text(
                                    AppString.logout.tr(),
                                  ),
                                  leading: const Icon(Icons.logout),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  Future logoutUser() async {
    AuthController().logout().then((value) {
      if (value) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          SplashScreen.id,
          (_) => false,
        );

        Fluttertoast.showToast(
          msg: AppString.logoutSuccess.tr(),
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          backgroundColor: Colors.green,
          fontSize: 14.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: AppString.logoutFailed.tr(),
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          backgroundColor: Colors.red,
          fontSize: 14.0,
        );
      }
    });
  }
}
