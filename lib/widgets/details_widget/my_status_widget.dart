import 'package:flutter/material.dart';
import '../../constant/app_constant.dart';

class my_status extends StatelessWidget {
  final String stauts;
  final Color color;
  final void Function()? onTap;
  final Widget? trail;
  const my_status({
    super.key,
    required this.stauts,
    required this.color,
    required this.onTap,
    this.trail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 8),
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            trailing: trail,
            title: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: color,
                  ),
                  width: 40,
                  height: 40,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  stauts,
                  style: AppConstant().subtextStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
