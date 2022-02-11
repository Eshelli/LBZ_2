
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libozzle/Screens/notification/model/notification_model.dart';
import 'package:libozzle/commen_models/errors_models.dart';
import 'package:libozzle/shared/components/constans.dart';

class NotificationController extends GetxController {
  var notiIsLoading = false.obs;
  late MessageError msg;
  late Noti notification;
  var unreadCount = 0.obs;
  List<String> notiId = [];

  Future getNotification() async {
    notiIsLoading.value = true;
    notiId = [];
    dioHelper.getData(url: 'notifications').then((value) {
      return {
        notification = Noti.fromJson(value.data),
        update(),
        notiIsLoading.value = false,
      };
    }).catchError((onError) {
      print(onError.toString());
      notiIsLoading.value = false;
    });
  }

  Future getUnreadNotificationCount() async {
    notiIsLoading.value = true;
    notiId = [];
    dioHelper.getData(url: 'notifications/unread').then((value) {
      return {
        unreadCount.value = value.data["count"],
        print(value.data["count"]),
        update(),
        notiIsLoading.value = false,
      };
    }).catchError((onError) {
      print(onError.toString());
      notiIsLoading.value = false;
    });
  }

  Future deleteNotification(List<String> ids) async {
    dioHelper.deleteData(url: 'notifications',query: {
      "ads": ids
    }).then((value) {
      return {
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
        getNotification()
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

  Future markNotificationAsRead() async {
    dioHelper.putData(url: 'notifications',data: {
      "ids": notiId
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
              }
          }
        else
          {
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
            getNotification(),
            getUnreadNotificationCount(),
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

  @override
  void onInit() {
    getUnreadNotificationCount();
    super.onInit();
  }
}
