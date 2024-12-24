import 'package:flutter/material.dart';

import '../../constant/app_color.dart';

Container containerBottomSheet(Widget child, size) {
  return Container(
      height: size,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        // color: AppColors.bcColor,
        border: Border.all(width: 5, color: AppColors.bcColor),
        borderRadius: BorderRadius.circular(25),
      ),
      child: child);
}
