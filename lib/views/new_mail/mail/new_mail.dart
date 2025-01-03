import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constant/app_color.dart';
import '../../../constant/app_constant.dart';
import '../../../provider/user_provider.dart';
import '../../../views/new_mail/add_statues/new_statues.dart';
import '../../../views/new_mail/mail/widgets/activities_expanation_tile.dart';
import '../../../views/new_mail/mail/widgets/my_tile.dart';
import '../../../views/new_mail/mail/widgets/snack_bar.dart';
import '../../../views/new_mail/tags/tags.dart';
import '../../../widgets/container_bottomSheet.dart';
import '../../../widgets/my_bottomSheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import '../../../constant/app_assets.dart';
import '../../../constant/app_string.dart';
import '../../../controller/Categorey/all_categorey_cont.dart';
import '../../../controller/attachment/upload_attachement.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/mail/create_mail_rep.dart';
import '../../../controller/senders/create_sender_rep.dart';
import '../../../provider/categories_provider.dart';
import '../../../provider/mail_provider.dart';
import '../../../provider/sender_provider.dart';
import '../../../provider/statuses_provider.dart';
import '../../../provider/tag_provider.dart';
import '../../../provider/tags_provider.dart';
import '../../../services/shared_pref_helper.dart';
import '../categorey/categorey_page.dart';
import '../sender search/sender_search.dart';
import 'dart:math';

class NewMail extends StatefulWidget {
  const NewMail({Key? key}) : super(key: key);
  static const id = 'newMail';

  @override
  State<NewMail> createState() => _NewMailState();
}

