import 'package:flutter/material.dart';
import '../../../constant/app_constant.dart';

class IconTextContainer extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final color;

  const IconTextContainer({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: GestureDetector(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    color: color,
                    size: 40,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    text,
                    style: AppConstant().subtextStyle.copyWith(color: color),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
