import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../views/auth/auth.dart';
import 'package:provider/provider.dart';

import '../../constant/app_color.dart';
import '../../constant/app_constant.dart';
import '../../constant/app_string.dart';
import '../../constant/validator.dart';
import '../../controller/change_password_controller.dart';
import '../../provider/user_provider.dart';
import '../../services/api_response.dart';

class ChanagePassword extends StatefulWidget {
  const ChanagePassword({super.key});
  static const id = 'change-password';

  @override
  State<ChanagePassword> createState() => _ChanagePasswordState();
}

class _ChanagePasswordState extends State<ChanagePassword> {
  bool isChange = false;
  TextEditingController? passwordController;

  TextEditingController? confirmPasswordController;
  bool obscureText = true;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordController!.dispose();
    confirmPasswordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).getUser?.id;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          backgroundColor: AppColors.bcColor,
          title: Text(
            AppString.chnagePassword.tr(),
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: AppColors.bcColor,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 100),
          child: Form(
            key: formKey,
            child: Column(children: [
              TextFormField(
                cursorColor: AppColors.primaryColor,
                controller: passwordController,
                obscureText: obscureText,
                validator: (value) {
                  return Validator.passwordValidator(value);
                },
                decoration: AppConstant().inputDecoration(
                  hintText: AppString.newPassword.tr(),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              TextFormField(
                obscureText: obscureText,
                validator: (value) {
                  return Validator.repeatPasswordValidator(
                    value: value,
                    password: passwordController!.text,
                  );
                },
                cursorColor: AppColors.primaryColor,
                controller: confirmPasswordController,
                decoration: AppConstant().inputDecoration(
                  hintText: AppString.confirmPass.tr(),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[400],
                ),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isChange = true;
                    });

                    late ApiResponse apiResponse;

                    final password = passwordController!.text;
                    final passwordConfirmation =
                        confirmPasswordController!.text;

                    apiResponse = await ChangePasswordController()
                        .changePasswordController(
                      userId: userId!,
                      password: password,
                      passwordConfirmation: passwordConfirmation,
                    );

                    try {
                      setState(() {
                        isChange = true;
                      });
                      if (apiResponse.status == ApiStatus.COMPLETED) {
                        Fluttertoast.showToast(
                          msg: AppString.passUpdate.tr(),
                          toastLength: Toast.LENGTH_SHORT,
                          textColor: Colors.green,
                          backgroundColor: Colors.white,
                          fontSize: 14.0,
                        );

                        Future.delayed(const Duration(milliseconds: 350), () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, AuthScreen.id, (_) => false);
                        });
                      }
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: AppString.errorUpdate.tr(),
                        toastLength: Toast.LENGTH_SHORT,
                        textColor: Colors.white,
                        backgroundColor: Colors.red,
                        fontSize: 14.0,
                      );
                    }
                    setState(() {
                      isChange = false;
                    });
                  }
                },
                label: !isChange
                    ? Text(
                        AppString.chnage.tr(),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )
                    : const CupertinoActivityIndicator(
                        color: Colors.white,
                      ),
              )
            ]),
          ),
        )),
      ),
    );
  }
}
