import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/Logics/profile_logic/profile_controller.dart';
import 'package:lbz/Screens/components/search_item.dart';
import 'package:lbz/Screens/home/profile.dart';
import 'package:lbz/assets/flaticon_icons.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/styles/colors.dart';

import '../../all_controllers.dart';
import '../no_internet.dart';

class SaveSearch extends StatefulWidget {
  @override
  State<SaveSearch> createState() => _SaveSearchState();
}

class _SaveSearchState extends State<SaveSearch> {
  ScrollController _scrollController = ScrollController();
  var profileController = Get.find<ProfileController>();
  var allController = Get.find<ALlControllers>();

  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Get.find<ProfileController>().getMoreSearch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Saved'),
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(builder: (controller) {
        if (allController.stateIs != 200) {
          return Center(child: connectionState(allController.stateIs.value));
        }
        if (controller.dataSearch.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Icon(FlatIcon.empty_folder,color: Colors.black54,size: 100,),
                Text('There is no data to show',style: TextStyle(fontSize: 22,color: Colors.black54),)
              ],
            ),
          );
        }
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          child: Directionality(
            textDirection: lang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            child: Column(
              children: [
                if (profileController.isLoading.value)
                  const LinearProgressIndicator(
                    color: darkGrayDefaultColor,
                    backgroundColor: Colors.white,
                  ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SearchItem(
                      search: controller.dataSearch[index],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: controller.dataSearch.length,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
