import 'package:flutter/services.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:provider/provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../provider/search_provider.dart';
import 'app_color.dart';

class AppConstant {
  // http://palmail.gazawar.wiki/api
  static const String baseUrl = 'http://palmail.gazawar.wiki/api';
  static const String registerUrl = '$baseUrl/register';
  static const String loginUrl = '$baseUrl/login';
  static bool isSelected = false;
  static bool isOpenHomecreen = false;

  static scaffoldMessenger({
    required BuildContext context,
    required String text,
    required Color color,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: color,
    ));
  }

  InputDecoration inputDecoration({
    String? hintText,
    IconData? icon,
    Function()? onPressed,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color color = Colors.grey,
  }) {
    return InputDecoration(
      hintStyle: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      hintText: hintText,
      suffixIcon: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.grey.shade300,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlue[800]!),
      ),
    );
  }

  static dialogBuilder(BuildContext context, Function()? onPressed) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onPressed,
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function cameraFCT,
    required Function galleryFCT,
    required Function removeFCT,
  }) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Center(
              child: Text(
                "Choose option",
              ),
            ),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                TextButton.icon(
                  onPressed: () {
                    cameraFCT();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.add_a_photo),
                  label: const Text(
                    "Camera",
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    galleryFCT();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.image),
                  label: const Text(
                    "Gallery",
                  ),
                ),
              ],
            )),
          );
        });
  }

  //================= details style ===============
  BoxDecoration boxdecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
  );
  BoxDecoration boxdecorationOpacity = BoxDecoration(
    color: Colors.white.withOpacity(0.5),
    borderRadius: BorderRadius.circular(30),
  );
  TextStyle txtStyle = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    // color: AppColors.hintColor,
  );

  //=============details screen =========================
  TextStyle senderNameStyle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  TextStyle dateStyle = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.hintColor,
  );
  TextStyle organiztionStyle = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: AppColors.hintColor,
  );
  TextStyle titleStyle = GoogleFonts.poppins(
      fontWeight: FontWeight.w700, color: Colors.black, fontSize: 20);
  TextStyle subtextStyle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  TextStyle decisionStyle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  final ExpandedTileController controller =
      ExpandedTileController(isExpanded: false);
  final ExpandedTileController activityController =
      ExpandedTileController(isExpanded: false);

  //================== search screen =========================
  TextStyle resultStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    // color: AppColors./,
  );
  TextStyle titleNameStyle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    // color: AppColors.greyboldColor,
  );
  TextStyle tagsStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.blueColor,
  );
  TextStyle deleteStyle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.redColor,
  );

//********** icons *********************
  Icon filterIcon = const Icon(
    Icons.filter_alt_outlined,
    color: AppColors.blueColor,
    size: 42,
  );

  //***** Search Screen******
  Widget buildLoading() {
    return const SizedBox(
      height: 500,
      child: Center(
        // child: Lottie.asset('assets/animation/searching.json'),
        child: SpinKitWanderingCubes(
          color: AppColors.primaryColor,
          size: 120.0,
        ),
      ),
    );
  }

  void dismissKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  String formatDate(String? dateString) {
    if (dateString != null && dateString.isNotEmpty) {
      return DateFormat('dd-MM-yyyy').format(DateTime.parse(dateString));
    } else {
      return '';
    }
  }

  Color getCircleAvatarBackgroundColor(String? statusColor) {
    Color defaultColor = Colors.red;

    if (statusColor != null) {
      try {
        int colorValue = int.parse(statusColor);
        return Color(colorValue);
      } catch (e) {
        return defaultColor;
      }
    }

    return defaultColor;
  }

  InputDecoration textDeco = const InputDecoration(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.bcColor),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.bcColor),
    ),
  );
}

void showDeleteAnimation(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Lottie.asset('assets/json/delte_mail.json'),
      );
    },
  );

  Future.delayed(const Duration(seconds: 2), () {
    Navigator.pop(context);
    Navigator.pop(context);
    Provider.of<SearchProvider>(context, listen: false).toggleRefresh();
  });
}
