import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../views/home/widgets/pick_image.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';
import '../../constant/app_color.dart';
import '../../constant/app_constant.dart';
import '../../constant/app_string.dart';
import '../../controller/update_user_controller.dart';
import '../../provider/user_provider.dart';
import '../../services/api_response.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const id = 'profile-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? pickImage;
  bool isEdit = false;
  bool isUpdate = false;
  final FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getSingleUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            backgroundColor: AppColors.bcColor,
            title: Text(
              AppString.profilePage.tr(),
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          backgroundColor: AppColors.bcColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Consumer<UserProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    final user = value.getUser;

                    final backgroundImage = user?.image != null
                        ? CachedNetworkImageProvider(
                            'http://palmail.gazawar.wiki/${user!.image}')
                        : const AssetImage('assets/images/user.jpg');

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.width * 0.45,
                          width: size.width * 0.45,
                          child: PickImage(
                            isEdit: isEdit,
                            image: backgroundImage as ImageProvider,
                            function: localImagePicker,
                            pickImage: pickImage,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: TextFormField(
                            controller: TextEditingController(text: user!.name),
                            onChanged: (value) {
                              //   user.name = value;
                              setState(() {
                                user.name = value;
                                _textEditingController.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(offset: value.length),
                                );
                              });
                            },
                            onSaved: (value) {
                              setState(() {
                                user.name = value;
                              });
                            },
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            focusNode: _focusNode,
                            textInputAction: TextInputAction.done,
                            autofocus: isEdit,
                            enabled: isEdit,
                            cursorColor: Colors.lightBlue[800],
                            decoration: AppConstant().inputDecoration(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              onPressed: () {},
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  isEdit = true;
                                  FocusScope.of(context)
                                      .requestFocus(_focusNode);
                                });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              label: Text(
                                AppString.editProfile.tr(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[400],
                              ),
                              onPressed: isEdit
                                  ? () async {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        isEdit = false;
                                        isUpdate = true;
                                      });

                                      final name =
                                          TextEditingController(text: user.name)
                                              .text;
                                      final isNameChanged = name != user.name;
                                      final isImageChanged = pickImage != null;

                                      if (!isNameChanged || isImageChanged) {
                                        late ApiResponse apiResponse;
                                        final image = isImageChanged
                                            ? File(pickImage!.path)
                                            : null;

                                        if (image == null) {
                                          apiResponse =
                                              await UpdateUserController()
                                                  .updateNameController(
                                            newName: name,
                                          );
                                        } else {
                                          apiResponse =
                                              await UpdateUserController()
                                                  .updateUserController(
                                            name: name,
                                            image: image,
                                          );
                                        }

                                        try {
                                          if (apiResponse.status ==
                                              ApiStatus.COMPLETED) {
                                            Fluttertoast.showToast(
                                              msg: AppString.userUpdate.tr(),
                                              toastLength: Toast.LENGTH_SHORT,
                                              textColor: Colors.green,
                                              backgroundColor: Colors.white,
                                              fontSize: 14.0,
                                            );
                                          }

                                        } catch (e) {
                                          Fluttertoast.showToast(
                                            msg: e.toString(),
                                            toastLength: Toast.LENGTH_SHORT,
                                            textColor: Colors.white,
                                            backgroundColor: Colors.red,
                                            fontSize: 14.0,
                                          );
                                        }

                                        setState(() {
                                          isUpdate =
                                              false;
                                        });

                                        Future.delayed(
                                            const Duration(milliseconds: 250),
                                            () {
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            HomeScreen.id,
                                            (_) => false,
                                          );
                                        });
                                      }
                                    }
                                  : null,
                              icon: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              label: !isUpdate
                                  ? Text(
                                      AppString.done.tr(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const CupertinoActivityIndicator(
                                      color: Colors.white,
                                    ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> localImagePicker() async {
    final ImagePicker _picker = ImagePicker();

    await AppConstant.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        pickImage = await _picker.pickImage(source: ImageSource.camera);

        setState(() {});
      },
      galleryFCT: () async {
        pickImage = await _picker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFCT: () {
        setState(() {
          pickImage = null;
        });
      },
    );
  }
}
