import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:libozzle/Logics/app_logic/app_controller.dart';
import 'package:libozzle/Logics/profile_logic/models/my_ad.dart';
import 'package:libozzle/Logics/profile_logic/profile_controller.dart';
import 'package:libozzle/Screens/NewAd/package_screen.dart';
import 'package:libozzle/Screens/components/components.dart';
import 'package:libozzle/Screens/profile/editMyAds/my_ad_details.dart';
import 'package:libozzle/all_controllers.dart';
import 'package:libozzle/assets/flaticon_icons.dart';
import 'package:libozzle/shared/components/constans.dart';
import 'package:libozzle/shared/components/varibales_combonents.dart';
import 'package:libozzle/shared/styles/colors.dart';

import '../ad_screen.dart';
import '../no_internet.dart';

class MyAds extends StatefulWidget {
  @override
  _MyAdsState createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  var profileController = Get.find<ProfileController>();
  var appController = Get.find<AppController>();
  var allController = Get.find<ALlControllers>();
  ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        profileController.getMoreAds();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Ads'),
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(builder: (controller) {
        if (allController.stateIs != 200) {
          return Center(child: connectionState(allController.stateIs.value));
        }
        if (controller.myAdsData.isEmpty || controller.myAdsData == []) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FlatIcon.empty_folder,
                  color: Colors.black54,
                  size: 100,
                ),
                Text(
                  'There is no data to show',
                  style: TextStyle(fontSize: 22, color: Colors.black54),
                )
              ],
            ),
          );
        }
        return Directionality(
          textDirection: lang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  if (controller.isLoading.value)
                    return const LinearProgressIndicator(
                      color: darkGrayDefaultColor,
                      backgroundColor: Colors.white,
                    );
                  return SizedBox();;
                }),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        adItem(data: controller.myAdsData[index]),
                    separatorBuilder: (context, index) => Container(
                          height: 10,
                          color: Colors.grey.shade200,
                        ),
                    itemCount: controller.myAdsData.length),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget adItem({required MyAdsData data}) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 420),
      child: InkWell(
        onTap: () {
          appController.getAdDetails(
              taxonomy: data.taxonomy.slug.toString(),
              category: data.category.slug.toString(),
              id: data.id.toString());
          Get.to(const AdScreen(),
              curve: Curves.bounceOut,
              transition: Transition.cupertinoDialog,
              duration: const Duration(milliseconds: 1000));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Stack(
                alignment:
                    lang == 'ar' ? Alignment.bottomLeft : Alignment.bottomRight,
                children: [
                  postForm(data: data),
                  IconButton(
                      onPressed: () {
                        dialog([
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Are you Sure to delete this ad ?',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20, color: redDefaultColor),
                            ),
                          ),
                          Obx(() {
                            if (profileController.isLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Row(
                              children: [
                                Expanded(
                                    child: button('No', null,
                                        clr: Colors.black87, onPress: () {
                                  Get.back();
                                })),
                                Expanded(
                                    child: button('Yes', null,
                                        color: redDefaultColor,
                                        clr: Colors.white, onPress: () {
                                  profileController.deleteUserAd(data.id);
                                })),
                              ],
                            );
                          })
                        ]);
                      },
                      icon: Icon(
                        FlatIcon.delete,
                        color: Colors.black,
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  color: data.isPublished ? Color(0xff3EDC04) : Colors.red,
                  thickness: 4,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: button(
                          lang == 'ar' ? 'تعديل' : 'Edit', FlatIcon.edit,
                          color: redDefaultColor,
                          clr: Colors.white, onPress: () {
                    editAd.clear();
                    appController
                        .getAdDetails(
                            taxonomy: data.taxonomy.slug.toString(),
                            category: data.category.slug.toString(),
                            id: data.id)
                        .then((value) => Get.to(MyAdDetails()));
                  })),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: button(
                          data.isPublished
                              ? lang == 'ar'
                                  ? 'إيقاف'
                                  : 'Post off'
                              : lang == 'ar'
                                  ? 'تفعيل'
                                  : 'Post on',
                          data.isPublished ? FlatIcon.bell : FlatIcon.bell_ring,
                          onPress: () {
                    profileController.publishUnPublishAd(data.id);
                  })),
                  const SizedBox(
                    width: 4,
                  ),
                  if (data.isExpired == false && data.remainingRefreshes != 0)
                    Expanded(
                        child: button(lang == 'ar' ? 'تحديث' : 'Refresh',
                            FlatIcon.refresh, clr: blackDefaultColor,
                            onPress: () {
                      dialog([
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Remaining renewal times in the Package ${data.remainingRefreshes}',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 20, color: redDefaultColor),
                          ),
                        ),
                        Obx(() {
                          if (profileController.isLoading.value) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Row(
                            children: [
                              Expanded(
                                  child: button('No', null, clr: Colors.black87,
                                      onPress: () {
                                Get.back();
                              })),
                              Expanded(
                                  child: button('Yes', null,
                                      color: redDefaultColor,
                                      clr: Colors.white, onPress: () {
                                profileController.refreshUserAd(data.id);
                              })),
                            ],
                          );
                        })
                      ]);
                    })),
                  if (data.isExpired == false && data.remainingRefreshes == 0)
                    Expanded(
                        child: button(lang == 'ar' ? 'إعادة نشر' : 'Repost',
                            FlatIcon.retweet,
                            color: blackDefaultColor,
                            clr: Colors.white, onPress: () {
                      Get.to(PackageScreen(
                        imageList: null,
                        isNew: false,
                        adId: data.id,
                      ));
                    })),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
