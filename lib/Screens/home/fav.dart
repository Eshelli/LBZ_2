import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/Logics/fav_logic/fav_controller.dart';
import 'package:lbz/Logics/profile_logic/models/my_fav.dart';
import 'package:lbz/Screens/components/components.dart';
import 'package:lbz/Screens/no_internet.dart';
import 'package:lbz/all_controllers.dart';
import 'package:lbz/assets/flaticon_icons.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/styles/colors.dart';


class FavForm extends StatefulWidget {
  @override
  State<FavForm> createState() => _FavFormState();
}

class _FavFormState extends State<FavForm> {
  ScrollController _scrollController =ScrollController();
  var favController = Get.find<FavController>();

  @override
  void initState() {
    Get.find<FavController>().getFav();
    super.initState();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        favController.getMoreAds();
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    var favController = Get.find<FavController>();
    var allController = Get.find<ALlControllers>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: Obx(()
      {
        if (favController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (allController.stateIs != 200) {
          return Center(child: connectionState(allController.stateIs.value));
        }
        return GetBuilder<FavController>(
          builder: (controller) {
            if (controller.favListData == [] || controller.favListData.isEmpty) {
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
              textDirection: lang == 'ar'?TextDirection.rtl : TextDirection.ltr,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if(index == controller.favListData.length){
                      return const CupertinoActivityIndicator();
                    }
                    return adItem(context, data: controller.favListData[index]);
                  },
                  separatorBuilder: (context, index) => Container(
                    height: 10,
                    color: Colors.grey.shade200,
                  ),
                  itemCount: controller.favListData.length),
            );
          },
        );
      }
      ),
    );
  }

  Widget adItem(context, {required MyFavData data}) {
    var appController = Get.find<AppController>();
    var favController = Get.find<FavController>();
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 300,
      ),
      child: InkWell(
        onTap: () {
          appController.getAdDetails(
              taxonomy: data.taxonomy!.slug.toString(),
              category: data.category!.slug.toString(),
              id: data.id.toString());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Stack(
            alignment: lang == 'ar' ?Alignment.bottomLeft: Alignment.bottomRight,
            children: [
              Column(
                crossAxisAlignment:  CrossAxisAlignment.start,
                children:
                [
                  postForm(data: data),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(),
                  ),
                ],
              ),
              IconButton(
                  onPressed: ()
                  {
                    favController.addToFav(data.id.toString(), data.taxonomy!.slug, data.category!.slug);
                  },
                  icon: const Icon(
                    FlatIcon.delete,
                    color: blackDefaultColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
