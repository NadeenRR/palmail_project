import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constant/app_color.dart';

class CategoryExpansionTileCata extends StatelessWidget {
  const CategoryExpansionTileCata({
    super.key,
    required this.subject,
    required this.subTitle,
    required this.children,
  });

  final String subject;
  final String subTitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        shape: const Border(
          top: BorderSide(color: Colors.transparent),
          bottom: BorderSide(color: Colors.transparent),
        ),
        iconColor: AppColors.primaryColor,
        textColor: const Color(0xff272727),
        collapsedIconColor: const Color(0xffB2B2B2),
        tilePadding: EdgeInsets.zero,
        title: Text(
          subject,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: const Color(0xff272727),
          ),
        ),
        children: children);
  }
}
