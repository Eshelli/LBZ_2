import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libozzle/Logics/app_logic/app_controller.dart';
import 'package:libozzle/Logics/login_register_logic/login_register_controller.dart';
import 'package:libozzle/Screens/components/components.dart';
import 'package:libozzle/shared/components/constans.dart';
import 'package:libozzle/shared/components/varibales_combonents.dart';
import 'package:libozzle/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    var loginRegisterController = Get.put(LoginRegisterController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    lang == 'ar'
                        ? 'تسجيل الدخول بالبريد الإلكتروني الخاص بك'
                        : 'Login with your email',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                defualtTextForm(context,
                    controler: emailController,
                    label: 'Email',
                    type: TextInputType.emailAddress,
                    clr: darkGrayDefaultColor,
                    validator: (value) {
                      if (value.isEmpty) {
                        return lang == 'ar' ? 'الرجاء إدخال البريد الالكتروني'
                            : 'Please enter your email';
                      }
                      return null;
                    },
                    radius: 15),
                const SizedBox(
                  height: 10,
                ),
                defualtTextForm(context,
                    controler: passController,
                    label: 'Password',
                    type: TextInputType.visiblePassword,
                    clr: darkGrayDefaultColor,
                    validator: (value) {
                      if (value.isEmpty) {
                        return lang == 'ar' ? 'الرجاء إدخال كلمة المرور'
                            : 'Please enter password';
                      }
                      return null;
                    },
                    radius: 15),
                TextButton(
                  onPressed: () {
                    var formKey2 = GlobalKey<FormState>();
                    var emailForgetController = TextEditingController();
                    dialog([
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            lang == 'ar'
                                ? 'نسيت كلمة المرور'
                                : 'Forgot your password',
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle1!,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 45),
                            child: Text(
                              lang == 'ar'
                                  ? 'أدخل بريدك الإلكتروني وسنرسل لك رابطًا لإنشاء كلمة مرور جديدة'
                                  : 'Enter your email and we\'ll send you a link to create a new password',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: 19),
                              textAlign: TextAlign.center,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Form(
                          key: formKey2,
                          child: defualtTextForm(context,
                              controler: emailForgetController,
                              label: 'Email',
                              type: TextInputType.text, validator: (value) {
                                if (value.isEmpty) {
                                  return lang == 'ar'
                                      ? 'الرجاء أدخل بريدك الإلكتروني'
                                      : 'Please enter your email';
                                }
                                return null;
                              }, radius: 5),
                        ),
                      ),
                      Obx(() {
                        if (loginRegisterController.isLoading.value) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator(),),
                          );
                        }
                        return button(lang == 'ar'
                            ? 'إعادة تعيين كلمة المرور'
                            : 'Reset Password', null, color: redDefaultColor,
                            clr: Colors.white,
                            onPress: () {
                              if (formKey2.currentState!.validate()) {
                                loginRegisterController.forgetPass(
                                    emailForgetController.text);
                              }
                            });
                      }
                      )
                    ]);
                  },
                  child: Text(
                    lang == 'ar'
                        ? 'نسيت كلمة المرور؟'
                        : 'Forgot your password?',
                    style: TextStyle(color: redDefaultColor),),

                ),
                Obx(() {
                  return SizedBox(
                    height: 50,
                    child: loginRegisterController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : button(
                      lang == 'ar' ? 'تسجيل الدخول' : 'Login',
                      null,
                      clr: Colors.white,
                      color: redDefaultColor,
                      fontSize: 25,
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          if (GetUtils.isEmail(emailController.text)) {
                            loginRegisterController.login(
                                emailController.text,
                                passController.text);
                          } else {
                            Get.snackbar('', '',
                                titleText: Text(
                                  lang == 'ar'
                                      ? 'البريد الالكتروني غير صحيح'
                                      : 'Incorrect email',
                                  style: TextStyle(color: Colors.white),
                                  textDirection: TextDirection.rtl,
                                ),
                                messageText: Text(
                                    lang == 'ar'
                                        ? 'الرجاء التأكد من البريد الالكتروني'
                                        : 'Please check the email',
                                    style: TextStyle(color: Colors.white),
                                    textDirection: TextDirection.rtl),
                                colorText: Colors.white,
                                backgroundColor: Colors.red,
                                snackPosition: SnackPosition.BOTTOM,
                                icon: const Icon(
                                  Icons.warning,
                                  color: Colors.white,
                                ));
                          }
                        }
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ));
  }
}
