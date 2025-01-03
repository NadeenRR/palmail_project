import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../constant/app_color.dart';
import '../../../views/home/widgets/category_expansion_tile.dart';
import '../../constant/app_constant.dart';
import '../../provider/categories_provider.dart';
import '../../provider/mail_provider.dart';
import '../../provider/single_mail_provider.dart';
import '../../provider/statuses_provider.dart';
import '../../provider/user_provider.dart';
import '../../widgets/container_bottomSheet.dart';
import '../../widgets/my_bottomSheet.dart';
import '../details_feature/details_screen.dart';

class MailsForSingleStatues extends StatefulWidget {
  const MailsForSingleStatues({super.key, this.statusId, required this.name});
  final int? statusId;
  final String name;

  @override
  State<MailsForSingleStatues> createState() => _MailsForSingleStatuesState();
}

class _MailsForSingleStatuesState extends State<MailsForSingleStatues> {
  @override
  void initState() {
    Provider.of<StatusesProvider>(context, listen: false).getAllStatuses();
    Provider.of<CategoriesProvider>(context, listen: false).getAllCategories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final singleMailProvider =
        Provider.of<SingleMailProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context).getUser?.role?.id;
    return container_bottomSheet(context,
        clip: AppConstant.isSelected ? Clip.hardEdge : Clip.none,
        radius: AppConstant.isSelected
            ? BorderRadius.circular(25)
            : BorderRadius.zero,
        margin: AppConstant.isSelected
            ? const EdgeInsets.only(
                top: 45,
              )
            : EdgeInsets.zero,
        child: Scaffold(
          backgroundColor: AppColors.bcColor,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 34),
                child: Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                    Text(
                      widget.name,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: Consumer2<StatusesProvider, CategoriesProvider>(
                  builder:
                      (BuildContext context, value, catValue, Widget? child) {
                    final allEmailStatuses = value.getStatuses;
                    final allCategories = catValue.getCategories;

                    if (allEmailStatuses != null && allCategories != null) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: allCategories.length,
                        itemBuilder: (context, categoryIndex) {
                          final category = allCategories[categoryIndex];

                          final emailsForCategory = allEmailStatuses
                              .where((element) => element.id == widget.statusId)
                              .expand((status) => status.mails!)
                              .where((mail) =>
                                  mail.sender?.category?.name == category.name)
                              .toList();

                          if (emailsForCategory.isNotEmpty) {
                            return CategoryExpansionTile(
                                count: emailsForCategory.length,
                                organization: category.name ?? "",
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: emailsForCategory.length,
                                  itemBuilder: (context, index) {
                                    final email = emailsForCategory[index];

                                    DateTime parsedDateTime;

                                    try {
                                      parsedDateTime =
                                          DateTime.parse(email.createdAt!);
                                    } catch (e) {
                                      parsedDateTime = DateTime.now();
                                    }

                                    final color =
                                        int.parse(email.status?.color ?? '0');
                                    return GestureDetector(
                                      onTap: () async {
                                        if (user != 1) {
                                          singleMailProvider
                                              .setCurrentMailId(email.id!);
                                          singleMailProvider.toggleHomeMails();
                                          setState(() {
                                            AppConstant.isSelected = true;
                                          });
                                          await mybottomsheet(
                                            context,
                                            const DetailsScreen(),
                                          ).whenComplete(() {
                                            Provider.of<StatusesProvider>(
                                                    context,
                                                    listen: false)
                                                .getStatuses;
                                          });
                                          setState(() {
                                            AppConstant.isSelected = false;
                                          });
                                        }
                                      },
                                      child: ExpansionTileCustome(
                                          size: size,
                                          color: color,
                                          date: DateFormat('dd-MM-yyyy')
                                              .format(parsedDateTime),
                                          organizationName:
                                              email.sender?.name ?? '',
                                          subTitle: email.description ?? '',
                                          subject: email.subject ?? '',
                                          tag:email.tags!.map((e) => e.name)
                                              .toList()
                                              .join(' #') ?? '',
                                          imageList: SizedBox(
                                            height: 50,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount:
                                                    email.attachments!.length,
                                                itemBuilder:
                                                    (context, attachmentIndex) {
                                                  final attachment =
                                                      email.attachments?[
                                                          attachmentIndex];

                                                  final imageUrl =
                                                      'http://palmail.gazawar.wiki/${attachment?.image}';
                                                  return Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    height: size.height / 20,
                                                    width: size.width / 10,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            imageUrl),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          )),
                                    );
                                  },
                                  separatorBuilder: (context, subIndex) =>
                                      const SizedBox(height: 20),
                                ));
                          } else {
                            return const SizedBox();
                          }
                        },
                      );
                    } else {
                      return const CupertinoActivityIndicator();
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
