import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/mange_language.dart';

class SlidMenuTitle extends StatelessWidget {
  const SlidMenuTitle({
    super.key,
    required this.press,
    required this.title,
    required this.icon,
  });

  final VoidCallback press;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: press,
          leading: SizedBox(
            height: 34,
            width: 34,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: FaIcon(
                icon,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: isRtl(context)
              ? const EdgeInsets.only(right: 12)
              : const EdgeInsets.only(left: 12),
          child: const Divider(
            color: Colors.white24,
            height: 1,
          ),
        )
      ],
    );
  }
}
