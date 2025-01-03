import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:palmail_project/views/auth/login.dart';
import 'package:palmail_project/views/auth/signup.dart';
// import 'package:palmailnadeenflutter327/views/auth/login.dart';
// import 'package:palmailnadeenflutter327/views/auth/signup.dart';
import '../../constant/app_assets.dart';
import '../../constant/app_color.dart';
import '../../constant/app_string.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const id = 'auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.bcColor,
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: -220,
                child: Container(
                  width: 500,
                  height: 700,
                  decoration: const BoxDecoration(
                    gradient: AppColors.colorGradient,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height,
                ),
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Image.asset(
                      AppAssets.logoApp,
                      width: double.infinity,
                      height: 150,
                    ),
                    const Text(
                      'ديوان رئيس الوزراء',
                      style: TextStyle(
                        fontFamily: 'Andalus',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1ECDCCF1),
                            offset: Offset(4, 0),
                            blurRadius: 13,
                          ),
                        ],
                      ),
                      width: size.width * 0.85,
                      height: size.height * 0.55,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 24, left: 16, right: 16),
                        child: Column(
                          children: [
                            TabBar(
                              controller: tabController,
                              indicator: BoxDecoration(
                                gradient: AppColors.colorGradient,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              labelColor: Colors.white,
                              unselectedLabelColor: const Color(0xFF4498EC),
                              dividerColor: Colors.transparent,
                              tabs: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Tab(
                                    text: AppString.login.tr(),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Tab(
                                    text: AppString.signUp.tr(),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: tabController,
                                children: const [
                                  Login(),
                                  SignUp(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
