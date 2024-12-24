// import 'package:flutter/material.dart';
// import 'package:gsg_final_project/constant/app_color.dart';
// import 'package:gsg_final_project/constant/app_constant.dart';
//
// import 'package:gsg_final_project/widgets/container_bottomSheet.dart';
// import 'package:provider/provider.dart';
//
// import '../../../provider/statuses_provider.dart';
// import '../../../services/api_response.dart';
//
// class StatusPage extends StatefulWidget {
//   const StatusPage({Key? key}) : super(key: key);
//
//   @override
//   State<StatusPage> createState() => _StatusPageState();
// }
//
// class _StatusPageState extends State<StatusPage> {
//   int? _selectedValueIndex;
//   String? selectedName;
//   bool? isChange;
//   Color? color;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return container_bottomSheet(
//       context,
//       child: Scaffold(
//           backgroundColor: AppColors.bcColor,
//           appBar: AppBar(
//             backgroundColor: AppColors.bcColor,
//             leadingWidth: 100,
//             elevation: 0,
//             centerTitle: true,
//             leading: TextButton(
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(
//                   color: Color(0xff6589FF),
//                   fontSize: 20,
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             title: const Text(
//               'Status',
//               style: TextStyle(
//                 color: Color(0xff272727),
//                 fontSize: 24,
//               ),
//             ),
//             actions: [
//               TextButton(
//                 child: const Text(
//                   'Done',
//                   style: TextStyle(
//                     color: Color(0xff6589FF),
//                     fontSize: 20,
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.pop(
//                       context, [_selectedValueIndex, color, selectedName]);
//                 },
//               ),
//             ],
//           ),
//           body: Consumer<StatusesProvider>(
//             builder: (_, statuesprovider, __) {
//               if (statuesprovider.getStatuses == ApiStatus.LOADING) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               if (statuesprovider.getStatuses == ApiStatus.COMPLETED) {
//                 return Container(
//                   padding: const EdgeInsets.all(24),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(28),
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         children: [
//                           const Text(
//                             'Add Status',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xff6589FF),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 200,
//                           ),
//                           Icon(
//                             Icons.edit,
//                             color: Colors.grey.shade400,
//                             size: 28,
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 12,
//                       ),
//                       for (int i = 0;
//                           i < statuesprovider.statusesList!.length;
//                           i++) ...{
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               _selectedValueIndex = i;
//                               color = Color(int.parse(
//                                   statuesprovider.getStatuses![i].color!));
//                             });
//                           },
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               i != 0
//                                   ? const Divider(
//                                       indent: 54,
//                                       color: Colors.grey,
//                                     )
//                                   : const SizedBox(),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     width: 36,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12),
//                                       color: Color(int.parse(statuesprovider
//                                           .getStatuses![i].color!)),
//                                     ),
//                                     height: 36,
//                                   ),
//                                   const SizedBox(
//                                     width: 18,
//                                   ),
//                                   SizedBox(
//                                     width: 100,
//                                     // width: 80,
//                                     child: Text(
//                                       '${statuesprovider.getStatuses![i]!}',
//                                       style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 130,
//                                   ),
//                                   i == _selectedValueIndex
//                                       ? const Icon(
//                                           Icons.check_rounded,
//                                           size: 32,
//                                           color: Color(0xff6589FF),
//                                         )
//                                       : const SizedBox(),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         )
//                         // Text('${statuesProvider.getStatues.data?[i].name} dats')
//                       },
//                     ],
//                   ),
//                 );
//               }
//               return Text('${statuesprovider.getStatuses}');
//             },
//           )),
//       clip: AppConstant.isSelected ? Clip.hardEdge : Clip.none,
//       margin: EdgeInsets.zero,
//       radius: AppConstant.isSelected
//           ? BorderRadius.circular(25)
//           : BorderRadius.zero,
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constant/app_color.dart';
import '../../../constant/app_constant.dart';
import '../../../constant/app_string.dart';
import '../../../views/details_feature/shmmier_loading.dart';
import '../../../widgets/container_bottomSheet.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import '../../../controller/statues/statuse_repositry.dart';
import '../../../provider/statuses_provider.dart';

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
                context,
              );
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
                if (_selectedValueIndex != null) {
                  Navigator.pop(context,
                      [(_selectedValueIndex! + 1), color, selectedName]);
                } else {
                  // MotionToast.error(
                  //   title: const Text("Error"),
                  //   description: const Text("You Must Select Status!"),
                  // ).show(context);
                  Fluttertoast.showToast(
                    msg: "You Must Select Status!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                  );
                }
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
                              print(color);
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
                                  Spacer(),
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
