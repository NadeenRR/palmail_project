import 'package:flutter/material.dart';

import '../constant/app_color.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
    required this.tabController,
    // required this.login,
    // required this.signup,
    required this.tabs,
  });
  final TabController tabController;

  // final String login;
  // final String signup;
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    return Container(
      //    width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: TabBar(
        dividerColor: Colors.transparent,
        controller: tabController,
        indicator: BoxDecoration(
          gradient: AppColors.colorGradient,
          borderRadius: BorderRadius.circular(25.0),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF4498EC),
        tabs: tabs,
      ),
    );
  }
}
