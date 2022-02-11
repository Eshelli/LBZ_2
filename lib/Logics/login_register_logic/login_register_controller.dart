
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/Logics/login_register_logic/models/login.dart';
import 'package:lbz/Screens/home_screen.dart';
import 'package:lbz/commen_models/errors_models.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/network/local/cache_helper.dart';
import 'models/register.dart';

class LoginRegisterController extends GetxController {
  late LoginModel loginStatus;
  late RegisterModel registerStatus;
  late MessageError msg;
  var isLoading = false.obs;
  var appController = Get.find<AppController>();

  void login(String email, String pass) {
    isLoading.value = true;
    dioHelper.postData(url: "login", data: {
      "email": email,
      "password": pass,
      "generate-token": true,
      "firebase-token": "true"
    }).then((value) {
      print(value.data);
      return {

        if (value.statusCode != 200)
          {
            msg = MessageError.fromJson(value.data),
            if (msg.errors != null)
              {
                msg.errors!.forEach((key, value) {
                  if (value is List) {
                    value.forEach((value) {
                      Get.snackbar(
                        '',
                        '',
                        titleText: const Center(
                            child: Icon(
                          Icons.warning,
                          color: Colors.white,
                        )),
                        messageText: Center(
                            child: Text(
                          value.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                        backgroundColor: Colors.orange,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    });
                  } else {
                    Get.snackbar(
                      '',
                      '',
                      titleText: const Center(
                          child: Icon(
                        Icons.check,
                        color: Colors.white,
                      )),
                      messageText: Center(
                          child: Text(
                        value.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                }),
              }
            else
              {
                Get.snackbar(
                  '',
                  '',
                  titleText: const Center(
                      child: Icon(
                    Icons.warning,
                    color: Colors.white,
                  )),
                  messageText: Center(
                      child: Text(
                    msg.message.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                  backgroundColor: Colors.orange,
                  snackPosition: SnackPosition.BOTTOM,
                ),
                Get.offAll(HomeScreen())
              },
            isLoading.value = false,

          }
        else
          {
            loginStatus = LoginModel.fromJson(value.data),
            print(loginStatus.token),
            CacheHelper.saveData(key: 'token', value: loginStatus.token),
            token = loginStatus.token,
            print(token),
            appController.tokenCheck(),
            update(),
            isLoading.value = false,
            Get.snackbar(
              '',
              '',
              titleText: const Center(
                  child: Icon(
                Icons.check,
                color: Colors.white,
              )),
              messageText: const Center(
                  child: Text(
                'تمت العملية بنجاح',
                style: TextStyle(color: Colors.white),
              )),
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM,
            ),
            Get.offAll(HomeScreen()),
          },
      };
    }).catchError((onError) {
      print(onError.toString());
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
            Icons.error,
            color: Colors.white,
          )),
          messageText: const Center(
              child: Text(
            'حدث خطاء الرجاء إعادة المحاولة',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  void register(String name, String email, String phoneNumber, String pass,
      String passCun) {
    isLoading.value = true;
    dioHelper.postData(url: "register", data: {
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      "password": pass,
      "password_confirmation": passCun
    }).then((value) {
      return {
        print(value.data),
        if (value.statusCode != 200)
          {
            msg = MessageError.fromJson(value.data),
            if (msg.errors != null)
              {
                msg.errors!.forEach((key, value) {
                  if (value is List) {
                    value.forEach((value) {
                      Get.snackbar(
                        '',
                        '',
                        titleText: const Center(
                            child: Icon(
                          Icons.warning,
                          color: Colors.white,
                        )),
                        messageText: Center(
                            child: Text(
                          value.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                        backgroundColor: Colors.orange,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    });
                  } else {
                    Get.snackbar(
                      '',
                      '',
                      titleText: const Center(
                          child: Icon(
                        Icons.check,
                        color: Colors.white,
                      )),
                      messageText: Center(
                          child: Text(
                        value.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                }),
              }
            else
              {
                Get.snackbar(
                  '',
                  '',
                  titleText: const Center(
                      child: Icon(
                    Icons.warning,
                    color: Colors.white,
                  )),
                  messageText: Center(
                      child: Text(
                    msg.message.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                  backgroundColor: Colors.orange,
                  snackPosition: SnackPosition.BOTTOM,
                ),
              }
          }
        else
          {
            registerStatus = RegisterModel.fromJson(value.data),
            Get.snackbar(
              '',
              '',
              titleText: const Center(
                  child: Icon(
                Icons.check,
                color: Colors.white,
              )),
              messageText: const Center(
                  child: Text(
                'تمت العملية بنجاح',
                style: TextStyle(color: Colors.white),
              )),
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM,
            ),
          },
        update(),
        isLoading.value = false,
      };
    });
  }

  void forgetPass(email){
    isLoading.value = true;
    dioHelper.postData(url: "forgot-password", data: {
      "email": email,
    }).then((value) {
      print(value.data);
      return {

        if (value.statusCode != 200)
          {
            msg = MessageError.fromJson(value.data),
            if (msg.errors != null)
              {
                msg.errors!.forEach((key, value) {
                  if (value is List) {
                    value.forEach((value) {
                      Get.snackbar(
                        '',
                        '',
                        titleText: const Center(
                            child: Icon(
                              Icons.warning,
                              color: Colors.white,
                            )),
                        messageText: Center(
                            child: Text(
                              value.toString(),
                              style: TextStyle(color: Colors.white),
                            )),
                        backgroundColor: Colors.orange,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    });
                  } else {
                    Get.snackbar(
                      '',
                      '',
                      titleText: const Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          )),
                      messageText: Center(
                          child: Text(
                            value.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                }),
              }
            else
              {
                Get.snackbar(
                  '',
                  '',
                  titleText: const Center(
                      child: Icon(
                        Icons.warning,
                        color: Colors.white,
                      )),
                  messageText: Center(
                      child: Text(
                        msg.message.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  backgroundColor: Colors.orange,
                  snackPosition: SnackPosition.BOTTOM,
                ),

              },
            Get.offAll(HomeScreen())
          }
        else
          {
            isLoading.value = false,
            Get.back(),
            Get.snackbar(
              '',
              '',
              titleText: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  )),
              messageText: const Center(
                  child: Text(
                    'تمت العملية بنجاح',
                    style: TextStyle(color: Colors.white),
                  )),
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM,
            ),
          },
      };
    }).catchError((onError) {
      print(onError.toString());
      isLoading.value = false;
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
                Icons.error,
                color: Colors.white,
              )),
          messageText: const Center(
              child: Text(
                'حدث خطاء الرجاء إعادة المحاولة',
                style: TextStyle(color: Colors.white),
              )),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  @override
  void onInit() {
    super.onInit();
  }
}
