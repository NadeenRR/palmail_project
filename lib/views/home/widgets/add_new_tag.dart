import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewTag extends StatelessWidget {
  const AddNewTag({
    super.key,
    required this.tag,
  });
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xffe6e6e6),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text(
        tag,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: const Color(0xff7c7c7c),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
