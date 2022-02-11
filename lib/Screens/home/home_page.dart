import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:libozzle/Logics/app_logic/app_controller.dart';
import 'package:libozzle/Logics/notification_logic/notification_controller.dart';
import 'package:libozzle/Screens/components/form_of_list.dart';
import 'package:libozzle/Screens/components/shimmers.dart';
import 'package:libozzle/Screens/notification/notification_screen.dart';
import 'package:libozzle/all_controllers.dart';
import 'package:libozzle/assets/flaticon_icons.dart';
import 'package:libozzle/models/popular_ads.dart';
import 'package:libozzle/models/section_model.dart';
import 'package:libozzle/shared/components/constans.dart';
import 'package:libozzle/shared/components/varibales_combonents.dart';
import 'package:libozzle/shared/styles/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../ad_screen.dart';
import '../ads_list.dart';
import '../components/components.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  var txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var allController = Get.find<ALlControllers>();
    var notificationController = Get.find<NotificationController>();
    allController.search.value = false;
    txtController.text = '';
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          floating: true,
          elevation: 0,
          centerTitle: true,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 5),
            child: Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 45,
                  child: defualtTextForm(context,
                      controler: txtController,
                      label: 'Search on the Ad',
                      type: TextInputType.text,
                      radius: 10, onChanged: (txt) {
                    if (txt.isNotEmpty) {
                      allController.search.value = true;
                    }
                    if (txt.isEmpty) {
                      allController.search.value = false;
                    }
                  }),
                )),
                TextButton(
                  onPressed: () {
                    Get.to(NotificationScreen());
                  },
                  child: Badge(
                    badgeContent: Obx((){
                      return Text(
                          notificationController.unreadCount.value.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      );
                    }),
                    child: const Icon(
                      FlatIcon.alarm_bell,
                      color: darkGrayDefaultColor,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
      body: Obx(() {
        if (allController.search.value == false) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Directionality(
                textDirection:
                    lang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                child: Column(
                  crossAxisAlignment: lang == 'ar'
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    homeGridview(false),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                          color: redDefaultColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.anchor,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Ad space',
                            style: TextStyle(fontSize: 40, color: Colors.white),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.anchor,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<AppController>(
                      builder: (controller) {
                        var pop = controller.appData.pop;
                        if (controller.appData.popIsLoading.value) {
                          return ListView.separated(
                            itemBuilder: (context, index1) {
                              return Column(
                                crossAxisAlignment: lang == 'ar'
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 15),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[400]!,
                                      highlightColor: Colors.grey[300]!,
                                      child: Text('Popular in',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 208,
                                    child: ListView.separated(
                                      itemBuilder: (context, index2) =>
                                          shimmerListItem(),
                                      separatorBuilder: (context, index2) =>
                                          const SizedBox(
                                        width: 10,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: 5,
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          );
                        }
                        return ListView.separated(
                          itemBuilder: (context, index1) {
                            if (pop[index1].popularAds.isEmpty) {
                              return const SizedBox(
                                height: 0,
                                width: 0,
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Text(
                                      lang == 'ar'
                                          ? 'الاشهر في ${pop[index1].name}'
                                          : 'Popular in ${pop[index1].name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ),
                                SizedBox(
                                  height: 208,
                                  child: ListView.separated(
                                    itemBuilder: (context, index2) {
                                      if (pop[index1].popularAds.isNotEmpty) {
                                        return catListItem(
                                            pop[index1].popularAds[index2],
                                            context);
                                      }
                                      return Container();
                                    },
                                    separatorBuilder: (context, index2) =>
                                        const SizedBox(
                                      width: 10,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: pop[index1].popularAds.isEmpty
                                        ? 10
                                        : pop[index1].popularAds.length,
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemCount: pop.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return searchScreen();
      }),
    );
  }

  Widget searchScreen() {
    var appController = Get.find<AppController>();
    return GetBuilder<AppController>(
      builder: (controller) {
        var section = controller.appData.section;
        if (section.isEmpty || controller.appData.isLoading.value) {
          return CircularProgressIndicator();
        }
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => catItem(context, section[index]),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              color: Colors.grey.shade300,
              height: 1,
            ),
          ),
          itemCount: appController.appData.section.length,
        );
      },
    );
    ;
  }

  Widget catItem(context, Sections sections) {
    var appController = Get.put(AppController());
    return ListTile(
      onTap: () {
        filter.clear();
        taxonomySlug = sections.slug;
        taxonomy = sections.name;
        categorySlug = null;
        category = null;
        appController.getAds(
            taxonomy: sections.slug, keywords: txtController.text, attb: {});
        Get.to(AdsList());
      },
      trailing: Text(
        sections.name.toString(),
      ),
    );
  }

  Widget catListItem(PopularAds popAds, context) {
    var appController = Get.put(AppController());
    var size = MediaQuery.of(context).textScaleFactor;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: () {
          appController.getAdDetails(
              taxonomy: popAds.taxonomy.slug.toString(),
              category: popAds.category.slug.toString(),
              id: popAds.id.toString());
          Get.to(
            AdScreen(),
            curve: Curves.easeInCirc,
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 350),
          );
        },
        child: SizedBox(
          width: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  flex: size == null
                      ? 5
                      : size > 1.5
                          ? 3
                          : 5,
                  child: FormOfList(images: popAds.images)),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '${popAds.price}',
                    style: const TextStyle(
                      color: redDefaultColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '${popAds.title}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '${popAds.location}',
                    style: const TextStyle(
                      color: Colors.black12,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
