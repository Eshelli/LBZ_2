import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/Screens/categories/model/categories_model.dart';
import 'package:lbz/Screens/home/chat_users.dart';
import 'package:lbz/Screens/home/fav.dart';
import 'package:lbz/Screens/home/home_page.dart';
import 'package:lbz/Screens/home/new_ad.dart';
import 'package:lbz/Screens/home/profile.dart';
import 'package:libozzle/Screens/home_screen.dart';
import 'package:libozzle/models/ad_details.dart';
import 'package:libozzle/models/ads_list.dart';
import 'package:libozzle/models/attributes.dart';
import 'package:libozzle/models/cat.dart';
import 'package:libozzle/models/cat_parent.dart';
import 'package:libozzle/models/cities.dart';
import 'package:libozzle/models/countries.dart';
import 'package:libozzle/models/login_status.dart';
import 'package:libozzle/models/package.dart';
import 'package:libozzle/models/popular_ads.dart';
import 'package:libozzle/models/section_model.dart';
import 'package:libozzle/shared/components/constans.dart';
import 'package:libozzle/shared/components/varibales_combonents.dart';
import 'package:libozzle/shared/network/local/cache_helper.dart';
import 'package:libozzle/shared/network/remote/contacts.dart';
import 'package:libozzle/shared/network/remote/dio_helper.dart';

import '../../all_controllers.dart';
import 'app_data.dart';

class AppController extends GetxController {
  var appData = AppData();
  var currentIndex = 0.obs;
  var stateIs = 0.obs;
  var allController = Get.find<ALlControllers>();
  List<String> notiId = [];
  var checkTokenIsLoading = false.obs;
  List<Widget> screen = [
    HomePage(),
    FavForm(),
    NewAd(),
    ChatUsers(),
    Profile()
  ];
  Future getSection() async {
    appData.isLoading.value = true;
    appData.section = [];
    dioHelper.getData(url: 'taxonomies').then((value)async {
      return {
        value.data.forEach((element) {
          appData.section.add(Sections.fromJson(element));
        }),
        update(),
        appData.noConnection.value = false,
        appData.isLoading.value = false,
        await getPop(),
      };
    }).catchError((onError) {
      print(onError.toString());
      if (onError is DioError) {
        print(onError);
        checkTokenIsLoading.value = false;
        stateIs.value = 0;
        appData.isLoading.value = false;

      }
    });
  }

  Future getCategories(String section) async {
    appData.isLoading.value = true;
    dialog([
      const Center(child: CircularProgressIndicator())
    ]);
    await dioHelper.getData(url: 'taxonomies/$section').then((value) {
      return {
        print(value.data.toString()),
        appData.sectionCat = Section.fromJson(value.data),
        update(),
        appData.isLoading.value = false,
      };
    }).catchError((onError) {
      print(onError.toString());
      appData.isLoading.value = false;
      update();
    });
  }

  Future getPop() async {
    appData.popIsLoading.value = true;
    appData.pop = [];
    dioHelper.getData(url: 'taxonomies/popular-ads').then((value) {
      return {
        value.data.forEach((element) {
          appData.pop.add(Pop.fromJson(element));
        }),
        update(),
        appData.noConnection.value = false,
        appData.popIsLoading.value = false,
      };
    }).catchError((onError) {
      print(onError.toString());
      if (onError is DioError) {
        print(onError);
        appData.popIsLoading.value = false;
        checkTokenIsLoading.value = false;
        stateIs.value = 0;
      }
    });
  }


  void getAds(
      {String? taxonomy, String? category, priceFrom, priceTo,city,sortKey,sortType, keywords,Map<String,dynamic>? attb}) {
    appData.adsIsLoading.value = true;
    allController.search.value = false;
    appData.adsList = [];
    appData.adsListData = [];
    Map<String,dynamic> map = {};
    map.addAll(filter);
    map.forEach((key1, value) {
      if(key1.startsWith('attribute_')){
        if(value.isEmpty){
          filter.remove(key1);
        }
      }
    });
    filter.addIf(taxonomy != null, "taxonomy", taxonomy);
    filter.addIf(category != null, "category", category);
    filter.addIf(priceFrom != null, "price_from", priceFrom);
    filter.addIf(priceTo != null, "price_to", priceTo);
    filter.addIf(city != null, "city", city);
    filter.addIf(true, "sort_key", sortKey);
    filter.addIf(true, "sort_type", sortType);
    filter.addIf(keywords != null, "keywords", keywords);
    filter.addAllIf(attb != null, attb!);
    dioHelper.getData(url: ads, query: filter).then((value) {
      return {
        appData.adsList.add(Ads_List.fromJson(value.data)),
        value.data["data"].forEach((element){
          appData.adsListData.add(DataList.fromJson(element));
        }),
        appData.attributes = [],
        if (category != null) getAttributes(category: category),
        update(),
        appData.adsIsLoading.value = false,
      };
    });
  }

