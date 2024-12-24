import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palmail_project/views/splah/splash_screen.dart';

import '../../constant/app_constant.dart';
import '../../constant/app_string.dart';
import '../../constant/validator.dart';
import '../../controller/auth_controller.dart';
import '../../services/api_response.dart';
import '../../services/shared_pref_helper.dart';
import '../../widgets/my_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? nameController;
  TextEditingController? confirmPasswordController;

  FocusNode? emailFocusNode;
  FocusNode? nameFocusNode;
  FocusNode? passwordFocusNode;
  FocusNode? confirmPasswordFocusNode;
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isSignUp = false;

  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    confirmPasswordFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    confirmPasswordController!.dispose();
    confirmPasswordFocusNode!.dispose();
    emailFocusNode!.dispose();
    passwordFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                focusNode: nameFocusNode,
                keyboardType: TextInputType.name,
                cursorColor: Colors.lightBlue[800],
                controller: nameController,
                decoration: AppConstant().inputDecoration(
                  hintText: AppString.enterName.tr(),
                ),
                validator: (value) {
                  return Validator.displayNamevalidator(value);
                },
              ),
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
              TextFormField(
                focusNode: confirmPasswordFocusNode,
                keyboardType: TextInputType.visiblePassword,
                cursorColor: Colors.lightBlue[800],
                controller: confirmPasswordController,
                decoration: AppConstant().inputDecoration(
                  hintText: AppString.confirmPassword.tr(),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                obscureText: obscureText,
                validator: (value) {
                  return Validator.repeatPasswordValidator(
                    value: value,
                    password: passwordController!.text,
                  );
                },
              ),
              MyButton(
                onTap: registerUser,
                child: !isSignUp
                    ? Text(
                        AppString.signUp.tr(),
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

  Future<void> registerUser() async {
    late ApiResponse apiResponse;
    if (formKey.currentState!.validate()) {
      setState(() {
        isSignUp = true;
      });
      final email = emailController!.text;
      final password = passwordController!.text;
      final name = nameController!.text;
      final passwordConfirmation = confirmPasswordController!.text;

      apiResponse = await AuthController().registerUser(
        email: email,
        password: password,
        name: name,
        passwordConfirmation: passwordConfirmation,
      );
      try {
        if (apiResponse.status == ApiStatus.COMPLETED) {
          setState(() {
            isSignUp = false;
          });
          SharedPreferencesHelper.saveUserToken(apiResponse.data?.token ?? '');

          Fluttertoast.showToast(
            msg: "Register successfully",
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.green,
            backgroundColor: Colors.white,
            fontSize: 14.0,
          );

          Future.delayed(const Duration(milliseconds: 200), () {
            Navigator.pushNamedAndRemoveUntil(
                context, SplashScreen.id, (_) => false);
          });
        } else {
          setState(() {
            isSignUp = false;
          });
          Fluttertoast.showToast(
            msg: "Email address is already registered",
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            backgroundColor: Colors.red,
            fontSize: 14.0,
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: AppString.registerSuccessfully.tr(),
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.green,
          backgroundColor: Colors.white,
          fontSize: 14.0,
        );
      }
    }
  }
}
