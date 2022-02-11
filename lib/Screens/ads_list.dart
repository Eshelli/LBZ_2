import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:libozzle/Logics/app_logic/app_controller.dart';
import 'package:libozzle/Logics/profile_logic/profile_controller.dart';
import 'package:libozzle/Screens/components/components.dart';
import 'package:libozzle/Screens/components/shimmers.dart';
import 'package:libozzle/Screens/filter/filter.dart';
import 'package:libozzle/assets/flaticon_icons.dart';
import 'package:libozzle/models/ads_list.dart';
import 'package:libozzle/models/cat_parent.dart';
import 'package:libozzle/shared/components/constans.dart';
import 'package:libozzle/shared/components/varibales_combonents.dart';
import 'package:libozzle/shared/styles/colors.dart';

import 'ad_screen.dart';

class AdsList extends StatefulWidget {
  @override
  State<AdsList> createState() => _AdsListState();
}

class _AdsListState extends State<AdsList> {
  var appController = Get.find<AppController>();

  var profileController = Get.find<ProfileController>();

  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  ScrollController _scrollController =ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        appController.getMoreAds();
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: TextFormField(
          cursorRadius: const Radius.circular(30),
          readOnly: true,
          style: const TextStyle(
            fontSize: 19,
          ),
          decoration: const InputDecoration(
            hintText: '    Enter Neighborhood or Building',
            hintStyle: TextStyle(color: darkGrayDefaultColor),
            alignLabelWithHint: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: darkGrayDefaultColor)),
            contentPadding: EdgeInsets.zero,
            fillColor: grayDefaultColor,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(54),
          child: Row(
            children: [
              Expanded(
                  child: appBarButton('Save Search', FlatIcon.bookmark, () {
                dialog([
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'please enter a title!',
                        style: Theme.of(context).textTheme.subtitle1!,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Form(
                        key: formKey,
                        child: defualtTextForm(context,
                            controler: titleController,
                            type: TextInputType.text, validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your title';
                          }
                          return null;
                        }, radius: 3)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      child: Text(
                        'you want to be notified when new ads match your search',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 19),
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 4),
                        child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              profileController.postSearch(titleController.text, false);
                            }
                          },
                          splashColor: redDefaultColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: redDefaultColor)),
                          child: const Text('I\'am ok',
                              style: TextStyle(fontSize: 18)),
                        ),
                      )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 4, right: 10),
                        child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              profileController.postSearch(titleController.text, true);
                            }
                          },
                          splashColor: Colors.white.withOpacity(.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: redDefaultColor,
                          child: const Text(
                            'get notified',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ))
                    ],
                  )
                ]);
              })),
              Container(
                color: blackDefaultColor,
                width: 1,
                height: 30,
              ),
              Expanded(
                  child: appBarButton('Filter', FlatIcon.filter, () {
                appController.appData.categoryChildren.clear();
                appController.appData.categoryParent =
                    CategoryParent.fromJson({});
                if (categorySlug != null) {
                  appController.getCategoryChildren(category: categorySlug);
                }
                Get.to(Filter());
              })),
              Container(
                color: blackDefaultColor,
                width: 1,
                height: 30,
              ),
              Expanded(
                  child: appBarButton('Sort', FlatIcon.sort, () {
                dialog(
                  [
                    SimpleDialogOption(
                      child: const Center(child: Text('Newest to Oldest')),
                      onPressed: () {
                        appController.getAds(
                            sortKey: "date", sortType: "desc", attb: {});
                        Get.back();
                      },
                    ),
                    const Divider(
                      height: 5,
                    ),
                    SimpleDialogOption(
                      child: const Center(child: Text('Oldest to new Newest')),
                      onPressed: () {
                        appController
                            .getAds(sortKey: "date", sortType: "asc", attb: {});
                        Get.back();
                      },
                    ),
                    const Divider(
                      height: 5,
                    ),
                    SimpleDialogOption(
                      child:
                          const Center(child: Text('Price Highest to Lowest')),
                      onPressed: () {
                        appController.getAds(
                            sortKey: "price", sortType: "desc", attb: {});
                        Get.back();
                      },
                    ),
                    const Divider(
                      height: 5,
                    ),
                    SimpleDialogOption(
                      child:
                          const Center(child: Text('Price Lowest to Highest')),
                      onPressed: () {
                        appController.getAds(
                            sortKey: "price", sortType: "asc", attb: {});
                        Get.back();
                      },
                    ),
                  ],
                );
              })),
            ],
          ),
        ),
      ),
      body:  Obx(() {
        if (appController.appData.adsIsLoading.value) {
          return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => shimmerPostForm(),
              separatorBuilder: (context, index) => Container(
                height: 10,
                color: Colors.grey.shade200,
              ),
              itemCount: 3);
        }
        return GetBuilder<AppController>(
          builder: (controller) {
            if (appController.appData.adsList == []) {
              return const Center(
                  child:
                  Image(image: AssetImage('assets/image/sorry.gif')));
            }
            return Directionality(
              textDirection: lang == 'ar'?TextDirection.rtl : TextDirection.ltr,
              child: ListView.separated(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index1) {
                    if(index1 == appController.appData.adsListData.length +1){
                      return const CupertinoActivityIndicator();
                    }
                    return adItem(data: controller.appData.adsListData[index1]);
                  },
                  separatorBuilder: (context, index1) => Container(
                    height: 10,
                    color: Colors.grey.shade200,
                  ),
                  itemCount: controller.appData.adsListData.length),
            );
          },
        );
      }),
    );
  }

  Widget adItem({required DataList data}) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 420),
      child: InkWell(
        onTap: () {
          appController.getAdDetails(
              taxonomy: data.taxonomy!.slug.toString(),
              category: data.category!.slug.toString(),
              id: data.id.toString());
          Get.to(const AdScreen(),
              curve: Curves.bounceOut,
              transition: Transition.cupertinoDialog,
              duration: const Duration(milliseconds: 1000));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postForm(data: data),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 41,
                      width: 100,
                      child: Image.network(
                        data.user!.avatar.url.toString(),
                        width: 100,
                        fit: BoxFit.contain,
                        height: 41,
                      ),
                    ),
                  ),
                  Expanded(child: button('Chat', FlatIcon.message)),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(child: button('Call', Icons.phone)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button(String text, IconData icon) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 30, color: redDefaultColor),
      style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          side: const BorderSide(color: redDefaultColor),
          fixedSize: const Size(106, 41)),
      label: Text(
        text,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget appBarButton(String text, IconData icon, onTap) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 30, color: blackDefaultColor),
      style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          side: BorderSide.none),
      label: Text(
        text,
        style: const TextStyle(color: blackDefaultColor),
      ),
    );
  }
}
