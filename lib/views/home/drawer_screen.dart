import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../views/home/manage_user.dart';
import '../../../views/home/profile_screen.dart';
import '../../../views/home/widgets/slid_menu_title.dart';
import 'package:provider/provider.dart';
import '../../../views/home/sender_mails/all_sender.dart';
import '../../constant/app_assets.dart';
import '../../constant/app_color.dart';
import '../../constant/app_string.dart';
import '../../provider/user_provider.dart';
import '../../services/mange_language.dart';
import '../ArchiveMail/archive_mail_view.dart';
import 'home_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key, required this.onTap});
  final Function() onTap;

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getSingleUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser?.role?.id;

    print(user);
    Size size = MediaQuery.of(context).size;
    final userId = Provider.of<UserProvider>(context).getUser?.role?.id;
    print(userId);
    return GestureDetector(
      onTap: widget.onTap,
      child: SafeArea(
        child: Container(
          width: size.width,
          color: AppColors.primaryColor,
          child: Padding(
            // padding: const EdgeInsets.only(left: 24, top: 68, bottom: 24),
            padding: isRtl(context)
                ? const EdgeInsets.only(right: 24, top: 68, bottom: 24)
                : const EdgeInsets.only(left: 24, top: 68, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppAssets.logoApp,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 18,
                ),
                SlidMenuTitle(
                  icon: CupertinoIcons.home,
                  press: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      HomeScreen.id,
                      (_) => false,
                    );
                  },
                  title: AppString.home.tr(),
                ),
                SlidMenuTitle(
                  icon: CupertinoIcons.profile_circled,
                  press: () {
                    Navigator.pushNamed(
                      context,
                      ProfileScreen.id,
                    );
                  },
                  title: AppString.profile.tr(),
                ),
                SlidMenuTitle(
                  icon: CupertinoIcons.create,
                  press: () {
                    Navigator.pushNamed(context, sendersView.id);
                  },
                  title: AppString.senders.tr(),
                ),
                Visibility(
                  visible: userId == 4,
                  child: SlidMenuTitle(
                    icon: Icons.settings,
                    press: () {
                      Navigator.pushNamed(
                        context,
                        ManageSceen.id,
                      );
                    },
                    title: AppString.manageUser.tr(),
                  ),
                ),
                SlidMenuTitle(
                  icon: Icons.archive,
                  press: () {
                    Navigator.pushNamed(
                      context,
                      ArchivedMailScreen.id,
                    );
                  },
                  title: AppString.archive.tr(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
