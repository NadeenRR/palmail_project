import 'package:flutter/material.dart';

import '../constant/app_constant.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.focusNode,
      this.textInputType,
      this.onPressed,
      this.icon,
      this.obscureText,
      this.validator});
  final TextEditingController controller;
  final String hintText;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final Function()? onPressed;
  final IconData? icon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      keyboardType: TextInputType.visiblePassword,
      cursorColor: Colors.lightBlue[800],
      controller: controller,
      decoration: AppConstant().inputDecoration(
        hintText: hintText,
        onPressed: onPressed,
        icon: icon,
      ),
      obscureText: obscureText!,
      validator: validator,
    );
  }
}
