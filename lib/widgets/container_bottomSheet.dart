import 'package:flutter/material.dart';

AnimatedContainer container_bottomSheet(BuildContext context,
    {required Widget child,
    required EdgeInsets margin,
    required Clip clip,
    required BorderRadiusGeometry radius}) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 10),
    clipBehavior: clip,
    margin: margin,
    decoration: BoxDecoration(borderRadius: radius),
    child: child,
  );
}
