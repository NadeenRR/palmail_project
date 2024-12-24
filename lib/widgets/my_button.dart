import 'package:flutter/material.dart';
import '../../../constant/app_color.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, this.text, this.onTap, required this.child});
  final String? text;
  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: AppColors.colorGradient,
        ),
        child: Center(child: child),
      ),
    );
  }
}
