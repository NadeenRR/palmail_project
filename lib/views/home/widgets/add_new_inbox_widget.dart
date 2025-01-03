import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/app_string.dart';
import '../../../services/mange_language.dart';
import '../../../widgets/my_bottomSheet.dart';
import '../../new_mail/mail/new_mail.dart';

class AddNewInboxWidget extends StatefulWidget {
  const AddNewInboxWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<AddNewInboxWidget> createState() => _AddNewInboxWidgetState();
}

class _AddNewInboxWidgetState extends State<AddNewInboxWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isRtl(context) ? 0 : 8, right: isRtl(context) ? 8 : 0),
      width: double.infinity,
      height: widget.size.height / 13,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
          )),
      child: Row(children: [
        const Icon(
          CupertinoIcons.add_circled_solid,
          color: Color(0xff003AFC),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          AppString.newInbox.tr(),
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: const Color(0xff003AFC),
            fontWeight: FontWeight.w600,
          ),
        ),
      ]),
    );
  }
}
