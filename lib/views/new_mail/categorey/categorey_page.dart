import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constant/app_color.dart';
import '../../../constant/app_constant.dart';
import '../../../services/api_response.dart';
import '../../../views/details_feature/shmmier_loading.dart';
import '../../../widgets/container_bottomSheet.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constant/app_string.dart';
import '../../../provider/category_Provider.dart';
import '../mail/widgets/snack_bar.dart';

class catecoreyPage extends StatefulWidget {
  const catecoreyPage({Key? key}) : super(key: key);

  @override
  State<catecoreyPage> createState() => _catecoreyPageState();
}

class _catecoreyPageState extends State<catecoreyPage> {
  int? _selectedValueIndex;
  String select_cat = '';
  String select_Cateogrey() {
    switch (_selectedValueIndex) {
      case 0:
        select_cat = 'OTHER';
        break;
      case 1:
        select_cat = 'OFFICIAL_ORGANIZATION';
        break;

      case 2:
        select_cat = 'NG_OS';
        break;

      case 3:
        select_cat = 'FOREIGN';
        break;

      default:
        select_cat = '';
        break;
    }
    return select_cat;
  }

  Widget button({required int index, required inpoint}) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedValueIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            index != 0
                ? Divider(
                    color: Colors.grey.shade200,
                    indent: index == 3 ? 12 : 0,
                    thickness: index == 3 ? 2 : 0,
                  )
                : const SizedBox(),
            Consumer<CategoreyProvider>(builder: (_, CategoreyProvider, __) {
              if (CategoreyProvider.Categories.status == ApiStatus.LOADING) {
                return categoriesShimmer2();
              }
              if (CategoreyProvider.Categories.status == ApiStatus.COMPLETED) {
                return ListTile(
                  title: Text(
                    CategoreyProvider.Categories.data![index].name!.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: index == _selectedValueIndex
                      ? const Icon(
                          Icons.check_rounded,
                          size: 28,
                          color: Color(0xff6589FF),
                        )
                      : const SizedBox(),
                );
              }

              return Text('${CategoreyProvider.Categories.message}');
            }),
          ],
        ),
      ),
    );
  }

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
              style: const TextStyle(
                color: Color(0xff6589FF),
                fontSize: 20,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            AppString.category.tr(),
            style: const TextStyle(
              color: Color(0xff272727),
              fontSize: 24,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                AppString.done.tr(),
                style: const TextStyle(
                  color: Color(0xff6589FF),
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                select_Cateogrey();
                if (select_cat == '') {
                  // MotionToast.error(
                  //   title: Text("Error"),
                  //   description: Text("You Must Select Category!"),
                  // ).show(context);
                  Fluttertoast.showToast(
                    msg: AppString.mustSelectCat.tr(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                  );
                } else {
                  Navigator.pop(context, select_cat);
                }
              },
            ),
          ],
        ),
        body: Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(
                4,
                (index) => button(index: index, inpoint: 12),
              )
            ],
          ),
        ),
      ),
      clip: AppConstant.isSelected ? Clip.hardEdge : Clip.none,
      margin: EdgeInsets.zero,
      radius: AppConstant.isSelected
          ? BorderRadius.circular(25)
          : BorderRadius.zero,
    );
  }

  Shimmer categoriesShimmer2() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(16.0),
            ),
            width: double.infinity,
            height: 50,
            child: const SizedBox(width: double.infinity)));
  }
}
