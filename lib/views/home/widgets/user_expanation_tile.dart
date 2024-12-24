import 'package:flutter/material.dart';

import '../../../constant/app_color.dart';
import '../../../models/all_role.dart';
import '../../../views/home/change_role.dart';

class CategoryExpansionTile extends StatefulWidget {
  const CategoryExpansionTile({
    super.key,
    required this.subject,
    required this.subTitle,
    required this.names,
    this.id_role,
  });

  final String? subject;
  final String? subTitle;
  final List<User>? names;
  final int? id_role;

  @override
  State<CategoryExpansionTile> createState() => _CategoryExpansionTileState();
}

class _CategoryExpansionTileState extends State<CategoryExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const Border(
        top: BorderSide(color: Colors.transparent),
        bottom: BorderSide(color: Colors.transparent),
      ),
      iconColor: AppColors.primaryColor,
      textColor: const Color(0xff272727),
      collapsedIconColor: const Color(0xffB2B2B2),
      tilePadding: EdgeInsets.zero,
      title: Text(
        widget.subTitle!,
        style: TextStyle(
          fontSize: 14,
          color: const Color(0xff6589ff),
        ),
      ),
      leading: Text(
        widget.subject!,
        style: TextStyle(
          fontSize: 20,
          color: const Color(0xff272727),
          fontWeight: FontWeight.w600,
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.names!.length; i++) ...{
                      Row(
                        children: [
                          Text(
                            '${widget.names![i].name}',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () async {
                              await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ChangeRole(
                                    id_user: widget.names![i].id,
                                    name: widget.names![i].name,
                                    id_role: widget.id_role);
                              }));

                              setState(() {
                                // id_new[0] = widget.id_role;
                                // id_new[1] = widget.names![i].id;
                              });
                            },
                            icon: Icon(Icons.edit),
                          )
                        ],
                      )
                    }
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
