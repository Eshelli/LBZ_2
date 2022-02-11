import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:group_button/group_button.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/Screens/NewAd/post_details.dart';
import 'package:lbz/Screens/components/shimmers.dart';
import 'package:lbz/assets/flaticon_icons.dart';
import 'package:lbz/models/attributes.dart';
import 'package:lbz/models/package.dart';
import 'package:lbz/models/section_model.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/components/varibales_combonents.dart';
import 'package:lbz/shared/network/remote/contacts.dart';
import 'package:lbz/shared/styles/colors.dart';

import '../ads_list.dart';
import '../categories/dynamic_screen.dart';
import 'form_of_list.dart';

Widget postForm({required dynamic data}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: Alignment(-0.9, -0.9),
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: FormOfList(
              images: data.images,
            ),
          ),
          if (data.package != null)
            Container(
              constraints: const BoxConstraints(minWidth: 30, minHeight: 25),
              decoration: BoxDecoration(
                  color: Color(int.parse(
                      data.package.color.replaceFirst('#', '0xff').toString())),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: Text(
                  data.package.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: FittedBox(
              child: Text(
                data.price.toString(),
                style: const TextStyle(color: redDefaultColor, fontSize: 36),
              ),
            ),
          ),
          Flexible(
            child: FittedBox(
              child: Text(
                data.date.toString(),
                style:
                    const TextStyle(color: darkGrayDefaultColor, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      Text(
        data.title.toString(),
        style: const TextStyle(fontSize: 24, color: blackDefaultColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      if (data.attributes.isNotEmpty)
        SizedBox(
          height: 30,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: data.attributes.length,
            itemBuilder: (context, index) {
              IconData flatIcon = icon.entries
                  .firstWhere((element) =>
                      element.key == data.attributes[index].atb.icon.toString())
                  .value;
              return Row(
                children: [
                  Icon(
                    flatIcon,
                    size: 25,
                    color: redDefaultColor,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    data.attributes[index].value.toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 15,
            ),
          ),
        ),
      Row(
        children: [
          const Icon(
            Icons.location_on,
            size: 18,
            color: lightBlackDefaultColor,
          ),
          Text(
            data.location.toString(),
            style: const TextStyle(color: lightBlackDefaultColor),
          ),
        ],
      ),
    ],
  );
}

Widget homeGridview(bool newAd) {
  return GetBuilder<AppController>(
    builder: (controller) {
      var section = controller.appData.section;
      if (section.isEmpty || controller.appData.isLoading.value) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: .9,
          ),
          itemBuilder: (context, index) {
            return shimmerGridItem();
          },
          itemCount: 8,
        );
      }
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: .9),
        itemBuilder: (context, index) {
          IconData flatIcon = icon.entries
              .firstWhere((element) => element.key == section[index].icon)
              .value;
          return homeGridItem(newAd ? true : false, section[index], flatIcon,
              section[index].name.toString(), index);
        },
        itemCount: section.length,
      );
    },
  );
}

Widget homeGridItem(
    bool newPost, Sections section, IconData icon, String text, int index) {
  var appController = Get.find<AppController>();
  return InkWell(
    onTap: () async {
      sectionIndex = index;
      taxonomySlug = section.slug;
      taxonomy = section.name;
      categorySlug = null;
      category = null;
      if (section.categories.isEmpty) {
        newAd = newPost;
        filter.clear();
        appController.getAds(taxonomy: taxonomySlug, attb: {});
        newPost ? Get.to(PostDetails()) : Get.to(AdsList());
      }
      if (section.categories.isNotEmpty) {
        newAd = newPost;
        await appController.getCategories(section.slug.toString());
        Get.back();
        Get.to(
            () => DynamicScreen(
                  catList: appController.appData.sectionCat.categories,
                  catSlug: section.slug.toString(),
                  catName: section.name.toString(),
                  isFilter: false,
                ),
            curve: Curves.bounceOut,
            transition: Transition.cupertinoDialog,
            duration: const Duration(milliseconds: 600));
      }
    },
    splashColor: Colors.red,
    borderRadius: BorderRadius.circular(12),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
          ),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 19,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget button(String text, IconData? icon,
    {MainAxisAlignment axis = MainAxisAlignment.center,
    double fontSize = 18,
    Color clr = redDefaultColor,
    Color color = Colors.white,
    onPress}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 4),
    child: MaterialButton(
      onPressed: onPress,
      splashColor: clr,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: clr)),
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Flexible(
              flex: 1,
              child: Icon(
                icon,
                color: clr,
                size: 20,
              ),
            ),
          Flexible(
              flex: 1,
              child: FittedBox(
                  child: Text(
                text,
                style: TextStyle(fontSize: fontSize, color: clr),
                maxLines: 1,
                overflow: TextOverflow.fade,
              ))),
        ],
      ),
    ),
  );
}

Widget group(List<Option>? list, id) {
  List<String> names = [];
  list!.forEach((element) {
    names.add(element.name.toString());
  });
  return Center(
    child: GroupButton.radio(
      buttons: names,
      selectedColor: redDefaultColor,
      alignment: Alignment.center,
      onSelected: (index) {
        filter.update('attribute_${id}[value]', (value) {
          return names[index];
        });
        print(filter);
      },
    ),
  );
}

