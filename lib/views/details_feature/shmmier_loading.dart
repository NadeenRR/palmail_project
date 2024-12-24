import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../views/home/widgets/add_new_tag.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/app_color.dart';
import '../../constant/app_constant.dart';
import '../../widgets/details_widget/custom_expansion_tile.dart';
import '../../widgets/details_widget/my_status_widget.dart';
import '../home/widgets/category_expansion_tile.dart';

class ShimmerLoading {
  static Shimmer categoriesShimmer() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                width: double.infinity,
                height: 50,
                child: const SizedBox(width: double.infinity));
          },
        ));
  }

  static Shimmer tagsShimmer() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
          ),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              const AddNewTag(
                tag: 'All Tags',
              ),
              for (var i = 0; i < 20; i++) ...[
                const AddNewTag(
                  tag: '',
                )
              ]
            ],
          ),
        ));
  }

  static Shimmer statusShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          height: 280,
          decoration: AppConstant().boxdecoration,
          child: Column(
            children: [
              my_status(
                trail: null,
                stauts: 'In box',
                color: AppColors.redColor,
                onTap: () {},
              ),
              const Divider(),
              my_status(
                trail: null,
                stauts: 'Pending',
                color: AppColors.yellowColor,
                onTap: () {},
              ),
              const Divider(),
              my_status(
                trail: null,
                stauts: 'In Progress',
                color: AppColors.blueColor,
                onTap: () {},
              ),
              const Divider(),
              my_status(
                trail: null,
                stauts: 'Completed',
                color: Colors.green,
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  static Shimmer detailsPageShimmer() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade100,
        child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: AppConstant().boxdecoration,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 12, left: 8),
                          child: Row(
                            children: [
                              Icon(Icons.perm_identity_sharp),
                              SizedBox(
                                width: 4,
                              ),
                              Text(''),
                              SizedBox(),
                              Text(''),
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Text(''),
                            SizedBox(width: 120),
                            Text(''),
                          ],
                        ),
                        const Divider(),
                        CustomExpandedTile(
                          title: const Text(''),
                          content: const Text(''),
                          controller: AppConstant().controller,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () async {},
                    child: Container(
                      decoration: AppConstant().boxdecoration,
                      width: double.infinity,
                      height: 65,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    '',
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      '',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () async {},
                    child: Container(
                      decoration: AppConstant().boxdecoration,
                      width: double.infinity,
                      height: 65,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Row(
                            children: [
                              Container(
                                width: (12 * 12.0) + 20,
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(
                                  child: Text(
                                    '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 150,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () async {},
                    child: Container(
                      decoration: AppConstant().boxdecoration,
                      width: double.infinity,
                      height: 65,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    '',
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      '',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: AppConstant().boxdecoration,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 12, left: 8),
                          child: Row(
                            children: [
                              Icon(Icons.perm_identity_sharp),
                              SizedBox(
                                width: 4,
                              ),
                              Text(''),
                              SizedBox(),
                              Text(''),
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Text(''),
                            SizedBox(width: 120),
                            Text(''),
                          ],
                        ),
                        const Divider(),
                        CustomExpandedTile(
                          title: const Text(''),
                          content: const Text(''),
                          controller: AppConstant().controller,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomExpandedTile(
                    title: Text(
                      'Activity',
                      style: AppConstant().titleStyle,
                    ),
                    content: const Text(
                      '',
                    ),
                    onTap: () {},
                    onLongTap: () {},
                    controller: AppConstant().activityController,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: AppConstant().boxdecoration,
                    child: TextField(
                      onSubmitted: (value) {},
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_2_outlined),
                        suffix: IconButton(
                          icon: const Icon(Icons.send_outlined),
                          onPressed: () {},
                        ),
                        hintText: 'Add new Activity …',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff898989),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      onPressed: () {},
                      child:
                          Text('Delete Mail', style: AppConstant().deleteStyle))
                ],
              ),
            )));
  }

  static shimmerLoadingList(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ExpansionTileCustome(
                size: MediaQuery.of(context).size,
                color: int.parse('0'),
                date: 'Loading',
                organizationName: 'Loading',
                subTitle: 'Loading',
                subject: 'Loading',
                tag: 'Loading',
                imageList: Container(
                  height: 30,
                  width: 150,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          );
        },
      ),
    );
  }
}
