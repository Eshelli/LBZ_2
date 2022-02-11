import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/Logics/profile_logic/profile_controller.dart';

import '../components/components.dart';

class NewAd extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70.0,right: 10,left: 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
          [
            Text('What are you Listing?',style: Theme.of(context).textTheme.subtitle1,),
            Text('Choose the Category That your Ad Fits Into.',style: Theme.of(context).textTheme.subtitle2,),
            homeGridview(true),
          ],
          ),
        ),
      ),
    );
  }
}