  void getMoreAds(){
    var next;
    if(appData.adsList.last.meta!.currentPage < appData.adsList.last.meta!.lastPage!.toInt()){
      next = appData.adsList.last.meta!.currentPage + 1;
    filter.addIf(true, "page", next);
    print(filter);
    dioHelper.getData(url: ads,query: filter).then((value) {
      return {
        appData.adsList.add(Ads_List.fromJson(value.data)),
        print(value.data["meta"]),
        value.data["data"].forEach((element){
          appData.adsListData.add(DataList.fromJson(element));
        }),
        update()
      };
    });
  }
  }
  Future getAdDetails(
      {required String taxonomy,
      required String category,
      required String id}) async {
    appData.adsDetailsLoading.value = true;
    await dioHelper.getData(
        url: 'taxonomies/$taxonomy/categories/$category/posts/$id',).then((value) {
      return
        {
        print(value.data),
        appData.adsDetails = AdDetails.fromJson(value.data),
        getAttributes(taxonomy: taxonomy,category: category),
        print(appData.adsDetails.id),
        print(appData.attributes),
        update(),
        appData.adsDetailsLoading.value = false,
        };
    }).catchError((onError){
      print(onError);
      appData.adsDetailsLoading.value = false;
    });
  }

  Future getAttributes({String? taxonomy, String? category}) async {
    appData.attributes = [];
    await dioHelper.getData(url: 'categories/$category/attributes').then((value) {
      value.data.forEach((element) {
        appData.attributes.add(Attribute.fromJson(element));
      });
      update();
    });
  }
 //فصل الاسماء
  Future getCategoryChildren({String? category}) async {
    appData.categoryIsLoading.value = true;
    appData.categoryChildren = [];
    DioHelper().getData(url: 'categories/$category/children').then((value) {
      value.data.forEach((element) {
        appData.categoryChildren.add(Cat.fromJson(element));
      });
      getCategoryParent(category: category);
    });
  }

  Future getCategoryParent({String? category}) async {
    DioHelper().getData(url: 'categories/$category/parents-list').then((value) {
      appData.categoryParent = CategoryParent.fromJson(value.data);
      update();
      appData.categoryIsLoading.value = false;
    });
  }

  Future getCategoryChildren2({String? category}) async {
    appData.categoryIsLoading.value = true;
    appData.categoryChildren2 = [];
    DioHelper().getData(url: 'categories/$category/children').then((value) {
      value.data.forEach((element) {
        appData.categoryChildren2.add(Cat.fromJson(element));
      });
      update();
      appData.categoryIsLoading.value = false;
    }).catchError((error) {
      appData.categoryIsLoading.value = false;
    });
  }

  Future getCountries() async {
    appData.countries = [];
    dioHelper.getData(url: 'countries').then((value) {
      value.data.forEach((element) {
        appData.countries.add(Countries.fromJson(element));
      });
      update();
    }).catchError((onError){
      print(onError);
      checkTokenIsLoading.value = false;
      stateIs.value = 0;
    });
  }


  Future getCities() async {
    appData.cities = [];
    dioHelper.getData(url: 'cities').then((value) {
      value.data.forEach((element) {
        appData.cities.add(Cities.fromJson(element));
      });
      update();
    }).catchError((onError){
      print(onError);
      checkTokenIsLoading.value = false;
      stateIs.value = 0;
    });
  }

  Future getPackages() async {
    appData.listPackages = [];
    dioHelper.getData(url: 'packages').then((value) {
      value.data.forEach((element) {
        appData.listPackages.add(NewPackage.fromJson(element));
      });
      update();
    }).catchError((onError){
      print(onError);
      checkTokenIsLoading.value = false;
      stateIs.value = 0;
    });
  }

  Future getBalance() async {
    appData.balance.value = 0.00;
    dioHelper.getData(url: 'wallet').then((value){
      appData.balance.value = value.data['balance'].toDouble();
      update();
    }).catchError((onError)
    {
      print(onError);
      Get.offAll(HomeScreen());
      checkTokenIsLoading.value = false;
      stateIs.value = 0;
    });
  }

  void tokenCheck() async {
    checkTokenIsLoading.value = true;
    stateIs.value = 1;
    DioHelper.dio.get(
      'is-logged-in',
      options: Options(
        validateStatus: (status) {
          if (status != null) {
            stateIs.value = status;
          }
          return status! < 500;
        },
        headers: {
          Headers.contentTypeHeader: "application/json",
          Headers.acceptHeader: "application/json",
          "Authorization": "Bearer ${token.toString()}"
        },
      ),
    ).then((value)async {
      appData.loginState = LoginStatus.fromJson(value.data);
      await getCountries();
      await getCities();
      await getSection();
      if(appData.loginState.loggedIn == false){
        CacheHelper.removeData(key: 'token');
        token = null;
      }else{
        await getPackages();
        await getBalance();
      }
      checkTokenIsLoading.value = false;
      update();
    }).catchError((onError) {
      print(onError);
      checkTokenIsLoading.value = false;
      stateIs.value = 0;
    });
  }

  @override
  void onInit() {
    tokenCheck();
    super.onInit();
  }

  @override
  void onClose() {
    super.dispose();
  }
}
