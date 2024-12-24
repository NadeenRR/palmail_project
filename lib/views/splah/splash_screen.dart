import 'package:flutter/material.dart';
import '../../constant/app_color.dart';
import '../../constant/app_assets.dart';
import '../../services/shared_pref_helper.dart';
import '../auth/auth.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const id = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkLogin() async {
    final hasToken = await SharedPreferencesHelper.hasUserToken();
    if (hasToken && mounted) {
      Navigator.pushNamed(context, HomeScreen.id);
    } else {
      Navigator.pushNamed(context, AuthScreen.id);
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200), () {
      checkLogin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.colorGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppAssets.logoApp),
              const Text('ديوان رئيس الوزراء' , style: TextStyle(
                fontFamily: 'Andalus',
                fontSize: 24,
                color: Colors.white,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
