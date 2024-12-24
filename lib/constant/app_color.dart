import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF4498EC);
  static const Color bcColor = Color(0xFFF7F6FF);
  static const Color blueColor = Color(0xFF6589FF);
  static const Color hintColor = Color(0xFFB2B2B2);
  static const Color greyboldColor = Color(0xFF707070);
  static const Color grey2Color = Color(0xFF959595);
  static const Color grey3Color = Color(0xFFC6C6C6);
  static const Color grey4Color = Color(0xFFEAEAF5);
  static const Color yellowColor = Color(0xFFFFE120);
  static const Color redColor = Color(0xFFE62929);
  static const LinearGradient colorGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xff003AFC),
      Color(0xFF6589FF),
    ],
  );
}
