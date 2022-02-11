import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/Screens/no_internet.dart';
import 'package:lbz/assets/flaticon_icons.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/components/methods.dart';
import 'package:lbz/shared/components/varibales_combonents.dart';
import 'package:lbz/shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appController = Get.find<AppController>();
    var size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return Scaffold(
      body: Obx(() {
        if(appController.checkTokenIsLoading.value){
          return Center(child: const CircularProgressIndicator());
        }
        if (appController.stateIs.value == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Icon(Icons.wifi_off_rounded,color: darkGrayDefaultColor,size: 120,)),
              Center(child: connectionState(appController.stateIs.value,clr: darkGrayDefaultColor,size: 22)),
              TextButton(
                onPressed: () {
                  appController.tokenCheck();
                },
                child: Text(lang == 'ar'? 'إعادة المحاولة':'Try again',style: TextStyle(color: redDefaultColor,fontSize: 19),),

              )
            ],
          );
        }
        return appController.screen[appController.currentIndex.value];
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: appController.currentIndex.value,
            type: BottomNavigationBarType.fixed,
            fixedColor: blackDefaultColor,
            unselectedItemColor: darkGrayDefaultColor,
            iconSize: 25,
            items:  [
              BottomNavigationBarItem(icon: Icon(FlatIcon.home), label: lang == 'ar'? 'الرئيسية':'Home'),
              BottomNavigationBarItem(
                  icon: Icon(FlatIcon.favorite), label: lang == 'ar'? 'المفضلة':'Favorite'),
              BottomNavigationBarItem(
                icon: Icon(
                  FlatIcon.plus_sign_in_a_black_circle,
                  color: redDefaultColor,
                ),
                label: lang == 'ar'? 'إضافة إعلان':'Add an Ad',
              ),
              BottomNavigationBarItem(
                  icon: Icon(FlatIcon.message), label: lang == 'ar'? 'المحادثة':'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(FlatIcon.user), label: lang == 'ar'? 'الملف الشخصي':'Profile'),
            ],
            onTap: (value) {
              appController.currentIndex.value = value;
            },
          )),
    );
  }
}
