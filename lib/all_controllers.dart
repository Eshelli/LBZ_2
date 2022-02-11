import 'package:get/get.dart';
import 'package:libozzle/Logics/fav_logic/fav_controller.dart';
import 'package:libozzle/Logics/login_register_logic/login_register_controller.dart';
import 'package:libozzle/Logics/notification_logic/notification_controller.dart';
import 'package:libozzle/Logics/profile_logic/profile_controller.dart';
import 'Logics/app_logic/app_controller.dart';
import 'Logics/chat_logic/chat_controller.dart';

class ALlControllers implements Bindings{
  var stateIs = 0.obs;
  var search = false.obs;
  @override
  void dependencies() {
    Get.lazyPut(() => AppController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => ChatController());
    Get.put(NotificationController());
    Get.put(LoginRegisterController());
    Get.put(FavController());
  }
}