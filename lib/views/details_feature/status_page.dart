import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../constant/app_color.dart';
import '../../constant/app_constant.dart';
import '../../views/details_feature/shmmier_loading.dart';

import '../../widgets/container_bottomSheet.dart';
import 'package:provider/provider.dart';

import '../../../controller/statues/statuse_repositry.dart';
import '../../../provider/statuses_provider.dart';
import '../../constant/app_string.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  void initState() {
    AllStatuesRep().fetchAllStatues();
    super.initState();
  }

  int? _selectedValueIndex;
  String? selectedName;
  bool? isChange = true;
  String? color;

  @override
  Widget build(BuildContext context) {
    return container_bottomSheet(
      context,
      child: Scaffold(
        backgroundColor: AppColors.bcColor,
        appBar: AppBar(
          backgroundColor: AppColors.bcColor,
          leadingWidth: 100,
          elevation: 0,
          centerTitle: true,
          leading: TextButton(
            child: Text(
              AppString.cancel.tr(),
              style: AppConstant().tagsStyle.copyWith(fontSize: 18),
            ),
            onPressed: () {
              Navigator.pop(
                  context, [false, _selectedValueIndex, color, selectedName]);
            },
          ),
          title: Text(
            AppString.status.tr(),
            style: AppConstant().titleNameStyle.copyWith(color: Colors.black),
          ),
          actions: [
            TextButton(
              child: Text(
                AppString.done.tr(),
                style: AppConstant()
                    .titleNameStyle
                    .copyWith(color: AppColors.blueColor),
              ),
              onPressed: () {
                Navigator.pop(context,
                    [isChange, _selectedValueIndex, color, selectedName]);
              },
            ),
          ],
        ),
        body: Consumer<StatusesProvider>(
          builder: (BuildContext context, value, Widget? child) {
            final allEmailStatuses = value.getStatuses;

            if (allEmailStatuses != null) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppString.addStatus.tr(),
                            style: AppConstant()
                                .titleNameStyle
                                .copyWith(color: AppColors.blueColor),
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.grey.shade400,
                            size: 28,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      for (int i = 0; i < allEmailStatuses.length; i++) ...{
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selectedValueIndex = i;
                              color = allEmailStatuses[i].color;
                              selectedName = allEmailStatuses[i].name;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              i != 0
                                  ? const Divider(
                                      color: Colors.grey,
                                    )
                                  : const SizedBox(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color(int.parse(
                                          allEmailStatuses[i].color!)),
                                    ),
                                    height: 36,
                                  ),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  SizedBox(
                                    width: 110,
                                    // width: 80,
                                    child: Text(
                                      '${allEmailStatuses[i].name}',
                                      style: AppConstant().subtextStyle,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 130,
                                  ),
                                  i == _selectedValueIndex
                                      ? const Icon(
                                          Icons.check_rounded,
                                          size: 32,
                                          color: Color(0xff6589FF),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ],
                          ),
                        )
                      },
                    ],
                  ),
                ),
              );
            } else {
              return ShimmerLoading.statusShimmer();
            }
          },
        ),
      ),
      clip: AppConstant.isSelected ? Clip.hardEdge : Clip.none,
      margin: EdgeInsets.zero,
      radius: AppConstant.isSelected
          ? BorderRadius.circular(25)
          : BorderRadius.zero,
    );
  }
}
