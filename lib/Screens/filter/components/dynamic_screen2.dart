import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/models/cat.dart';
import 'package:lbz/shared/components/varibales_combonents.dart';

class DynamicScreen2 extends StatelessWidget {
  String catName;
  String catSlug;
  DynamicScreen2({
    required this.catName,
    required this.catSlug,
  });
  var appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: newAd != true ?Text(catName): null,
        elevation: newAd != true ? 5:0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if(newAd == true)
              Text('What are you Listing?',style: Theme.of(context).textTheme.subtitle1,),
            if(newAd == true)
              Text('Choose the Category That your Ad Fits Into.',style: Theme.of(context).textTheme.subtitle2,),

            if(newAd == false)
              ListTile(
              leading: Text('All in $catName'),
              onTap: (){

              },
            ),
            if(newAd == false)
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                color: Colors.grey.shade300,
                height: 1,
              ),
            ),
            GetBuilder<AppController>(
              builder: (controller) {
                if(controller.appData.categoryIsLoading.value) {
                  return CircularProgressIndicator();
                }
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => catItem(context, controller.appData.categoryChildren2[index]),
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      color: Colors.grey.shade300,
                      height: 1,
                    ),
                  ),
                  itemCount: controller.appData.categoryChildren2.length,
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget catItem(context, Cat cat) {
    var appController = Get.put(AppController());
    return ListTile(
      leading: Text(
        cat.name.toString(),
      ),
      onTap: () {
        appController.getCategoryChildren(category: cat.slug);
        Get.back();
      },
    );
  }
}
