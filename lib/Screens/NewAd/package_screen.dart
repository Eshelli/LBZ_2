import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libozzle/Logics/app_logic/app_controller.dart';
import 'package:libozzle/Logics/profile_logic/profile_controller.dart';
import 'package:libozzle/Screens/components/components.dart';
import 'package:libozzle/assets/flaticon_icons.dart';
import 'package:libozzle/models/package.dart';
import 'package:libozzle/shared/components/constans.dart';
import 'package:libozzle/shared/components/varibales_combonents.dart';
import 'package:libozzle/shared/styles/colors.dart';

import '../home_screen.dart';

class PackageScreen extends StatelessWidget {
  dynamic imageList;
  final bool isNew;
  dynamic adId;

  PackageScreen(
      {Key? key,
      required this.imageList,
      required this.isNew,
      required this.adId})
      : super(key: key);
  var appController = Get.find<AppController>();
  var profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Choose the Package',
              style: TextStyle(fontSize: 35),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'You must choose a package to complete the advertisement publishing process',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade500),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: 300,
                child: buttonUserForm(
                    '${lang == 'ar' ? 'رصيدك' : 'Your balance'} : ${appController.appData.balance}\$',
                    FlatIcon.wallet,
                    Colors.grey.shade200,
                    size: 40,
                    onPress: () {}),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              height: 330,
              child: ListView.separated(
                separatorBuilder: (context, index2) => const SizedBox(
                  width: 10,
                ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    package(appController.appData.listPackages[index]),
                itemCount: appController.appData.listPackages.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget package(NewPackage data) {
    double rest = appController.appData.balance.value - data.price;
    return Stack(
      alignment: Alignment(0.9, -0.95),
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          clipBehavior: Clip.antiAlias,
          color: redDefaultColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data.name,
                        style: TextStyle(fontSize: 30, color: redDefaultColor),
                      ),
                    ),
                    Text(
                      'Featured days',
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        data.featuredDays.toString(),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Text(
                      'Active days',
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        data.activeDays.toString(),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Text(
                      'Refreshes',
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        data.numberOfRefreshes.toString(),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Text(
                      '${data.price}\$',
                      style: TextStyle(fontSize: 30, color: redDefaultColor),
                    ),
                    SizedBox(
                        width: 130,
                        height: 40,
                        child: button('Subscribe Now', null,
                            color: redDefaultColor,
                            clr: Colors.white, onPress: () {
                          dialog([
                            Text(
                              'The value in the wallet is not enough to purchase rhe Excellence package',
                              style: TextStyle(
                                  color: redDefaultColor, fontSize: 24),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            ListTile(
                              leading: Text(
                                'Wallet balance:',
                                style: TextStyle(fontSize: 19),
                              ),
                              trailing: Text(
                                  '${appController.appData.balance}\$',
                                  style: TextStyle(fontSize: 19)),
                            ),
                            Divider(),
                            ListTile(
                              leading: Text(
                                'Package price:',
                                style: TextStyle(fontSize: 19),
                              ),
                              trailing: Text('${data.price}\$',
                                  style: TextStyle(fontSize: 19)),
                            ),
                            Divider(),
                            ListTile(
                              leading: Text(
                                'The rest:',
                                style: TextStyle(fontSize: 19),
                              ),
                              trailing: Text(
                                  '${appController.appData.balance.value - data.price}\$',
                                  style: TextStyle(fontSize: 19)),
                            ),
                            Obx(() {
                              if (profileController.isLoading.value) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (rest < 0)
                                return Row(
                                  children: [
                                    Flexible(
                                        flex: 1,
                                        child: button('Fill wallet', null,
                                            clr: Colors.white,
                                            color: Colors.black54,
                                            onPress: () {})),
                                    Flexible(
                                        flex: 1,
                                        child: button('cancel', null,
                                            clr: Colors.white,
                                            color: redDefaultColor,
                                            onPress: () {
                                          Get.back();
                                        })),
                                  ],
                                );
                              return button('Yes', null,
                                  clr: Colors.white,
                                  color: redDefaultColor, onPress: () {
                                if (isNew) {
                                  profileController
                                      .createUserAd(data.id, imageList)
                                      .whenComplete(() {
                                    Get.back();
                                    appController.getBalance();
                                  });
                                }
                                if (isNew == false) {
                                  profileController
                                      .repostUserAd(adId, data.id)
                                      .whenComplete(() {
                                    appController.getBalance();
                                  });
                                }
                              });
                            })
                          ]);
                        })),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Icon(
          FlatIcon.bookmark,
          color:
              Color(int.parse(data.color.replaceFirst('#', '0xff').toString())),
        )
      ],
    );
  }
}
