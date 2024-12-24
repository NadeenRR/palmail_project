import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constant/app_color.dart';

class MyTextField extends StatelessWidget {
  final String? hint;
  final Icon? preIcon;
  final Widget? suffIcon;
  final Widget? prefix;
  final TextEditingController? textEditingController;
  const MyTextField({
    super.key,
    this.hint,
    this.preIcon,
    this.suffIcon,
    this.textEditingController,
    this.prefix,
    required Function(dynamic text) onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.blueColor,
      onChanged: (txt) {},
      decoration: InputDecoration(
          fillColor: AppColors.grey4Color,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.grey4Color),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.grey4Color),
          ),
          prefixIcon: preIcon,
          suffixIcon: suffIcon,
          prefix: prefix,
          hintText: hint),
    );
  }
}
