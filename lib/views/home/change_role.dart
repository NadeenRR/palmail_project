import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../constant/app_color.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../constant/app_string.dart';
import '../../controller/role/change_role.dart';
import '../../provider/all_role.dart';
import '../../services/api_response.dart';
import '../new_mail/mail/widgets/snack_bar.dart';

// class ChangeRole extends StatefulWidget {
//   static const id = 'ChangeRole-screen';
//   final int? id_user;
//   final String? name;
//   final int? id_role;

//   const ChangeRole(
//       {Key? key,
//       required this.id_user,
//       required this.name,
//       required this.id_role})
//       : super(key: key);

//   @override
//   State<ChangeRole> createState() => _ChangeRoleState();
// }

// class _ChangeRoleState extends State<ChangeRole> {
//   int? select_role_id;
//   int? _selectedValueIndex;
//   bool isClick = false;

//   Widget button({required int index, required inpoint}) {
//     // String selectedCateogrey = '';
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _selectedValueIndex = index;
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         color: Colors.white,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             index != 0
//                 ? Divider(
//                     color: Colors.grey.shade200,
//                     indent: index == 3 ? 12 : 0,
//                     thickness: index == 3 ? 2 : 0,
//                   )
//                 : const SizedBox(),
//             Consumer<RoleProvider>(builder: (_, RoleChange, __) {
//               if (RoleChange.getRoles.status == ApiStatus.LOADING) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Shimmer.fromColors(
//                     baseColor: Colors.grey.shade300,
//                     highlightColor: Colors.grey.shade700,
//                     child: Container(
//                       width: 400,
//                       height: 600,
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: 4, // Replace with your actual item count
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             title: Shimmer.fromColors(
//                               baseColor: Colors.grey.shade300,
//                               highlightColor: Colors.grey.shade700,
//                               child: Text(
//                                 AppString.loading.tr(),
//                                 style: const TextStyle(
//                                   color: Colors.cyan,
//                                 ),
//                               ),
//                             ),
//                             trailing: index == _selectedValueIndex
//                                 ? const Icon(
//                                     Icons.check_rounded,
//                                     size: 28,
//                                     color: Color(0xff6589FF),
//                                   )
//                                 : const SizedBox(),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 );
//               }
//               if (RoleChange.getRoles.status == ApiStatus.COMPLETED) {
//                 return ListTile(
//                   title: Text(
//                     '${RoleChange.getRoles.data![index].name![0].toUpperCase()}${RoleChange.getRoles.data![index].name!.substring(1)}',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   trailing: index == _selectedValueIndex
//                       ? const Icon(
//                           Icons.check_rounded,
//                           size: 28,
//                           color: Color(0xff6589FF),
//                         )
//                       : const SizedBox(),
//                 );
//               }
//               return Text('${RoleChange.getRoles.message}Error');
//             })
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> DoneClicked() async {
//     int id_role_selected = select_role();

//     print(id_role_selected);
//     if (id_role_selected == 1 ||
//         id_role_selected == 2 ||
//         id_role_selected == 3 ||
//         id_role_selected == 4) {
//       if (id_role_selected == widget.id_role) {
//         print('warningggg');

//         Navigator.pop(context);
//         MotionToast.warning(
//           title: const Text("Warning"),
//           description: const Text("You select the same role"),
//         ).show(context);
//         FocusScope.of(context).unfocus();
//         Provider.of<RoleProvider>(context, listen: false).fetchRole();
//       } else {
//         await ChangeRoleRep().ChangeRoleReps(widget.id_user.toString(), {
//           'role_id': id_role_selected.toString(),
//         }).then((value) {
//           print('success');

//           Navigator.pop(context);
//           MotionToast.success(
//             title: const Text("Success"),
//             width: MediaQuery.of(context).size.width * 0.85,
//             height: MediaQuery.of(context).size.height * 0.10,
//             description: const Text("User Role Update "),
//           ).show(context);
//           FocusScope.of(context).unfocus();
//           Provider.of<RoleProvider>(context, listen: false).fetchRole();
//         });
//       }
//     } else {
//       MotionToast.error(
//         title: const Text("Error"),
//         description: const Text("You Must Choose Role"),
//       ).show(context);
//     }
//   }

//   int select_role() {
//     switch (_selectedValueIndex) {
//       case 0:
//         select_role_id = 1;
//         break;
//       case 1:
//         select_role_id = 2;
//         break;

//       case 2:
//         select_role_id = 3;
//         break;

//       case 3:
//         select_role_id = 4;
//         break;

//       default:
//         select_role_id = 5;
//         break;
//     }
//     return select_role_id!;
//   }

//   String getRule(int? id) {
//     switch (id) {
//       case 1:
//         return 'Guest';
//       case 2:
//         return 'User';
//       case 3:
//         return 'Editor';
//       case 4:
//         return 'Admin';
//       default:
//         return "";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           AppString.changeRole.tr(),
//         ),
//         centerTitle: true,
//         actions: [
//           TextButton(
//             child: Text(
//               AppString.done.tr(),
//               style: const TextStyle(
//                 color: Color(0xff6589FF),
//                 fontSize: 20,
//               ),
//             ),
//             onPressed: () async {
//               await DoneClicked();
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 12.0,
//                 horizontal: 18,
//               ),
//               child: Row(
//                 children: [
//                   Text(
//                     AppString.userName.tr(),
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.blueColor,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 12,
//                   ),
//                   Text(
//                     '${widget.name![0].toUpperCase()}${widget.name!.substring(1)}',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   const Spacer(),
//                   Text(
//                     getRule(widget.id_role),
//                     style: const TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Column(
//               children: [
//                 ...List.generate(
//                   4,
//                   (index) => button(index: index, inpoint: 12),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class ChangeRole extends StatefulWidget {
  static const id = 'ChangeRole-screen';
  final int? id_user;
  final String? name;
  final int? id_role;

  const ChangeRole(
      {Key? key,
      required this.id_user,
      required this.name,
      required this.id_role})
      : super(key: key);

  @override
  State<ChangeRole> createState() => _ChangeRoleState();
}

class _ChangeRoleState extends State<ChangeRole> {
  int? select_role_id;
  int? _selectedValueIndex;
  bool isClick = false;

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
            Consumer<RoleProvider>(builder: (_, RoleChange, __) {
              if (RoleChange.getRoles.status == ApiStatus.LOADING) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade700,
                    child: Container(
                      width: 400,
                      height: 600,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4, // Replace with your actual item count
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade700,
                              child: Text(
                                AppString.loading.tr(),
                                style: const TextStyle(
                                  color: Colors.cyan,
                                ),
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
                        },
                      ),
                    ),
                  ),
                );
              }
              if (RoleChange.getRoles.status == ApiStatus.COMPLETED) {
                // تخطي العنصر الثاني (الدور رقم 2)
                if (RoleChange.getRoles.data![index].id == 2) {
                  return SizedBox.shrink(); // إخفاء العنصر
                }
                return ListTile(
                  title: Text(
                    '${RoleChange.getRoles.data![index].name![0].toUpperCase()}${RoleChange.getRoles.data![index].name!.substring(1)}',
                    style: const TextStyle(
                      fontSize: 20,
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
              return Text('${RoleChange.getRoles.message}Error');
            })
          ],
        ),
      ),
    );
  }

  Future<void> DoneClicked() async {
    int id_role_selected = select_role();

    print(id_role_selected);
    if (id_role_selected == 1 ||
        id_role_selected == 2 ||
        id_role_selected == 3 ||
        id_role_selected == 4) {
      if (id_role_selected == widget.id_role) {
        print('warningggg');

        Navigator.pop(context);
        MotionToast.warning(
          title: const Text("Warning"),
          description: const Text("You select the same role"),
        ).show(context);
        FocusScope.of(context).unfocus();
        Provider.of<RoleProvider>(context, listen: false).fetchRole();
      } else {
        await ChangeRoleRep().ChangeRoleReps(widget.id_user.toString(), {
          'role_id': id_role_selected.toString(),
        }).then((value) {
          print('success');

          Navigator.pop(context);
          MotionToast.success(
            title: const Text("Success"),
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.10,
            description: const Text("User Role Update "),
          ).show(context);
          FocusScope.of(context).unfocus();
          Provider.of<RoleProvider>(context, listen: false).fetchRole();
        });
      }
    } else {
      MotionToast.error(
        title: const Text("Error"),
        description: const Text("You Must Choose Role"),
      ).show(context);
    }
  }

  int select_role() {
    switch (_selectedValueIndex) {
      case 0:
        select_role_id = 1;
        break;
      case 1:
        select_role_id = 2;
        break;

      case 2:
        select_role_id = 3;
        break;

      case 3:
        select_role_id = 4;
        break;

      default:
        select_role_id = 5;
        break;
    }
    return select_role_id!;
  }

  String getRule(int? id) {
    switch (id) {
      case 1:
        return 'Guest';
      case 2:
        return 'User';
      case 3:
        return 'Editor';
      case 4:
        return 'Admin';
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.changeRole.tr(),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text(
              AppString.done.tr(),
              style: const TextStyle(
                color: Color(0xff6589FF),
                fontSize: 20,
              ),
            ),
            onPressed: () async {
              await DoneClicked();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 18,
              ),
              child: Row(
                children: [
                  Text(
                    AppString.userName.tr(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blueColor,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    '${widget.name![0].toUpperCase()}${widget.name!.substring(1)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    getRule(widget.id_role),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: [
                ...List.generate(
                  4,
                  (index) => button(index: index, inpoint: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
