import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/app_color.dart';
import '../../constant/app_constant.dart';
import '../../constant/app_string.dart';
import '../../provider/search_provider.dart';
import '../../widgets/details_widget/custom_expansion_tile.dart';
import '../../widgets/details_widget/my_status_widget.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<SearchProvider>(context);
    var height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * .92,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      filterProvider.toggleBottomSheet();
                      Navigator.pop(context);
                      await filterProvider.searchRefresh();
                      filterProvider.isFilterPressed = false;
                    },
                    child: Text(
                      AppString.cancel.tr(),
                      style: AppConstant().tagsStyle.copyWith(fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppString.filters.tr(),
                      style: AppConstant()
                          .titleNameStyle
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      filterProvider.toggleBottomSheet();
                      filterProvider.filterSearchList();
                      filterProvider.isFilterApplied = true;
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppString.done.tr(),
                      style: AppConstant()
                          .titleNameStyle
                          .copyWith(color: AppColors.blueColor),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      filterProvider.resetFilter();
                    },
                    child: Text(
                      AppString.cancelFilter.tr(),
                      style: AppConstant()
                          .tagsStyle
                          .copyWith(color: AppColors.redColor),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: AppConstant().boxdecoration,
                    child: Column(
                      children: [
                        my_status(
                          trail: filterProvider.selectedStatusIndex == 0
                              ? const Icon(
                                  CupertinoIcons.checkmark,
                                  color: AppColors.blueColor,
                                )
                              : null,
                          stauts: AppString.inBox.tr(),
                          color: AppColors.redColor,
                          onTap: () {
                            filterProvider.setStatusIndex(0);
                          },
                        ),
                        const Divider(),
                        my_status(
                          trail: filterProvider.selectedStatusIndex == 1
                              ? const Icon(
                                  CupertinoIcons.checkmark,
                                  color: AppColors.blueColor,
                                )
                              : null,
                          stauts: AppString.pending.tr(),
                          color: AppColors.yellowColor,
                          onTap: () {
                            filterProvider.setStatusIndex(1);
                          },
                        ),
                        const Divider(),
                        my_status(
                          trail: filterProvider.selectedStatusIndex == 2
                              ? const Icon(
                                  CupertinoIcons.checkmark,
                                  color: AppColors.blueColor,
                                )
                              : null,
                          stauts: AppString.inProgress.tr(),
                          color: AppColors.blueColor,
                          onTap: () {
                            filterProvider.setStatusIndex(2);
                          },
                        ),
                        const Divider(),
                        my_status(
                          trail: filterProvider.selectedStatusIndex == 3
                              ? const Icon(
                                  CupertinoIcons.checkmark,
                                  color: AppColors.blueColor,
                                )
                              : null,
                          stauts: AppString.completed.tr(),
                          color: Colors.green,
                          onTap: () {
                            filterProvider.setStatusIndex(3);
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomExpandedTile(
                    title: Row(
                      children: [
                        const Icon(
                          Icons.date_range_rounded,
                          color: AppColors.redColor,
                          size: 38,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          children: [
                            Text(
                              AppString.fromDate.tr(),
                              style: AppConstant()
                                  .titleNameStyle
                                  .copyWith(color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              DateFormat('dd MMM, yyyy')
                                  .format(filterProvider.fromDate),
                              style: AppConstant().tagsStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    content: CalendarDatePicker(
                      firstDate: DateTime(2023, 9),
                      lastDate: DateTime(2025, 12, 12),
                      initialDate: DateTime(2023, 9),
                      onDateChanged: (date) {
                        filterProvider.setFromDate(date);
                      },
                    ),
                    onTap: () {},
                    onLongTap: () {},
                    controller: filterProvider.fromDateController,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomExpandedTile(
                    title: Row(
                      children: [
                        const Icon(
                          Icons.date_range_rounded,
                          color: AppColors.redColor,
                          size: 38,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          children: [
                            Text(
                              AppString.toDate.tr(),
                              style: AppConstant()
                                  .titleNameStyle
                                  .copyWith(color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              DateFormat('dd MMM, yyyy')
                                  .format(filterProvider.toDate),
                              style: AppConstant().tagsStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    content: CalendarDatePicker(
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2025, 12, 12),
                      initialDate: DateTime.now(),
                      onDateChanged: (date) {
                        filterProvider.setToDate(date);
                      },
                    ),
                    onTap: () {},
                    onLongTap: () {},
                    controller: filterProvider.toDateController,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
