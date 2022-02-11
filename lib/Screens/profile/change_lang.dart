import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/Screens/components/components.dart';
import 'package:lbz/Screens/home_screen.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/network/local/cache_helper.dart';

class ChangeLang extends StatefulWidget {
  const ChangeLang({Key? key}) : super(key: key);

  @override
  _ChangeLangState createState() => _ChangeLangState();
}

class _ChangeLangState extends State<ChangeLang> {
  @override
  Widget build(BuildContext context) {
    var appController = Get.find<AppController>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Container(
            height: 50,
            child: button('English', Icons.language,color: Colors.black45,clr: Colors.white,onPress: (){
              CacheHelper.saveData(key: 'lang', value: 'en');
              lang = 'en';
              appController.tokenCheck();
              Get.offAll(HomeScreen());
            }),
          ),
          SizedBox(height: 10,),
          Container(
            height: 50,
            child: button('عربي', Icons.language,color: Colors.black45,clr: Colors.white,onPress: (){
              CacheHelper.saveData(key: 'lang', value: 'ar');
              lang = 'ar';
              appController.tokenCheck();
              Get.offAll(HomeScreen());
            }),
          ),
        ],),
      ),
    );
  }
}
