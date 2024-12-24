import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palmail_project/controller/auth_controller.dart';
import '../../constant/app_constant.dart';
import '../../constant/app_string.dart';
import '../../constant/validator.dart';
import '../../services/api_response.dart';
import '../../services/shared_pref_helper.dart';
import '../../test.dart';
import '../../widgets/my_button.dart';
import '../home/home_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  FocusNode? emailFocusNode;
  FocusNode? passwordFocusNode;
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLogin = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    emailFocusNode!.dispose();
    passwordFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.lightBlue[800],
                controller: emailController,
                decoration: AppConstant().inputDecoration(
                  hintText: AppString.enterEmail.tr(),
                ),
                validator: (value) {
                  return Validator.emailValidator(value);
                },
              ),
              TextFormField(
                focusNode: passwordFocusNode,
                keyboardType: TextInputType.visiblePassword,
                cursorColor: Colors.lightBlue[800],
                controller: passwordController,
                decoration: AppConstant().inputDecoration(
                  hintText: AppString.password.tr(),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                obscureText: obscureText,
                validator: (value) {
                  return Validator.passwordValidator(value);
                },
              ),
              MyButton(
                onTap: loginUser,
                child: !isLogin
                    ? Text(
                        AppString.login.tr(),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )
                    : const CupertinoActivityIndicator(
                        color: Colors.white,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    late ApiResponse apiResponse;

    if (formKey.currentState!.validate()) {
      setState(() {
        isLogin = true;
      });
      final email = emailController!.text;
      final password = passwordController!.text;

      apiResponse =
          await AuthController().loginUser(email: email, password: password);

      try {
        if (apiResponse.status == ApiStatus.COMPLETED) {
          setState(() {
            isLogin = true;
          });
          SharedPreferencesHelper.saveUserToken(apiResponse.data?.token ?? '');

          Fluttertoast.showToast(
            msg: AppString.loginSuccessfully.tr(),
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.green,
            backgroundColor: Colors.white,
            fontSize: 14.0,
          );
          Future.delayed(const Duration(milliseconds: 200), () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.id,
              (_) => false,
            );
          });
        } else {
          setState(() {
            isLogin = false;
          });
          Fluttertoast.showToast(
            msg: AppString.invalidFailed.tr(),
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            backgroundColor: Colors.red,
            fontSize: 14.0,
          );
        }
      } catch (e) {
        setState(() {
          isLogin = false;
        });
        Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          backgroundColor: Colors.red,
          fontSize: 14.0,
        );
      }
    }
  }
}

/* 
 Future<void> login() async {
    late ApiResponse<Users> apiResponse;
    if (formKey.currentState!.validate()) {
      setState(() {
        isLogin = true;
      });
      final email = emailController!.text;
      final password = passwordController!.text;

      apiResponse =
          await AuthController().login(email: email, password: password);
      if (apiResponse.status == Status.COMPLETED) {
        setState(() {
          isLogin = true;
        });
        SharedPreferencesHelper.saveUserToken(apiResponse.data?.token ?? '');

        Fluttertoast.showToast(
          msg: "Login successfully",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.green,
          backgroundColor: Colors.white,
          fontSize: 14.0,
        );
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.id, (_) => false);
        });
      } else {
        setState(() {
          isLogin = false;
        });
        Fluttertoast.showToast(
          msg: "Login Failed",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          backgroundColor: Colors.red,
          fontSize: 14.0,
        );
      }
    }
  }



*/
