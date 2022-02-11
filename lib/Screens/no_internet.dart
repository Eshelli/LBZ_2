import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/styles/colors.dart';

Widget noInternet(onTap){
  var appController = Get.find<AppController>();
  return Obx(() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
      [
        const Icon(Icons.error, color: redDefaultColor, size: 40,),
        const Text('Please Check Your Internet'),
        if(appController.appData.connectionIsLoading.value)
          const Center(child: CircularProgressIndicator(),),
        if(!appController.appData.connectionIsLoading.value)
          MaterialButton(onPressed: onTap,
            child: const Text(
              'Try again', style: TextStyle(color: Colors.white),),
            color: redDefaultColor,),
      ],
    );
  }
  );
}


Widget connectionState(int state,{Color clr = Colors.black,double size = 15}){
  if(state == 401){
    return Text('الرجاء تسجيل الدخول',style: TextStyle(color: clr),);
  }
  if(state == 404){
    return const Image(image:  AssetImage('assets/image/error404.png'));
  }
  if(state == 403){
    return const Image(image: AssetImage('assets/image/error403.png'));
  }
  if(state == 422){
    return Text('خطا في البيانات',style: TextStyle(color: clr),);
  }
  if(state == 0){
    return Text(lang == 'ar'?'لا يوجد اتصال بالانترنت': 'No internet connection found!',style: TextStyle(color: clr,fontSize: size),);
  }
  if(state == 500 ) {
    return const Image(image: AssetImage('assets/image/error500.png'));
  }
  return Text('خطا',style: TextStyle(color: clr),);
}
