import 'package:flutter/material.dart';

import '../../constant/app_constant.dart';

class CustomListViewWidget extends StatelessWidget {
  final int itemCount;
  final String leadingText;

  const CustomListViewWidget(
      {super.key, required this.itemCount, required this.leadingText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            decoration: AppConstant().boxdecoration,
            child: ListView.separated(
              itemCount: itemCount,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Text(
                        leadingText,
                        style: AppConstant().subtextStyle,
                      ),
                      onTap: () {},
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
