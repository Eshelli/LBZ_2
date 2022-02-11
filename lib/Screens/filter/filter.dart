import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/Screens/components/components.dart';
import 'package:lbz/Screens/filter/components/filter_text.dart';
import 'package:lbz/assets/flaticon_icons.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/components/varibales_combonents.dart';
import 'package:lbz/shared/styles/colors.dart';
import 'components/filter_check.dart';

class Filter extends StatelessWidget {
  var priceFrom = TextEditingController();
  var priceTo = TextEditingController();
  var city = TextEditingController();
  var keywords = TextEditingController();
  @override
  StatelessElement createElement() {
    // TODO: implement createElement
    reset();
    return super.createElement();
  }
  @override
  Widget build(BuildContext context) {
    var appController = Get.find<AppController>();
    var size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        actions: [
          TextButton(
              onPressed: () {
                reset();
              },
              child: const Text('Reset'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GetBuilder<AppController>(
              //   builder: (controller) {
              //     var appData = controller.appData;
              //     if (appData.categoryIsLoading.value)
              //       return CircularProgressIndicator();
              //     return Column(
              //       children: [
              //         ListTile(
              //           leading: Text(
              //             appData.categoryParent.parent != null
              //                 ? appData.categoryParent.parent!.name
              //                 : category ?? 'All in $taxonomy',
              //             style: Theme.of(context).textTheme.subtitle2,
              //           ),
              //           trailing: const Icon(
              //             Icons.arrow_right,
              //             size: 30,
              //           ),
              //           onTap: () {
              //             controller.getCategoryChildren2(
              //               category: appData.categoryParent.parent != null
              //                   ? appData.categoryParent.parent!.slug
              //                   : categorySlug ?? taxonomySlug,
              //             );
              //             Get.to(DynamicScreen2(
              //               catName: appData.categoryParent.parent != null
              //                   ? appData.categoryParent.parent!.name
              //                   : category ?? taxonomy,
              //               catSlug: appData.categoryParent.parent != null
              //                   ? appData.categoryParent.parent!.slug
              //                   : categorySlug ?? taxonomySlug,
              //             ));
              //           },
              //         ),
              //         if (appData.categoryParent.parent != null) Divider(),
              //         if (appData.categoryParent.parent != null)
              //           ListTile(
              //             leading: Text(
              //               appData.categoryParent.name.toString(),
              //               style: Theme.of(context).textTheme.subtitle2,
              //             ),
              //             trailing: const Icon(
              //               Icons.arrow_right,
              //               size: 30,
              //             ),
              //             onTap: () {
              //               controller.getCategoryChildren2(category: appData.categoryParent.parent!.slug,);
              //               Get.to(DynamicScreen2(
              //                 catName: appData.categoryParent.parent!.name.toString(),
              //                 catSlug: appData.categoryParent.parent!.slug.toString(),
              //               ));
              //             },
              //           ),
              //         if (appData.categoryChildren.isNotEmpty) Divider(),
              //         if (appData.categoryChildren.isNotEmpty)
              //           ListTile(
              //             leading: Text(
              //               'All in $category',
              //               style: Theme.of(context).textTheme.subtitle2,
              //             ),
              //             trailing: const Icon(
              //               Icons.arrow_right,
              //               size: 30,
              //             ),
              //             onTap: () {
              //               controller.getCategoryChildren2(category: category,);
              //               Get.to(DynamicScreen2(
              //                 catName: category,
              //                 catSlug: categorySlug,
              //               ));
              //             },
              //           ),
              //       ],
              //     );
              //   },
              // ),
              // const Divider(),
              // ListTile(
              //   leading: Text(
              //     'All Cities',
              //     style: Theme
              //         .of(context)
              //         .textTheme
              //         .subtitle2,
              //   ),
              //   trailing: const Icon(
              //     Icons.arrow_right,
              //     size: 30,
              //   ),
              // ),
              const Divider(),
              ListTile(
                  leading: Text(
                    'Price (AED)',
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle2,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: size.width * .45,
                    child: defualtTextForm(context, controler: priceFrom, type: TextInputType.number,label: 'Price from', radius: 5),
                  ),
                  SizedBox(
                    height: 50,
                    width: size.width * .45,
                    child: defualtTextForm(context, controler: priceTo, type: TextInputType.number,label: 'Price to', radius: 5),
                  ),
                ],
              ),
              // ListTile(
              //     leading: Text(
              //       'City',
              //       style: Theme
              //           .of(context)
              //           .textTheme
              //           .subtitle2,
              //     )),
              // Center(
              //   child: SizedBox(
              //     width: size.width * .93,
              //     child: defualtTextForm(context, controler: city, type: TextInputType.text,label: 'City', radius: 5),
              //   ),
              // ),
              ListTile(
                  leading: Text(
                    'Keyword',
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle2,
                  )),
              Center(
                child: SizedBox(
                  height: 50,
                  width: size.width * .93,
                  child: defualtTextForm(context, controler: keywords, type: TextInputType.text,label: 'Keyword', radius: 5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: GetBuilder<AppController>(builder: (controller) {
                  var attributes = controller.appData.attributes;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index1) {
                      if (filter.keys.contains(
                          "attribute_${attributes[index1].id}") == false) {
                        filter.addIf(attributes[index1].type != 'text',
                            "attribute_${attributes[index1].id}", []);
                        filter.addIf(attributes[index1].type == 'text',
                            "attribute_${attributes[index1].id}", "");
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            attributes[index1].name.toString(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle2,
                          ),
                          if (attributes[index1].type != 'text')
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3.5,
                              ),
                              itemBuilder: (context, index) {
                                // attributes[index1].options![index].name
                                // List<dynamic> list = filter.entries.firstWhere((
                                //     element) {
                                //   return element.key ==
                                //       'attribute_${attributes[index1].id}';
                                // }).value;
                                // list.forEach((element) {
                                //   print(element);
                                //   print(element == 'odit');
                                // });
                                return FilterCheck(
                                  text: attributes[index1]
                                      .options![index]
                                      .name
                                      .toString(),
                                  id: attributes[index1].id!.toInt(),
                                );
                              },
                              itemCount: attributes[index1].options!.length,
                            ),
                          if (attributes[index1].type == 'text')
                            FilterText(id: attributes[index1].id!.toInt())
                        ],
                      );
                    },
                    itemCount: attributes.length,
                    separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                  );
                }),
              ),
              button('Show result', FlatIcon.filter,color: redDefaultColor,clr: Colors.white,onPress: (){
                print(filter);
                print(categorySlug);
                appController.getAds(taxonomy: taxonomySlug,category: categorySlug,city: city.text,keywords: keywords.text,priceTo: priceTo.text,priceFrom: priceFrom.text,attb: {});
                Get.back();
              }),
            ],
          ),
        ),
      ),
    );
  }
  void reset(){
    priceFrom.text = filter.keys.contains("price_from") ? filter.entries
        .firstWhere((element) => element.key == "price_from")
        .value.toString() : '';
    priceTo.text = filter.keys.contains("price_to") ? filter.entries
        .firstWhere((element) => element.key == "price_to")
        .value.toString() :
        '';

    city.text = filter.keys.contains("city") ? filter.entries
        .firstWhere((element) => element.key == "city")
        .value :
        '';
    keywords.text =  filter.keys.contains("keywords") ? filter.entries
        .firstWhere((element) => element.key == "keywords")
        .value :
        '';
  }
}
