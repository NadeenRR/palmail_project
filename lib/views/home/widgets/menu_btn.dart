import 'package:flutter/material.dart';
import '../../../constant/app_assets.dart';
import 'package:rive/rive.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({
    super.key,
    required this.onTap,
    required this.riveInit,
  });

  final VoidCallback onTap;
  final ValueChanged<Artboard> riveInit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          margin: const EdgeInsets.all(12),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x4dcdccf1),
                offset: Offset(0, 5),
                blurRadius: 8,
              ),
            ],
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: RiveAnimation.asset(
            AppAssets.menuAnimated,
            onInit: riveInit,
          ),
        ),
      ),
    );
  }
}
