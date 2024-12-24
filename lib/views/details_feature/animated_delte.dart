import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/app_color.dart';
import '../../constant/app_constant.dart';
import '../../constant/app_string.dart';
import '../../provider/mail_provider.dart';
import '../../provider/search_provider.dart';
import '../../provider/statuses_provider.dart';

Future<void> showCustomConfirmationDialog(
    BuildContext context, int mailId) async {
  bool isConfirmed = false;
  final deleteMailProvider =
      Provider.of<SearchProvider>(context, listen: false);
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Confirmation",
          style: AppConstant().titleStyle,
        ),
        content: Text(
          "Are you sure you want to delete this mail?",
          style: AppConstant().subtextStyle,
        ),
        actions: [
          TextButton(
            child: Text("Cancel",
                style: AppConstant()
                    .deleteStyle
                    .copyWith(color: AppColors.primaryColor)),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text(
              AppString.deleteMail.tr(),
              style: AppConstant().deleteStyle,
            ),
            onPressed: () {
              isConfirmed = true;
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  ).then((value) {
    if (value != null && value == true) {
      deleteMailProvider.deleteMail(mailId);

      Provider.of<StatusesProvider>(context, listen: false).getAllStatuses();
      Provider.of<MailsProvider>(context, listen: false).getAllMails();

      showDeleteAnimation(context);
    }
  });
}
