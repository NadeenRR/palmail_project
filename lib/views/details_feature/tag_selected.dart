import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../constant/app_color.dart';
import '../../constant/app_constant.dart';
import '../../provider/tag_provider.dart';
import '../../views/details_feature/shmmier_loading.dart';
import '../../widgets/container_bottomSheet.dart';
import 'package:provider/provider.dart';

import '../../../controller/Tags/create_tag.dart';
import '../../../models/all_tags.dart';
import '../../../services/api_response.dart';
import '../../constant/app_string.dart';

class MyTags extends StatefulWidget {
  const MyTags({Key? key}) : super(key: key);

  @override
  State<MyTags> createState() => _tagPageState();
}

class _tagPageState extends State<MyTags> {
  TextEditingController _MyController = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  String newTag = '';
  List<int?> selectedIndex = [];
  List<String?> tagsName = [];
  List<Tag>? tags;
  @override
  void initState() {
    super.initState();
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
              style: AppConstant().tagsStyle.copyWith(fontSize: 18),
            ),
            onPressed: () {
              Navigator.pop(context, [[], [], false]);
            },
          ),
          title: Text(
            AppString.tags.tr(),
            style: AppConstant().titleNameStyle.copyWith(color: Colors.black),
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
                if (selectedIndex.isEmpty) {
                  final snackBar = SnackBar(
                    content: Text(
                      AppString.mustSelectTags.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: AppString.dismiss.tr(),
                      disabledTextColor: Colors.white,
                      textColor: Colors.yellow,
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  Navigator.pop(context, [selectedIndex, tagsName, true]);
                }
              },
            ),
          ],
        ),
        body: Consumer<TagProvider>(builder: (_, tagProvider, __) {
          if (tagProvider.getTags.status == ApiStatus.LOADING) {
            return ShimmerLoading.tagsShimmer();
          }
          if (tagProvider.getTags.status == ApiStatus.COMPLETED) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.only(top: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                  ),
                  child: Wrap(
                    children: [
                      for (final tag in tagProvider.getTags.data!)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tag.isSelected = !tag.isSelected;
                              if (tag.isSelected) {
                                selectedIndex.add(tag.id);
                                tagsName.add(tag.name);
                                tags?.add(tag);
                              } else {
                                selectedIndex.remove(tag.id);
                                tagsName.remove(tag.name);
                                tags?.removeWhere(
                                    (selectedTag) => selectedTag.id == tag.id);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 12, right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: tag.isSelected
                                  ? AppColors.blueColor
                                  : AppColors.grey3Color,
                            ),
                            child: Text('${tag.name}'),
                          ),
                        )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    onSubmitted: (value) async {
                      final body = {
                        'name': _MyController.text,
                      };
                      await createTag(body).then((value) {
                        setState(() {
                          tagProvider.getTags.data?.add(Tag(
                              isSelected: false,
                              name: value!.name,
                              id: value.id));
                        });
                      });
                      _MyController.clear();
                    },
                    focusNode: myFocusNode,
                    controller: _MyController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: AppString.addNewTag.tr(),
                      hintStyle: const TextStyle(
                        color: Color(0xffAFAFAF),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Text('${tagProvider.getTags.message}');
        }),
      ),
      clip: AppConstant.isSelected ? Clip.hardEdge : Clip.none,
      margin: EdgeInsets.zero,
      radius: AppConstant.isSelected
          ? BorderRadius.circular(25)
          : BorderRadius.zero,
    );
  }
}

class tagModel {
  String name;
  bool isSelected;

  tagModel(this.name, this.isSelected);

  void isTagSelect() {
    isSelected = false;
  }
}
