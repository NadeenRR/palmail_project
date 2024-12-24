import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../views/home/widgets/add_new_tag.dart';
import '../views/home/widgets/category_widget.dart';

class ShimmerApp {
  static Shimmer statusesShimmer(Size size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 5 / 3,
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 12,
        ),
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return CategoryWidget(
            backgroundColor: Colors.white,
            categoryName: '',
            number: 4,
            size: size,
          );
        },
      ),
    );
  }

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
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(20.0),
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
}
