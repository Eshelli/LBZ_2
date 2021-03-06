
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/Logics/profile_logic/profile_controller.dart';
import 'package:lbz/Screens/components/go_login.dart';
import 'package:lbz/Screens/login/login_screen.dart';
import 'package:lbz/Screens/login/main_login_screen.dart';
import 'package:lbz/Screens/profile/change_lang.dart';
import 'package:lbz/Screens/profile/my_account.dart';
import 'package:lbz/Screens/profile/my_ads.dart';
import 'package:lbz/Screens/profile/saved_search.dart';
import 'package:lbz/all_controllers.dart';
import 'package:lbz/assets/flaticon_icons.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/network/local/cache_helper.dart';
import 'package:lbz/shared/styles/colors.dart';

import '../no_internet.dart';

class Profile extends StatelessWidget {
  var profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    var appController = Get.find<AppController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        elevation: 3,
      ),
      body: SingleChildScrollView(
        child: Obx((){
          return Directionality(
            textDirection: lang == 'ar'?TextDirection.rtl : TextDirection.ltr,
            child: Column(
              children: [
                if(profileController.isLoading.value)
                  const LinearProgressIndicator(
                    color: darkGrayDefaultColor,
                    backgroundColor: Colors.white,
                  ),
                const SizedBox(
                  height: 10,
                ),
                const CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/image/libuzzle_logo.png'),
                ),
                if (appController.appData.loginState.loggedIn)
                  listButton(lang == 'ar'? '??????????':'My Account', FlatIcon.user_1, () {
                    profileController.getUserData();
                  }),
                if (appController.appData.loginState.loggedIn == false)
                  listButton(lang == 'ar'? '?????????? ????????':'Create Account', Icons.app_registration_outlined,
                      () {
                    Get.to(const MainLoginScreen());
                  }),

                const Divider(),
                listButton(lang == 'ar'? '????????????????':'My Ads', FlatIcon.advertisement, () {
                  profileController.getMyAds(true);
                }),
                const Divider(),
                listButton(lang == 'ar'? '???????????? ??????????????':'My Saved Searches', FlatIcon.save_instagram, () {
                  profileController.getSavedSearch();
                }),
                const Divider(),
                listButton(lang == 'ar'? '??????????':'Support', FlatIcon.customer_support, () {}),
                const Divider(),
                listButton(lang == 'ar'? '??????????':'Language', FlatIcon.language, () {
                  Get.to(ChangeLang());
                }),
                const Divider(),
                listButton(lang == 'ar'? '?????????? ????????':'Log Out', FlatIcon.log_out, () {}),
                const Divider(),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget listButton(String text, IconData icon, onTap) {
    return ListTile(
      title: Text(text),
      leading: Icon(
        icon,
        size: 30,
        color: Colors.black,
      ),
      onTap: onTap,
    );
  }
}
