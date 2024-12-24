import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../constant/Shimmer_app.dart';
import '../../../constant/app_color.dart';
import '../../../constant/app_constant.dart';
import '../../../provider/tag_provider.dart';
import '../../../widgets/container_bottomSheet.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constant/app_string.dart';
import '../../../controller/Tags/create_tag.dart';
import '../../../models/all_tags.dart';
import '../../../services/api_response.dart';
import '../../home/widgets/add_new_tag.dart';

class tagPage extends StatefulWidget {
  const tagPage({Key? key}) : super(key: key);

  @override
  State<tagPage> createState() => _tagPageState();
}

class _tagPageState extends State<tagPage> {
  List<String?> getTagsName() {
    return tagsName;
  }

  TextEditingController _MyController = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  String newTag = '';
  List<int?> _selectedIndexs = [];
  List<String?> tagsName = [];
  @override
  void initState() {
    print('create tag dart');
    createTag({'name': 'test'});
    print('createdd tag');
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
            AppString.tags.tr(),
            style: TextStyle(
              color: Color(0xff272727),
              fontSize: 24,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                AppString.done.tr(),
                style: TextStyle(
                  color: Color(0xff6589FF),
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                if (_selectedIndexs.isEmpty) {
                  print('$_selectedIndexs test if');
                  MotionToast.error(
                    title: Text("Error"),
                    description: Text("You Must Select Tag!"),
                  ).show(context);
                } else {
                  Navigator.pop(context, _selectedIndexs);
                }
              },
            ),
          ],
        ),
        body: Consumer<TagProvider>(builder: (_, tagProvider, __) {
          if (tagProvider.getTags.status == ApiStatus.LOADING) {
            return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  margin: EdgeInsets.all(18),
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      AddNewTag(
                        tag: AppString.allTags.tr(),
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
                      for (int i = 0; i < tagProvider.getTags.data!.length; i++)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tagProvider.getTags.data![i].isSelected = true;
                              if (_selectedIndexs
                                  .contains(tagProvider.getTags.data![i].id)) {
                                _selectedIndexs
                                    .remove(tagProvider.getTags.data![i].id);
                                tagsName
                                    .remove(tagProvider.getTags.data![i].name);
                              } else {
                                _selectedIndexs
                                    .add(tagProvider.getTags.data![i].id);
                                tagsName.add(tagProvider.getTags.data![i].name);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 12, right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: _selectedIndexs
                                      .contains(tagProvider.getTags.data![i].id)
                                  ? AppColors.blueColor
                                  : AppColors.grey3Color,
                            ),
                            child: Text('${tagProvider.getTags.data![i].name}'),
                          ),
                        )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(26),
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
                          print('b then');
                          tagProvider.getTags.data?.add(Tag(
                              isSelected: false,
                              name: value!.name,
                              id: value!.id));
                          print('bss then');
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
                      hintStyle: TextStyle(
                        color: Color(0xffAFAFAF),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
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

  // tagModel.name({required this.name,required this.isSelected});
  void isTagSelect() {
    isSelected = false;
  }
}
