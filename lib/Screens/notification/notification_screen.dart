import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/Logics/notification_logic/notification_controller.dart';
import 'package:lbz/Screens/notification/components/noti_item.dart';
import 'package:lbz/assets/flaticon_icons.dart';
import 'package:lbz/shared/components/varibales_combonents.dart';
import 'package:lbz/shared/styles/colors.dart';

import '../../all_controllers.dart';
import '../no_internet.dart';

class NotificationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Get.find<NotificationController>().getNotification();
    var notiController = Get.find<NotificationController>();
    var allController = Get.find<ALlControllers>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notifications'),
        centerTitle: true,
        actions: [
          TextButton(onPressed: (){
            if(notiController.notiId.isEmpty){
              dialog([
                const Center(child: Text('الرجاء تحديد اشعارات'))
              ]);
            }else{
              notiController.markNotificationAsRead();
            }
          }, child: Icon(Icons.remove_red_eye,color: Colors.black,))
        ],
      ),
      body: Obx(() {
        if (notiController.notiIsLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (allController.stateIs != 200) {
          return Center(child: connectionState(allController.stateIs.value));
        }
        if(notiController.notification.data.isEmpty){
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
        return ListView.separated(
            itemBuilder: (context, index) => NotiItem(data: notiController.notification.data[index],),
            separatorBuilder: (context, index) => Divider(height: 1,),
            itemCount: notiController.notification.data.length);
      }),
    );
  }
}
