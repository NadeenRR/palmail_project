import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/Shimmer_app.dart';
import '../../../constant/app_color.dart';
import '../../../controller/Tags/tag_mails.dart';
import '../../../models/mail_tags.dart';
import '../../../provider/mail_tags.dart';
import '../../../provider/tag_provider.dart';
import '../../../provider/tags_provider.dart';
import '../../../services/api_response.dart';
import 'add_new_tag.dart';

class MailOfTags extends StatefulWidget {
  static const id = 'MailTag';

  final List<int> ids;
  const MailOfTags({Key? key, required this.ids}) : super(key: key);

  @override
  State<MailOfTags> createState() => _MailOfTagsState();
}

class _MailOfTagsState extends State<MailOfTags> {
  List<int> _selectedIndexs = [];
  Set<int> _allid = Set<int>();
  List<String?> tagsName = [];
  List<Mail>? mails = [];
  String sender = '';
  String ArchiveNumber = '';
  String desc = '';
  String decision = '';
  String finaldecisiion = '';
  String statues_id = '';
  List<Tag?>? tags;
  Future<List<Tag>?>? mailstags;
  @override
  void initState() {
    MailsTags().FetchAllTags(_selectedIndexs);

    // TODO: implement initState

    super.initState();
    if (widget.ids.length > 1) {
      isSelected = true;
    } else {
      _selectedIndexs = widget.ids;
    }
  }

  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bcColor,
      appBar: AppBar(
        backgroundColor: AppColors.bcColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Tags',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer<TagProvider>(builder: (_, tagProvider, __) {
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
                if (tagProvider.getTags.status == ApiStatus.COMPLETED) {
                  return tagProvider.getTags.data != null
                      ? Column(
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
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSelected = !isSelected;
                                      });
                                      print('$isSelected out iffffffff');

                                      if (isSelected) {
                                        print('in iffffffff');
                                        for (int i = 0;
                                            i <
                                                tagProvider
                                                    .getTags.data!.length;
                                            i++) {
                                          _allid.add(
                                              tagProvider.getTags.data![i].id!);
                                        }

                                        Provider.of<MailTagsProvider>(context,
                                                listen: false)
                                            .fetchTagsMails(_allid.toList());
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.only(
                                          bottom: 12, right: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: isSelected
                                            ? AppColors.blueColor
                                            : AppColors.grey3Color,
                                      ),
                                      child: Text('All Tags'),
                                    ),
                                  ),
                                  for (int i = 0;
                                      i < tagProvider.getTags.data!.length;
                                      i++) ...{
                                    GestureDetector(
                                      onTap: () async {
                                        tagProvider
                                            .getTags.data![i].isSelected = true;
                                        if (_selectedIndexs.contains(
                                            tagProvider.getTags.data![i].id)) {
                                          setState(() {
                                            _selectedIndexs.remove(tagProvider
                                                .getTags.data![i].id);
                                            tagsName.remove(tagProvider
                                                .getTags.data![i].name);
                                          });
                                        } else {
                                          setState(() {
                                            _selectedIndexs.add(tagProvider
                                                .getTags.data![i].id!);
                                            tagsName.add(tagProvider
                                                .getTags.data![i].name);
                                          });
                                          print(
                                              '${_selectedIndexs} select index id');
                                        }
                                        Provider.of<MailTagsProvider>(context,
                                                listen: false)
                                            .fetchTagsMails(_selectedIndexs);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        margin: const EdgeInsets.only(
                                            bottom: 12, right: 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: _selectedIndexs.contains(
                                                  tagProvider
                                                      .getTags.data![i].id)
                                              ? AppColors.blueColor
                                              : AppColors.grey3Color,
                                        ),
                                        child: Text(
                                            '${tagProvider.getTags.data![i].name}'),
                                      ),
                                    )
                                  }
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        )
                      : const Text('tessssssssssssssssssssssst');
                }
                return Text('${tagProvider.getTags.message}');
              }),
              Divider(),
              if (_selectedIndexs.isNotEmpty || isSelected) ...{
                Consumer<MailTagsProvider>(
                  builder: (_, TagsMailProvider, __) {
                    if (TagsMailProvider.getMails.status == ApiStatus.LOADING) {
                      return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: EdgeInsets.all(18),
                                    height: 140,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Text(''));
                              }));
                    }
                    if (TagsMailProvider.getMails.status ==
                        ApiStatus.COMPLETED) {
                      return Column(
                        children: [
                          for (int i = 0;
                              i < TagsMailProvider.getMails.data!.length;
                              i++) ...{
                            ExpansionTileCustomemailtags(
                              size: size,
                              subject:
                                  TagsMailProvider.getMails.data![i].subject ??
                                      '',
                              subTitle: TagsMailProvider
                                      .getMails.data![i].description ??
                                  '',
                              color: int.parse(TagsMailProvider
                                  .getMails.data![i].status!.color!),
                              date: DateFormat('dd-MM-yyyy').format(
                                  TagsMailProvider
                                      .getMails.data![i].archiveDate!),
                              organizationName:
                                  '${TagsMailProvider.getMails.data![i].sender!.name}' ??
                                      '',
                              tag: TagsMailProvider.getMails.data![i].tags
                                  ?.map((e) => e.name)
                                  .toList()
                                  .join(' #'),
                              imageList: SizedBox(
                                height: 50,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: TagsMailProvider
                                        .getMails.data![i].attachments!.length,
                                    itemBuilder: (context, attachmentIndex) {
                                      final attachment = TagsMailProvider
                                          .getMails
                                          .data![i]
                                          .attachments![attachmentIndex];
                                      final imageUrl =
                                          'http://palmail.gazawar.wiki/${attachment.image}';
                                      return Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        height: size.height / 20,
                                        width: size.width / 10,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                imageUrl),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          }
                        ],
                      );
                    }

                    return Text('${TagsMailProvider.getMails.message} test ');
                  },
                )
              } else ...{
                Text('No Tags Selected')
              }
            ],
          ),
        ),
      ),
    );
  }
}

class ExpansionTileCustomemailtags extends StatelessWidget {
  const ExpansionTileCustomemailtags({
    super.key,
    required this.size,
    required this.organizationName,
    required this.date,
    required this.subject,
    required this.subTitle,
    required this.tag,
    required this.color,
    //   required this.image,
    required this.imageList,
  });

  final Size size;

  final String? organizationName;
  final String? date;
  final String? subject;
  final String? subTitle;
  final String? tag;
  final int? color;
//  final ImageProvider image;
  final Widget imageList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 7,
                  backgroundColor: Color(color!),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  organizationName!,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xff272727),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  date!,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xffb2b2b2),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Color(0xffb2b2b2),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xff272727),
                    ),
                  ),
                  Text(
                    subTitle!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xff6589ff),
                    ),
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: [
                      //  for (int i = 0; i < 10; i++) ...[
                      Text(
                        '#$tag ',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xff6589ff),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // ]
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: [imageList],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
