
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/Logics/profile_logic/models/my_fav.dart';
import 'package:lbz/Screens/login/main_login_screen.dart';
import 'package:lbz/all_controllers.dart';
import 'package:lbz/commen_models/errors_models.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/network/remote/contacts.dart';

class FavController extends GetxController {
  var isLoading = false.obs;
  List<MyFavList> favList = [];
  List<MyFavData> favListData = [];
  late MessageError msg;
  var appController = Get.find<AppController>();
  var allController = Get.find<ALlControllers>();

  void getFav() async {
    isLoading.value = true;
    favList = [];
    favListData = [];
    allController.stateIs.value = 0;
    await dioHelper
        .getData(
      url: favorites,
    )
        .then((value) {
      print(value.data);
      favList.add(MyFavList.fromJson(value.data));
      value.data["data"].forEach((element) {
        favListData.add(MyFavData.fromJson(element));
      });
      update();
      isLoading.value = false;
    }).catchError((e) async {
      print(e);
      isLoading.value = false;
      if (allController.stateIs == 401) {
        appController.currentIndex.value = 0;
        await Get.to(const MainLoginScreen(),
            curve: Curves.easeInOut,
            transition: Transition.cupertinoDialog,
            duration: const Duration(milliseconds: 500));
      }
    });
  }

  void getMoreAds() {
    var next;
    if (favList.last.meta!.currentPage < favList.last.meta!.lastPage!.toInt()) {
      next = favList.last.meta!.currentPage + 1;
      print(next);
      dioHelper.getData(url: favorites, query: {"page": next}).then((value) {
        return {
          favList.add(MyFavList.fromJson(value.data)),
          value.data["data"].forEach((element) {
            favListData.add(MyFavData.fromJson(element));
          }),
          update()
        };
      }).catchError((onError){print(onError);});
    }
  }

  void addToFav(String ad, tax, cat) async {
    isLoading.value = true;
    allController.stateIs.value = 0;
    print('hh');
    print(ad);
    await dioHelper.putData(url: '$favorites/$ad').then((value) {
      print(value.data);
      if (value.statusCode != 200) {
        msg = MessageError.fromJson(value.data);

        if (msg.errors != null) {
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
          });
        } else {
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
          );
        }
      } else {
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
        );
        getFav();
      }
      isLoading.value = false;
      appController.getAdDetails(taxonomy: tax, category: cat, id: ad);
      update();
    }).catchError((e) async {
      print(e);
      isLoading.value = false;
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
  }
}
