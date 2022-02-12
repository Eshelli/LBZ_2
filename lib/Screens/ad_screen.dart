import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/Logics/chat_logic/chat_controller.dart';
import 'package:lbz/Logics/fav_logic/fav_controller.dart';
import 'package:lbz/assets/flaticon_icons.dart';
import 'package:lbz/models/ads_list.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/components/varibales_combonents.dart';
import 'package:lbz/shared/network/remote/contacts.dart';
import 'package:lbz/shared/styles/colors.dart';

import 'chat/chat_screen.dart';

class AdScreen extends StatefulWidget {
  const AdScreen({Key? key}) : super(key: key);

  @override
  State<AdScreen> createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {
  var appController = Get.find<AppController>();
  var chatController = Get.find<ChatController>();
  bool more = false;
  bool isHidden = true;
  bool show = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var favController = Get.find<FavController>();
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<AppController>(
        builder: (controller) {
          if (controller.appData.adsDetailsLoading.value == true) {
            return const Center(child: CircularProgressIndicator());
          }
          var adsDetails = appController.appData.adsDetails;
          bool isFav = adsDetails.isFav ?? false;
          return SingleChildScrollView(
            child: Directionality(
              textDirection: lang == 'ar'?TextDirection.rtl : TextDirection.ltr,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 300,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Align(
                          child: CarouselSlider(
                            items: adsDetails.images
                                .map((e) => InteractiveViewer(
                                  child: Image.network(
                                    e.url.toString(),
                                    fit: BoxFit.contain,
                                    errorBuilder:(context, error, stackTrace) {
                                      return Image.asset('assets/image/lbz.png');
                                    },
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if(loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(child: CircularProgressIndicator(value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded/loadingProgress.expectedTotalBytes!:null,),);
                                    },
                                    height: 280,
                                  ),
                                ))
                                .toList(),
                            options: CarouselOptions(
                              height: 280,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              autoPlay: false,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (adsDetails.isFav != null)
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  color: Colors.grey.shade100,
                                  child: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              isFav = !isFav;
                                            });
                                            print(isFav);
                                            favController.addToFav(
                                                adsDetails.id.toString(),
                                                adsDetails.taxonomy!.slug,
                                                adsDetails.category!.slug);
                                          },
                                          borderRadius: BorderRadius.circular(30),
                                          splashColor: Colors.grey.shade400,
                                          child: Icon(
                                            FlatIcon.like,
                                            color:
                                                isFav ? Colors.red : Colors.grey,
                                            size: 35,
                                          ))),
                                ),
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                color: Colors.grey.shade100,
                                child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(30),
                                      splashColor: Colors.grey.shade400,
                                      child: const Icon(
                                        FlatIcon.share,
                                        color: Colors.grey,
                                        size: 35,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          adsDetails.price.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: redDefaultColor, fontSize: 28),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          adsDetails.title.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontSize: 25),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (adsDetails.attributes.length > 1) const Divider(),
                        if (adsDetails.attributes.length > 1)
                          Text(
                            lang == 'ar'? 'ملخص':'Overview',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        if (adsDetails.attributes.length > 1)
                          SizedBox(
                              height: 150,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    if (adsDetails.attributes[index].atb.icon ==
                                        null) {
                                      return const SizedBox(
                                        width: 0,
                                      );
                                    }
                                    IconData flatIcon = icon.entries
                                        .firstWhere((element) =>
                                            element.key ==
                                            adsDetails.attributes[index].atb.icon)
                                        .value;
                                    return catListItem(
                                        flatIcon, adsDetails.attributes[index]);
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: 5,
                                      ),
                                  itemCount: adsDetails.attributes.length)),
                        const Divider(),
                        if (adsDetails.attributes.length > 1)
                          Text(
                            lang == 'ar'? 'تفاصيل':'Details',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        if (adsDetails.attributes.length > 1)
                          ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  catItem(adsDetails.attributes[index]),
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: more
                                  ? (isHidden ? 5 : adsDetails.attributes.length)
                                  : adsDetails.attributes.length),
                        if (more && isHidden)
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  isHidden = !isHidden;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.arrow_drop_down,
                                      size: 30, color: Colors.red),
                                  Text(
                                    'Show details',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              )),
                        if (more && !isHidden)
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  isHidden = !isHidden;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.arrow_drop_up,
                                      size: 30, color: Colors.red),
                                  Text(
                                    'hide details',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              )),
                        Text(
                          lang == 'ar'? 'الوصف':'Description',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              adsDetails.description.toString(),
                              maxLines: 200,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const Divider(),
                        Text(
                          lang == 'ar'? 'الموقع':'Location',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          adsDetails.location.toString(),
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                          child: Image.network(
                            'https://assets.website-files.com/5e832e12eb7ca02ee9064d42/5f7db426b676b95755fb2844_Group%20805.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const Divider(),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Text(
                                          adsDetails.user!.name.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Card(
                                          elevation: 4,
                                          clipBehavior: Clip.antiAlias,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Image.network(
                                            adsDetails.user!.avatar.url.toString(),
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                            width: 100,
                                            height: 100,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            button('Call', FlatIcon.phone_call,
                color1: redDefaultColor, color2: Colors.white),
            button('Chat', FlatIcon.message,onPress: (){
              chatController.getChatId(appController.appData.adsDetails.user!.id,context);
            }),
          ],
        ),
      ),
    );
  }

  Widget catListItem(IconData icon, Attributes data) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.red,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 150,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  data.atb.name.toString(),
                  style: const TextStyle(
                    fontSize: 19,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                icon,
                size: 50,
              ),
              Flexible(
                child: Text(
                  data.value.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button(String text, IconData icon,
      {Color color1 = Colors.white, Color color2 = redDefaultColor,onPress}) {
    return OutlinedButton.icon(
      onPressed: onPress,
      icon: Icon(icon, size: 30, color: color2),
      style: OutlinedButton.styleFrom(
          backgroundColor: color1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          side: const BorderSide(color: Colors.red),
          fixedSize: const Size(150, 50)),
      label: Text(
        text,
        style: TextStyle(color: color2, fontSize: 25),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget catItem(Attributes data) {
    return ListTile(
      leading: Text(
        data.atb.name.toString(),
        style: const TextStyle(fontSize: 16),
      ),
      trailing: Text(
        data.value.toString(),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
