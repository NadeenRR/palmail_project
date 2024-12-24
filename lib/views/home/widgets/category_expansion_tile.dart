import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/app_color.dart';
import '../../../services/mange_language.dart';
import 'dart:math' as math;

class CategoryExpansionTile extends StatefulWidget {
  const CategoryExpansionTile({
    super.key,
    required this.organization,
    required this.child,
    this.borderRadius,
    this.count,
  });
  final Widget child;
  final String organization;
  final BorderRadiusGeometry? borderRadius;
  final int? count;

  @override
  State<CategoryExpansionTile> createState() => _CategoryExpansionTileState();
}

class _CategoryExpansionTileState extends State<CategoryExpansionTile> {
  bool isOpen = false;

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
        widget.organization,
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: const Color(0xff272727),
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${widget.count ?? ''}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey.shade400),
          ),
          Icon(
            isOpen ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
            color: isOpen ? AppColors.primaryColor : Colors.grey.shade400,
          ),
        ],
      ),
      children: [widget.child],
      onExpansionChanged: (bool expanded) {
        setState(() => isOpen = expanded);
      },
    );
  }
}

class ExpansionTileCustome extends StatelessWidget {
  const ExpansionTileCustome({
    super.key,
    required this.size,
    required this.organizationName,
    required this.date,
    required this.subject,
    required this.subTitle,
    required this.tag,
    required this.color,
    //   required this.image,
    required this.imageList,
  });

  final Size size;

  final String organizationName;
  final String date;
  final String subject;
  final String subTitle;
  final String tag;
  final int color;
//  final ImageProvider image;
  final Widget imageList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 7,
                  backgroundColor: Color(color),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  organizationName,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xff272727),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  date,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xffb2b2b2),
                  ),
                ),
                Transform(
                  transform: Matrix4.rotationX(isRtl(context) ? math.pi : 0),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0xffb2b2b2),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xff272727),
                    ),
                  ),
                  Text(
                    subTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xff6589ff),
                    ),
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: [
                      //  for (int i = 0; i < 10; i++) ...[
                      Text(
                        '#$tag ',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xff6589ff),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // ]
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: [
                      imageList
                      // Container(
                      //   height: size.height / 20,
                      //   width: size.width / 10,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(10),
                      //   image: DecorationImage(
                      //     image: AssetImage(AppAssets.profile),
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      // ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
