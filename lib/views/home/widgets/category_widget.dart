import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.size,
    required this.backgroundColor,
    required this.number,
    required this.categoryName,
  });

  final Size size;
  final Color backgroundColor;
  final int number;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 6.7,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x4dcdccf1),
            offset: Offset(0, 5),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: backgroundColor,
                ),
                Text(
                  '$number',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: const Color(0xff272727),
                    letterSpacing: 0.025,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Text(
              categoryName,
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: const Color(0xffb2b2b2),
                letterSpacing: 0.0225,
                fontWeight: FontWeight.w600,
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
