import 'dart:io';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:palmail_project/views/details_feature/shmmier_loading.dart';
import 'package:palmail_project/widgets/details_widget/my_container.dart';
import '../../models/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constant/app_constant.dart';
import '../../models/single_model.dart';
import '../../provider/search_provider.dart';
import '../../provider/single_mail_provider.dart';
import '../../provider/tag_provider.dart';
import '../../views/details_feature/status_page.dart';
import '../../views/details_feature/tag_selected.dart';
import 'package:motion_toast/motion_toast.dart';
// import 'package:palmailnadeenflutter327/views/details_feature/shmmier_loading.dart';
import '../../views/details_feature/status_page.dart';
// import 'package:palmailnadeenflutter327/views/details_feature/tag_selected.dart';
// import 'package:palmailnadeenflutter327/widgets/details_widget/my_container.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../constant/app_color.dart';
import '../../constant/app_constant.dart';
import '../../constant/app_string.dart';
import '../../provider/categories_provider.dart';
import '../../provider/mail_provider.dart';
import '../../provider/search_provider.dart';
import '../../provider/sender_mails_provider.dart';
import '../../provider/single_mail_provider.dart';
import '../../provider/statuses_provider.dart';
import '../../provider/tag_provider.dart';
import '../../provider/tags_provider.dart';
import '../../provider/user_provider.dart';
import '../../services/api_response.dart';
import '../../services/archive_maile/archive_maile_sharedpref.dart';
import '../../services/imagePicker/ImagePickerHelper.dart';
import '../../services/mange_language.dart';

import '../../services/screenshot_image/capture_image.dart';
import '../../widgets/container_bottomSheet.dart';
import '../../widgets/details_widget/custom_expansion_tile.dart';
import '../../widgets/my_bottomSheet.dart';
import '../home/home_screen.dart';
import 'animated_delte.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

import 'package:share_plus/share_plus.dart';
import 'dart:typed_data';
import 'dart:math' as math;