class _NewMailState extends State<NewMail> {
  List<Map<String, dynamic>> mapActivities = [];
  String categorey_select = 'OTHER';
  List<int?>? tag_select = [];
  List<int?> tag_complete = [];
  List sender_id_name = [];
  int? id;
  List inbox_select = [1, 0xFFE62929.toString(), 'inbox'];
  String selectedDate = '';
  FocusNode myFocusNode = FocusNode();
  final TextEditingController _senderController = TextEditingController();
  final TextEditingController _DesisionController = TextEditingController();
  final TextEditingController _FinalDesisionController =
      TextEditingController();
  String sender = '';
  String desicion = '';
  String finaldesicion = '';
  final TextEditingController _titleController = TextEditingController();
  String title = '';
  final TextEditingController _phoneNumber = TextEditingController();
  String mobile = '';
  final TextEditingController _DescController = TextEditingController();
  String Desc = '';
  final TextEditingController _ArchiveContoller = TextEditingController();
  String ArchieveNumber = '';
  final TextEditingController _activityController = TextEditingController();
  String Actitivties = '';
  Decoration containerDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(24),
    color: Colors.white,
  );
  AllCategoreyCont cont = AllCategoreyCont();
  List<XFile> selectedImages = [];
  List<int> randomNumbers = [];
  final picker = ImagePicker();

  File? file;
  DateTime date = DateTime.now();

  Future<void> getImages() async {
    final pickedFiles = await picker.pickMultipleMedia(
      imageQuality: 100,
      maxHeight: 80,
      maxWidth: 80,
    );
    setState(() {
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        // Do something with the pickedFiles list (e.g., display the images).
        for (XFile pickedFile in pickedFiles) {
          print('File path: ${pickedFile.path}');
          selectedImages.add(pickedFile);
          // You can add the picked files to a list or perform other actions here.
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')),
        );
      }
    });
  }

  @override
  void initState() {
    validate_date = false;
    // TODO: implement initState
    super.initState();
  }

  String name = 'inbox';

  int? select_cat = 1;
  int? id_cateogrey(String cateogrey) {
    switch (categorey_select) {
      case 'OTHER':
        select_cat = 1;
        break;
      case 'OFFICIAL_ORGANIZATION':
        select_cat = 2;
        break;

      case 'NG_OS':
        select_cat = 3;
        break;

      case 'FOREIGN':
        select_cat = 4;
        break;

      default:
        select_cat = 1;
        break;
    }
    return select_cat;
  }

  bool validate_mobile = false;
  Future<void> NullIdDone() async {
    if (_phoneNumber.text != '' &&
        title != '' &&
        ArchieveNumber != '' &&
        selectedDate != '') {
      await createSender({
        'name': _senderController.text,
        'mobile': mobile,
        'address': '',
        'category_id': select_cat.toString(),
      }).then((value) async {
        MotionToast.success(
          title: const Text("Success"),
          description: const Text("Sender Created"),
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.10,
        ).show(context);
        int? idSender = value.sender?.first.id;
        print('test');
        await createEmail({
          'subject': title,
          'description': Desc,
          'sender_id': idSender.toString(),
          'archive_number': ArchieveNumber,
          'archive_date': selectedDate,
          'decision': desicion,
          'status_id': inbox_select[0].toString(),
          'final_decision': finaldesicion,
          'tags': jsonEncode(tag_select),
          'activities': jsonEncode(mapActivities),
        }).then((value) async {
          print(value);
          int mailId = value.mail!.id!;

          for (int i = 0; i < selectedImages.length; i++) {
            await uploadImage(File(selectedImages[i].path), mailId);
          }
          Navigator.pop(context);
          Provider.of<StatusesProvider>(context, listen: false)
              .getAllStatuses();
          Provider.of<CategoriesProvider>(context, listen: false)
              .getAllCategories();
          Provider.of<MailsProvider>(context, listen: false).getAllMails();
          Provider.of<TagsProvider>(context, listen: false).getAllTags();
          Provider.of<UserProvider>(context, listen: false).getSingleUser();
          // MotionToast.success(
          //   title: const Text("Success"),
          //   description: const Text("Mail Created"),
          //   width: MediaQuery.of(context).size.width * 0.85,
          //   height: MediaQuery.of(context).size.height * 0.10,
          // ).show(context);
          // Fluttertoast.showToast(
          //   msg:"Mail Created",
          //   toastLength:
          //   Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.BOTTOM,
          //   timeInSecForIosWeb: 1,
          //   backgroundColor: Colors.green,
          //   textColor: Colors.white,
          // );
        });
      });
    } else {
      setState(() {
        _senderController.text == ''
            ? validate_sender = true
            : validate_sender = false;
      });

      setState(() {
        _phoneNumber.text == ''
            ? validate_mobile = true
            : validate_mobile = false;

        title == '' ? validate = true : validate = false;
      });
      setState(() {
        ArchieveNumber == ''
            ? validate_archive = true
            : validate_archive = false;
      });
      setState(() {
        desicion == '' || finaldesicion == ''
            ? validate_decision = true
            : validate_decision = false;
        selectedDate == '' ? validate_date = true : validate_date = false;
      });
    }
  }

  bool validate = false;
  bool validate_sender = false;
  bool validate_archive = false;
  bool validate_decision = false;
  bool validate_date = false;

  Future<void> NotNullIdDone() async {
    if (title != '' &&
        ArchieveNumber != '' &&
        selectedDate != '' &&
        (desicion != '' || finaldesicion != null)) {
      await createEmail({
        'subject': title,
        'description': Desc,
        'sender_id': id.toString(),
        'archive_number': ArchieveNumber,
        'archive_date': selectedDate,
        'decision': desicion,
        'status_id': inbox_select[0].toString(),
        'final_decision': finaldesicion,
        'tags': jsonEncode(tag_select),
        'activities': jsonEncode(mapActivities),
      }).then((value) async {
        int? mailId = value.mail!.id!;

        for (int i = 0; i < selectedImages.length; i++) {
          await uploadImage(File(selectedImages[i].path), mailId);
        }
        Navigator.pop(context);
        MotionToast.success(
          title: const Text("Success"),
          description: const Text("Mail Created Successfully"),
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.8,
        ).show(context);
        print(value.mail?.status);
      });
    } else {
      setState(() {
        title == '' ? validate = true : validate = false;
      });
      setState(() {
        ArchieveNumber == ''
            ? validate_archive = true
            : validate_archive = false;
      });
      setState(() {
        desicion == '' || finaldesicion == ''
            ? validate_decision = true
            : validate_decision = false;
        selectedDate == '' ? validate_date = true : validate_date = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sendersProvider = Provider.of<SendersProvider>(context);
    final tagsProvider = Provider.of<TagProvider>(context);
    final user = Provider.of<UserProvider>(context).getUser;

    return container_bottomSheet(
        clip: AppConstant.isSelected ? Clip.hardEdge : Clip.none,
        margin: EdgeInsets.zero,
        radius: AppConstant.isSelected
            ? BorderRadius.circular(25)
            : BorderRadius.zero,
        context,
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
                style: TextStyle(
                  color: Color(0xff6589FF),
                  fontSize: 20,
                ),
              ),
              onPressed: () async {},
            ),
            title: Text(
              AppString.newInbox.tr(),
              style: TextStyle(
                color: Color(0xff272727),
                fontSize: 24,
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  AppString.done.tr(),
                  style: TextStyle(
                    color: Color(0xff6589FF),
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  if (id == null) {
// id null
                    await NullIdDone();
                  } else {
// id not null

                    await NotNullIdDone();
                  }
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: containerDecoration,
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              _senderController.text = sender_id_name[1];

                              sender_id_name[1] == null
                                  ? validate_sender = true
                                  : validate_sender = false;
                            });
                          },
                          controller: _senderController,
                          decoration: InputDecoration(
                            errorBorder: InputBorder.none,
                            errorText:
                                validate_sender ? 'You must fill Sender' : null,
                            border: InputBorder.none,
                            enabled:
                                id == null && _senderController.text.isEmpty
                                    ? true
                                    : false,
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.info_outline_rounded,
                                size: 28,
                              ),
                              onPressed: () async {
                                sendersProvider.refreshData();
                                sender_id_name = await mybottomsheet(
                                  context,
                                  const senderPage(),
                                );
                                setState(() {
                                  if (sender_id_name[0] != null) {
                                    _senderController.text = sender_id_name[1];
                                    id = sender_id_name[0];
                                    mobile = sender_id_name[2];
                                    validate_sender = false;
                                    validate_mobile = false;
                                  } else {
                                    _senderController.text = sender_id_name[1];
                                    validate_sender = false;
                                  }
                                });
                              },
                            ),
                            suffixIconColor: MaterialStateColor.resolveWith(
                              (states) => states.contains(MaterialState.focused)
                                  ? Colors.black
                                  : const Color(0xff6589FF),
                            ),
                            hintText:
                                id == null && _senderController.text.isEmpty
                                    ? 'Sender'
                                    : _senderController.text,
                            hintStyle: TextStyle(
                              fontSize:
                                  id == null && _senderController.text.isEmpty
                                      ? 20
                                      : 18,
                              fontWeight: FontWeight.w400,
                              color: myFocusNode.hasFocus
                                  ? Colors.black
                                  : Colors.grey.shade400,
                            ),
                            prefixIcon: IconButton(
                              onPressed: () async {},
                              icon: const Icon(
                                Icons.person_2_outlined,
                                size: 28,
                              ),
                            ),
                            prefixIconColor: MaterialStateColor.resolveWith(
                              (states) => states.contains(MaterialState.focused)
                                  ? Colors.black
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey.shade400,
                          indent: 12,
                        ),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              mobile = _phoneNumber.text;
                              mobile.isEmpty
                                  ? validate_mobile = true
                                  : validate_mobile = false;
                            });
                          },
                          controller: _phoneNumber,
                          decoration: InputDecoration(
                            errorText: validate_mobile
                                ? 'You must fill mobile number'
                                : null,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 4,
                            ),
                            enabled: id == null ? true : false,
                            hintText: id == null ? 'Phone Number' : mobile,
                            hintStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: myFocusNode.hasFocus
                                  ? Colors.black
                                  : Colors.grey.shade400,
                            ),
                            prefixIcon: IconButton(
                              onPressed: () async {},
                              icon: const Icon(
                                Icons.phone_android_rounded,
                                size: 28,
                              ),
                            ),
                            prefixIconColor: MaterialStateColor.resolveWith(
                              (states) => states.contains(MaterialState.focused)
                                  ? Colors.black
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                        Divider(
                          indent: 12,
                          color: Colors.grey.shade400,
                        ),
                        GestureDetector(
                          onTap: () {
                            mybottomsheet(context, const catecoreyPage());
                          },
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 12,
                              ),
                              const Text(
                                'Category',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff272727),
                                ),
                              ),
                              const SizedBox(width: 117),
                              SizedBox(
                                width: 100,
                                // height: 50,
                                child: Text(
                                  categorey_select,
                                  style: TextStyle(
                                    fontSize:
                                        categorey_select.length < 12 ? 16 : 12,
                                    color: Color(0xff7C7C7C),
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  try {
                                    categorey_select = await mybottomsheet(
                                        context, const catecoreyPage());
                                    id_cateogrey(categorey_select);
                                    setState(() {});
                                  } catch (e) {}

                                  print('$categorey_select test');
                                },
                                icon: const Icon(
                                    Icons.arrow_forward_ios_outlined),
                                color: const Color(0xff7C7C7C),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.all(12),
                      decoration: containerDecoration,
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                title = _titleController.text;
                                title.isEmpty
                                    ? validate = true
                                    : validate = false;
                              });
                            },
                            controller: _titleController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              errorText:
                                  validate ? 'You must fill Title' : null,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 4,
                              ),
                              hintText: 'Title of mail',
                              hintStyle: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffAFAFAF),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.all(
                                //   Radius.circular(25),
                                // ),
                                borderSide: BorderSide(
                                    color: Colors
                                        .transparent), // Change border color here
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey.shade400,
                          ),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                Desc = _DescController.text;
                              });
                            },
                            controller: _DescController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 4,
                              ),
                              hintText: 'Description',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Color(0xffAFAFAF),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.all(
                                //   Radius.circular(25),
                                // ),
                                borderSide: BorderSide(
                                    color: Colors
                                        .transparent), // Change border color here
                              ),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: containerDecoration,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CategoryExpansionTile(
                              onSelectdate: (value) {
                                setState(() {
                                  date = value;
                                  selectedDate =
                                      '${value.year}-${value.month}-${value.day}';
                                  validate_date = false;
                                });
                              },
                              date: date!,
                            ),
                            Visibility(
                                visible: validate_date,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 57.0),
                                  child: Text(
                                    'you must select date',
                                    style:
                                        TextStyle(color: Colors.red.shade700),
                                    textAlign: TextAlign.start,
                                  ),
                                ))
                          ],
                        ),
                        Divider(
                          color: Colors.grey.shade400,
                          indent: 60,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.archive_outlined,
                            color: Color(0xff6F7CA7),
                            size: 32,
                          ),
                          title: Text(
                            'Archive Number',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(
                                0xff272727,
                              ),
                            ),
                          ),
                          subtitle: TextField(
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                ArchieveNumber = _ArchiveContoller.text;
                                ArchieveNumber == ''
                                    ? validate_archive = true
                                    : validate_archive = false;
                                print(
                                    '$ArchieveNumber ArchieveNumberArchieveNumber');
                              });
                            },
                            controller: _ArchiveContoller,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              errorText: validate_archive
                                  ? 'You must fill Archive Number'
                                  : null,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 0,
                              ),
                              hintText: '2022/6019',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Color(0xffAFAFAF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: containerDecoration,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        const Icon(
                          Icons.tag_sharp,
                          color: Color(0xff707070),
                          size: 28,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text(
                          'Tags',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff272727),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () async {
                            tagsProvider.refreshData();
                            tag_select =
                                await mybottomsheet(context, const tagPage());

                            print('$tag_select test');
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 28,
                          ),
                          color: const Color(0xffB2B2B2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: containerDecoration,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(
                          Icons.inbox,
                          color: Color(0xff707070),
                          size: 28,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(int.parse(inbox_select[1])),
                          ),
                          child: Text(
                            inbox_select[2],
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.w300,
                              color: Color(0xffF7F6FF),
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () async {
                            try {
                              inbox_select = await mybottomsheet(
                                  context, const StatusPage());
                            } catch (e) {
                              print('$e');
                            }
                            setState(() {});
                            print('$inbox_select  test');
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 28,
                          ),
                          color: Color(0xffB2B2B2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: inbox_select[2] != 'Completed',
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: containerDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Decision',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                desicion = _DesisionController.text;
                                desicion.isEmpty
                                    ? validate_decision = true
                                    : validate_decision = false;
                              });
                            },
                            cursorColor: Colors.black,
                            controller: _DesisionController,
                            decoration: InputDecoration(
                              errorText: validate_decision
                                  ? 'You must fill Decision'
                                  : null,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 5,
                              ),
                              hintText: 'Add Decision',
                              hintStyle: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: inbox_select[2] == 'Completed',
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: containerDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Final Decision',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                finaldesicion = _FinalDesisionController.text;
                                finaldesicion.isEmpty
                                    ? validate_decision = true
                                    : validate_decision = false;
                              });
                            },
                            cursorColor: Colors.black,
                            controller: _FinalDesisionController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              errorText: validate_decision
                                  ? 'You must fill Final Decision'
                                  : null,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 5,
                              ),
                              hintText: 'Add Decision',
                              hintStyle: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          getImages();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: containerDecoration,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Add Image',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff6589FF),
                                ),
                              ),
                              SingleChildScrollView(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 4),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      for (int i = 0;
                                          i < selectedImages.length;
                                          i++) ...{
                                        Divider(),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.delete_outline_outlined,
                                                color: AppColors.redColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  selectedImages.removeAt(
                                                    i,
                                                  );
                                                });
                                              },
                                            ),
                                            kIsWeb
                                                ? Image.network(
                                                    selectedImages[i]!.path)
                                                : SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(16),
                                                      ),
                                                      child: Image.file(
                                                        File(
                                                          selectedImages[i]
                                                              .path,
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      },
                                      SizedBox(
                                        width: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  CategoryExpansionTileCata(
                    subject: 'Activities',
                    subTitle: Actitivties,
                    children: [
                      for (int i = mapActivities.length - 1; i >= 0; i--) ...{
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Color(0xff6589ff),
                                      backgroundImage: user?.image != null
                                          ? CachedNetworkImageProvider(
                                              'http://palmail.gazawar.wiki/${user!.image}')
                                          : const AssetImage(
                                                  'assets/images/user.jpg')
                                              as ImageProvider,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      user!.name!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      selectedDate,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: Row(
                                    children: [
                                      Text(
                                        mapActivities[i]['body'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: const Color(0xff272727),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        )
                      }
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: containerDecoration,
                    child: TextField(
                      onSubmitted: (value) {
                        setState(() {
                          Actitivties = _activityController.text;
                          setState(() {
                            if (Actitivties != '')
                              mapActivities.add(
                                  {'body': Actitivties, 'user_id': user?.id});
                            _activityController.clear();
                          });
                        });
                      },
                      controller: _activityController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.person_2_outlined,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.send_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              Actitivties = _activityController.text;
                              setState(() {
                                if (Actitivties != '')
                                  mapActivities
                                      .add({'body': Actitivties, 'user_id': 1});
                                _activityController.clear();
                              });
                            });
                          },
                        ),
                        hintText: 'Add new Activity …',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: AppColors.greyboldColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
