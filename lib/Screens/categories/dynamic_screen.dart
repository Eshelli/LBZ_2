import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:libozzle/Logics/app_logic/app_controller.dart';
import 'package:libozzle/Screens/NewAd/post_details.dart';
import 'package:libozzle/Screens/ads_list.dart';
import 'package:libozzle/Screens/categories/model/categories_model.dart';
import 'package:libozzle/all_controllers.dart';
import 'package:libozzle/shared/components/constans.dart';
import 'package:libozzle/shared/components/varibales_combonents.dart';

import '../no_internet.dart';

class DynamicScreen extends StatelessWidget {
  final List<Category> catList;
  final bool isFilter;
  String catName;
  String catSlug;

  DynamicScreen({
    required this.catList,
    required this.catName,
    required this.catSlug,
    required this.isFilter,
  });

  var appController = Get.find<AppController>();
  var allController = Get.find<ALlControllers>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: newAd != true ? Text(catName) : null,
        elevation: newAd != true ? 5 : 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Obx((){
        if(appController.appData.isLoading.value){
          return const Center(child: CircularProgressIndicator(),);
        }
        if (allController.stateIs != 200) {
          return Center(child: connectionState(allController.stateIs.value));
        }
        return SingleChildScrollView(
          child: Directionality(
            textDirection: lang == 'ar'?TextDirection.rtl : TextDirection.ltr,
            child: Column(
              children:
              [
                if (newAd == true)
                  Text(
                    'What are you Listing?',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                if (newAd == true)
                  Text(
                    'Choose the Category That your Ad Fits Into.',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                if (newAd == false)
                  ListTile(
                    leading: Text('${lang == 'ar'? 'الكل في ' : 'All in'} $catName'),
                    onTap: () {
                      filter.clear();
                      if (taxonomySlug != catSlug) {
                        categorySlug = catSlug;
                        category = catName;
                      } else {
                        categorySlug = null;
                        category = null;
                      }
                      appController.getAds(
                          taxonomy: taxonomySlug, category: categorySlug,attb: {});
                      Get.to(AdsList());
                    },
                  ),
                if (newAd == false)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      width: double.infinity,
                      color: Colors.grey.shade300,
                      height: 1,
                    ),
                  ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => catItem(context, catList[index]),
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      color: Colors.grey.shade300,
                      height: 1,
                    ),
                  ),
                  itemCount: catList.length,
                ),
              ],
            ),
          ),
        );
      })
    );
  }

  Widget catItem(context, Category cat) {
    var appController = Get.put(AppController());
    return ListTile(
      leading: Text(
        cat.name.toString(),
      ),
      onTap: () {
        if (cat.categories.isEmpty) {
          categorySlug = cat.slug;
          category = cat.name;
          filter.clear();
          if (newAd != true) {
              appController.getAds(taxonomy: taxonomySlug, category: categorySlug,attb: {});
              Get.to(AdsList());
          } else {
            if (categorySlug != null) {
              appController.getAttributes(category: categorySlug).then((value) {
                Get.to(PostDetails());
              });
            }
          }
      }
        if (cat.categories.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DynamicScreen(
                catList: cat.categories,
                isFilter: isFilter,
                catSlug: cat.slug.toString(),
                catName: cat.name.toString(),
              ),
            ),
          );
        }
      },
    );
  }
}