class DetailsScreen extends StatefulWidget {
  static String id = '/edit_mail';

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  GlobalKey globalKey = GlobalKey();
  List<int?>? tagSelect = [];
  List inboxSelect = [false, 1, Colors.red, 'Inbox'];
  List actLen = [];
  List tagsSelected = [
    [],
    [''],
    false
  ];
  ImagePickerHelper imagePickerHelper = ImagePickerHelper();
  String activities = '';
  List<Tag> selectedTags = [];
  User user = User();
  Mail? archiveMail;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isScreenShot = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tagsProvider = Provider.of<TagProvider>(context);
    final deleteMailProvider =
        Provider.of<SearchProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context).getUser;
    final mailsProvider = Provider.of<MailsProvider>(context, listen: false);
    final senderMailsProvider =
        Provider.of<SenderMailsProvider>(context, listen: false);
    final statusProvider =
        Provider.of<StatusesProvider>(context, listen: false);
    final TextEditingController activityController = TextEditingController();

    return container_bottomSheet(
        clip: AppConstant.isSelected ? Clip.hardEdge : Clip.none,
        margin: EdgeInsets.zero,
        radius: AppConstant.isSelected
            ? BorderRadius.circular(25)
            : BorderRadius.zero,
        context,
        child: RepaintBoundary(
          key: globalKey,
          child: Consumer<SingleMailProvider>(
            builder: (_, mailProvider, __) {
              debugPrint('Mail id: ${mailProvider.currentMailId}');
              debugPrint(
                  'mailProvider.getMail.status ${mailProvider.getMail.status}');
              if (mailProvider.getMail.status == ApiStatus.LOADING) {
                return ShimmerLoading.detailsPageShimmer();
              }
              if (mailProvider.getMail.status == ApiStatus.ERROR) {
                debugPrint('Error: ${mailProvider.getMail.message}');
                return Center(
                  child: Text(
                    '${mailProvider.getMail.message}',
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }

              Mail? mail = mailProvider.getMail.data;
              List<int?>? tagsEmpty = [];
              bool isComp = inboxSelect[3] == 'Completed';
              for (var tagId in mail?.tags ?? []) {
                tagsEmpty.add(tagId.id);
              }
              archiveMail = mail;
              List initStatus = [
                false,
                mail!.status?.id,
                mail.status?.color,
                mail.status?.name
              ];
              mail.activities?.sort((a, b) {
                final DateTime createdAtA =
                    DateTime.parse(a.createdAt ?? '1970-01-01 00:00:00');
                final DateTime createdAtB =
                    DateTime.parse(b.createdAt ?? '1970-01-01 00:00:00');
                return createdAtB.compareTo(createdAtA);
              });

              return Scaffold(
                  backgroundColor: AppColors.bcColor,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: AppColors.bcColor,
                    leading: IconButton(
                      icon: Transform(
                          transform:
                              Matrix4.rotationY(isRtl(context) ? math.pi : 0),
                          child: const Icon(CupertinoIcons.arrow_left)),
                      onPressed: () {
                        deleteMailProvider.noToggleBottomSheet();

                        setState(() {
                          activityController.clear();
                          actLen.clear();
                          mailProvider.files.clear();
                        });
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(
                      AppString.details.tr(),
                      style: AppConstant().tagsStyle.copyWith(fontSize: 18),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () async {
                            deleteMailProvider.noToggleBottomSheet();

                            await mailProvider.uploadImages();
                            if (mounted) {
                              Navigator.pop(context);
                            }
                            await mailProvider.updateMail(
                              decision: mail.decision,
                              finalDecision: mail.finalDecision,
                              tags: tagsSelected[0].isEmpty
                                  ? tagsEmpty
                                  : tagsSelected[0],
                              statusId: inboxSelect == []
                                  ? initStatus
                                  : ++inboxSelect[1],
                              userId: user?.id,
                              bodyText: activities,
                            );
                            deleteMailProvider.filterSearchList();
                            deleteMailProvider.isFilterApplied = false;
                            // await deleteMailProvider.searchRefresh();
                            if (mailProvider.isOpenHomeMails) {
                              mailsProvider.getAllMails();
                            }

                            if (deleteMailProvider.isOpenSenderMails) {
                              deleteMailProvider.toggleSenderMails();
                              senderMailsProvider.fetchMails();
                            }
                            statusProvider.getAllStatuses();
                            // MotionToast.success(
                            //   title: const Text("Success"),
                            //   description: Text(
                            //     'Mail Updated',
                            //   ),
                            //   width: MediaQuery.of(context).size.width * 0.85,
                            //   height: MediaQuery.of(context).size.height * 0.10,
                            // ).show(context);
                            Fluttertoast.showToast(
                              msg: 'Mail Updated',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                            );
                          },
                          icon: const Icon(
                            Icons.done,
                            color: AppColors.blueColor,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            _showCustomSnackBar(context);
                          },
                          icon: const Icon(
                            Icons.more_horiz,
                            color: AppColors.blueColor,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: AppConstant().boxdecoration,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12, left: 8, right: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.perm_identity_sharp),
                                          Text(mail.sender!.name ?? 'N/A',
                                              style: AppConstant()
                                                  .senderNameStyle),
                                        ],
                                      ),
                                      Text(
                                          AppConstant()
                                              .formatDate(mail.createdAt ?? ''),
                                          style: AppConstant().dateStyle),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4, left: 12, right: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(mail.sender?.category?.name ?? 'N/A',
                                          style:
                                              AppConstant().organiztionStyle),
                                      Text(
                                        'Arch ${AppConstant().formatDate(mail.archiveDate ?? '')}',
                                        style: AppConstant().txtStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                CustomExpandedTile(
                                  title: Text(
                                    mail.subject ?? '',
                                    style: AppConstant().titleStyle,
                                  ),
                                  content: Text(
                                    mail.description ?? '',
                                    style: AppConstant().txtStyle,
                                  ),
                                  onTap: () {
                                    debugPrint("tapped!!");
                                  },
                                  onLongTap: () {
                                    debugPrint("long tapped!!");
                                  },
                                  controller: AppConstant().controller,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () async {
                              tagsProvider.refreshData();
                              tagsSelected =
                                  await mybottomsheet(context, const MyTags());

                              setState(() {});
                            },
                            child: Container(
                              decoration: AppConstant().boxdecoration,
                              width: double.infinity,
                              height: 65,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            '# ',
                                            style: AppConstant()
                                                .txtStyle
                                                .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      AppColors.greyboldColor,
                                                  fontSize: 20,
                                                ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          for (var tag in mail.tags ?? [])
                                            Visibility(
                                              visible: !tagsSelected[2],
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(
                                                  '#${tag.name ?? '#'}',
                                                  style: AppConstant()
                                                      .txtStyle
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .grey2Color,
                                                        fontSize: 14,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          Visibility(
                                            visible: tagsSelected[2],
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: tagsSelected[0] == []
                                                    ? Text(
                                                        '${tagsSelected[1].join(' '
                                                            '#')}',
                                                        style: AppConstant()
                                                            .txtStyle
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .grey2Color,
                                                              fontSize: 14,
                                                            ))
                                                    : Text(
                                                        '${tagsSelected[1].join(' '
                                                            '#')}',
                                                        style: AppConstant()
                                                            .txtStyle
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .grey2Color,
                                                              fontSize: 14,
                                                            ))),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: Colors.black,
                                        size: 14,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () async {
                              inboxSelect = await mybottomsheet(
                                      context, const StatusPage()) ??
                                  [];

                              setState(() {});
                              setState(() {
                                inboxSelect == []
                                    ? inboxSelect = initStatus
                                    : inboxSelect = inboxSelect;
                                isComp = inboxSelect[3] == 'Completed';
                              });
                            },
                            child: Container(
                              decoration: AppConstant().boxdecoration,
                              width: double.infinity,
                              height: 65,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spa,
                                children: [
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  const Icon(
                                    CupertinoIcons.tags_solid,
                                    color: AppColors.blueColor,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        width: (12 * 12.0) + 20,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: inboxSelect[0] == true
                                              ? AppConstant()
                                                  .getCircleAvatarBackgroundColor(
                                                      inboxSelect[2])
                                              : AppConstant()
                                                  .getCircleAvatarBackgroundColor(
                                                      mail.status?.color),
                                        ),
                                        child: Center(
                                          child: Text(
                                            inboxSelect[0] == true
                                                ? inboxSelect[3]
                                                : mail.status?.name ?? '',
                                            style: AppConstant()
                                                .txtStyle
                                                .copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  const Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: Colors.black,
                                    size: 14,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Visibility(
                            visible:
                                !isComp && mail.status?.name != 'Completed',
                            child: Container(
                                decoration: AppConstant().boxdecoration,
                                child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(AppString.decision.tr() ?? '',
                                              style:
                                                  AppConstant().decisionStyle),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextField(
                                              cursorColor:
                                                  AppColors.primaryColor,
                                              onChanged: (decisionChange) {
                                                mail.decision = decisionChange;
                                              },
                                              controller: TextEditingController(
                                                  text: mail.decision ?? ''),
                                              decoration:
                                                  AppConstant().textDeco),
                                        ]))),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Visibility(
                            visible: isComp || mail.status?.name == 'Completed',
                            child: Container(
                                decoration: AppConstant().boxdecoration,
                                child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              AppString.finalDecision.tr() ??
                                                  '',
                                              style:
                                                  AppConstant().decisionStyle),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextField(
                                              cursorColor:
                                                  AppColors.primaryColor,
                                              onChanged: (decisionChange) {
                                                mail.finalDecision =
                                                    decisionChange;
                                              },
                                              controller: TextEditingController(
                                                  text:
                                                      mail.finalDecision ?? ''),
                                              decoration:
                                                  AppConstant().textDeco),
                                        ]))),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            decoration: AppConstant().boxdecoration,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextButton(
                                      child: Text(
                                        AppString.addImage.tr(),
                                        style: AppConstant()
                                            .subtextStyle
                                            .copyWith(
                                                color: AppColors.blueColor),
                                      ),
                                      onPressed: () async {
                                        mailProvider.handleGetImages();
                                      }),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  for (var attachment
                                      in mailProvider.attachmentList)
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                mailProvider.deleteImageMail(
                                                  statusId: mail.status?.id,
                                                  imageId: attachment.id,
                                                  imagePath: attachment.image,
                                                );
                                                // MotionToast.success(
                                                //   title: const Text("Success"),
                                                //   description: Text(AppString
                                                //       .imageDeleted
                                                //       .tr()),
                                                //   width: MediaQuery.of(context)
                                                //           .size
                                                //           .width *
                                                //       0.85,
                                                //   height: MediaQuery.of(context)
                                                //           .size
                                                //           .height *
                                                //       0.10,
                                                // ).show(context);

                                                Fluttertoast.showToast(
                                                  msg: AppString.imageDeleted
                                                      .tr(),
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                );
                                              },
                                              icon: const Icon(
                                                CupertinoIcons.delete_simple,
                                                size: 32,
                                                color: Colors.red,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 14,
                                            ),
                                            CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  'https://palmail.gsgtt'
                                                  '.tech/storage/${attachment.image}',
                                                ),
                                                radius: 20),
                                          ],
                                        ),
                                        if (attachment !=
                                                mailProvider
                                                    .attachmentList.last &&
                                            mailProvider.files == [])
                                          const Divider(),
                                      ],
                                    ),
                                  for (var file in mailProvider.files)
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                mailProvider.files.remove(file);

                                                mailProvider.notifyListeners();
                                              },
                                              icon: const Icon(
                                                CupertinoIcons.delete_simple,
                                                size: 32,
                                                color: Colors.red,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 14,
                                            ),
                                            CircleAvatar(
                                                backgroundImage:
                                                    FileImage(file),
                                                radius: 20),
                                          ],
                                        ),
                                        const Divider(),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomExpandedTile(
                            title: Text(
                              AppString.activity.tr(),
                              style: AppConstant().titleStyle,
                            ),
                            content: Column(
                              children: [
                                for (var index = actLen.length - 1;
                                    index >= 0;
                                    index--)
                                  Column(
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            'https://palmail.gsgtt'
                                            '.tech/storage/${user?.image}',
                                          ),
                                          radius: 16,
                                        ),
                                        title: Text(
                                          user?.name ?? AppString.noName.tr(),
                                          style: AppConstant().subtextStyle,
                                        ),
                                        subtitle: Text(
                                          actLen[index] ?? '',
                                          style: AppConstant().txtStyle,
                                        ),
                                        trailing: Text(
                                          AppConstant().formatDate(
                                              DateTime.now().toString()),
                                          style: AppConstant().txtStyle,
                                        ),
                                      ),
                                      if (index >= 0) const Divider(),
                                    ],
                                  ),
                                for (var activity in mail.activities ?? [])
                                  Column(
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            'http://palmail.gazawar.wiki/${activity.user?.image}',
                                          ),
                                          radius: 16,
                                        ),
                                        title: Text(
                                          activity.user?.name ??
                                              AppString.noName.tr(),
                                          style: AppConstant().subtextStyle,
                                        ),
                                        subtitle: Text(
                                          activity.body ?? 'txt',
                                          style: AppConstant().txtStyle,
                                        ),
                                        trailing: Text(
                                          AppConstant()
                                              .formatDate(activity.createdAt),
                                          style: AppConstant().txtStyle,
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                              ],
                            ),
                            onTap: () {},
                            onLongTap: () {},
                            controller: AppConstant().activityController,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            decoration: AppConstant().boxdecoration,
                            child: TextField(
                              onSubmitted: (value) {
                                setState(() {
                                  activities = activityController.text;
                                  activityController.clear();
                                });
                              },
                              controller: activityController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person_2_outlined),
                                suffix: IconButton(
                                  icon: const Icon(Icons.send_outlined),
                                  onPressed: () {
                                    setState(() {
                                      activities = activityController.text;

                                      actLen.add(activities);
                                      activityController.clear();
                                    });
                                  },
                                ),
                                hintText: AppString.addNewActivity.tr(),
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff898989),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextButton(
                              onPressed: () {
                                showCustomConfirmationDialog(context, mail.id!);
                              },
                              child: Text(AppString.deleteMail.tr(),
                                  style: AppConstant().deleteStyle))
                        ],
                      ),
                    ),
                  ));
            },
          ),
        ));
  }

  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();

    final Uint8List imageUint8List = await _captureWidgetAsImage();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Center(
          child: pw.Image(pw.MemoryImage(imageUint8List)),
        ),
      ),
    );

    return pdf.save();
  }

  Future<Uint8List> _captureWidgetAsImage() async {
    final boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<void> sharePdf() async {
    final pdfData = await generatePdf();

    final tempDir = await getTemporaryDirectory();
    final tempFilePath = '${tempDir.path}/mail.pdf';
    final tempFile = File(tempFilePath);
    await tempFile.writeAsBytes(pdfData);

    await Share.shareXFiles([XFile(tempFilePath)], text: 'Sharing PDF');
  }

  void _showCustomSnackBar(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      backgroundColor: AppColors.bcColor,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: height * .25,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppString.titleMail.tr(),
                      style: AppConstant().subtextStyle,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close_outlined,
                        color: AppColors.grey2Color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconTextContainer(
                      icon: Icons.archive_rounded,
                      text: AppString.archive.tr(),
                      onPressed: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        final List<Mail> archivedMails =
                            await getArchivedMailsFromSharedPreferences(prefs);

                        if (archivedMails
                            .any((mail) => mail.id == archiveMail?.id)) {
                          Fluttertoast.showToast(
                            msg: AppString.mailAlreayArchive.tr(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        } else {
                          archivedMails.add(archiveMail!);
                          saveMailsToSharedPreferences(prefs, archivedMails);
                          Fluttertoast.showToast(
                            msg: AppString.mailSuccessArchive.tr(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                          );
                        }
                        if (mounted) {
                          AppConstant.isSelected = false;
                          Navigator.pushNamed(context, HomeScreen.id);
                        }
                      },
                      color: AppColors.greyboldColor,
                    ),
                    IconTextContainer(
                      icon: CupertinoIcons.share,
                      text: AppString.share.tr(),
                      onPressed: () {
                        sharePdf();
                      },
                      color: AppColors.blueColor,
                    ),
                    IconTextContainer(
                      icon: Icons.screenshot_sharp,
                      text: AppString.image.tr(),
                      onPressed: () async {
                        await capturePng(context, globalKey);
                      },
                      color: AppColors.redColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
