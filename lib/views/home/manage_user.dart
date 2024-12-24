import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../controller/role/all_role.dart';
import '../../../provider/all_role.dart';
import '../../../services/api_response.dart';
import '../../../views/home/change_role.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/app_color.dart';
import '../../../views/home/widgets/user_expanation_tile.dart';

import '../../constant/app_string.dart';

class ManageSceen extends StatefulWidget {
  static const id = 'manage-screen';

  const ManageSceen({Key? key}) : super(key: key);

  @override
  State<ManageSceen> createState() => _ManageSceenState();
}

class _ManageSceenState extends State<ManageSceen> {
  FocusNode myFocusNode = FocusNode();
  TextEditingController _searchUser = TextEditingController();
  String SearchUser = '';
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppString.manageUser.tr(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      SearchUser = _searchUser.text;
                    });
                  },
                  focusNode: myFocusNode,
                  cursorColor: Colors.black,
                  controller: _searchUser,
                  decoration: InputDecoration(
                    suffixStyle: const TextStyle(
                      fontSize: 18,
                    ),
                    suffixIcon: Visibility(
                      visible: myFocusNode.hasFocus,
                      child: IconButton(
                        icon: const Icon(
                          Icons.cancel,
                          size: 32,
                        ),
                        onPressed: () {
                          _searchUser.clear();
                        },
                      ),
                    ),
                    suffixIconColor: MaterialStateColor.resolveWith((states) =>
                        states.contains(MaterialState.focused)
                            ? Colors.black
                            : Colors.grey),
                    filled: true,
                    fillColor: const Color(0xffEAEAF5),
                    labelText: AppString.search.tr(),
                    labelStyle: TextStyle(
                      color: myFocusNode.hasFocus
                          ? Colors.black
                          : const Color(0xffAFAFAF),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: MaterialStateColor.resolveWith((states) =>
                        states.contains(MaterialState.focused)
                            ? Colors.black
                            : Colors.grey),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      borderSide: BorderSide(
                          color:
                              Colors.transparent), // Change border color here
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      borderSide: BorderSide(
                          color:
                              Colors.transparent), // Change border color here
                    ),
                  ),
                ),
              ),
              Consumer<RoleProvider>(builder: (_, UserProvider, __) {
                if (UserProvider.getRoles.status == ApiStatus.LOADING) {
                  return SingleChildScrollView(
                    child: Padding(
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
                              return ExpansionTile(
                                shape: const Border(
                                  top: BorderSide(color: Colors.transparent),
                                  bottom: BorderSide(color: Colors.transparent),
                                ),
                                iconColor: AppColors.primaryColor,
                                textColor: const Color(0xff272727),
                                collapsedIconColor: const Color(0xffB2B2B2),
                                tilePadding: EdgeInsets.zero,
                                title: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade700,
                                  child: Text(
                                    AppString.loading.tr(),
                                    // Replace with your actual title
                                    style: TextStyle(
                                      color: Colors.cyan,
                                    ),
                                  ),
                                ),
                                children: <Widget>[],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }
                if (UserProvider.getRoles.status == ApiStatus.COMPLETED) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SearchUser == ''
                          ? Column(
                              children: [
                                for (int i = 0;
                                    i < UserProvider.getRoles.data!.length;
                                    i++) ...{
                                  CategoryExpansionTile(
                                    subject:
                                        '${UserProvider.getRoles.data![i].name![0].toUpperCase()}${UserProvider.getRoles.data![i].name!.substring(1)}',
                                    subTitle:
                                        '${UserProvider.getRoles.data![i].usersCount}',
                                    names: UserProvider.getRoles.data![i].users,
                                    id_role: UserProvider.getRoles.data![i].id,
                                  )
                                }
                              ],
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  for (int s = 0;
                                      s < UserProvider.getRoles.data!.length;
                                      s++) ...{
                                    for (int d = 0;
                                        d <
                                            UserProvider.getRoles.data![s]
                                                .users!.length;
                                        d++) ...{
                                      if (UserProvider
                                          .getRoles.data![s].users![d].name!
                                          .contains(_searchUser.text)) ...{
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                '${UserProvider.getRoles.data![s].users![d].name}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Spacer(),
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return ChangeRole(
                                                        id_user: UserProvider
                                                            .getRoles
                                                            .data![s]
                                                            .users![d]
                                                            .id,
                                                        name: UserProvider
                                                            .getRoles
                                                            .data![s]
                                                            .users![d]
                                                            .name,
                                                        id_role: UserProvider
                                                            .getRoles
                                                            .data![s]
                                                            .id);
                                                  }));
                                                  setState(() {
                                                    _searchUser.text = '';
                                                    SearchUser = '';
                                                  });
                                                },
                                                icon: Icon(Icons.edit),
                                              ),
                                            ],
                                          ),
                                        )
                                      }
                                    }
                                  }
                                ],
                              ),
                            ),
                    ),
                  );
                }
                return Text('${UserProvider.getRoles.message}Error');
              })
            ],
          ),
        ),
      ),
    );
  }
}
