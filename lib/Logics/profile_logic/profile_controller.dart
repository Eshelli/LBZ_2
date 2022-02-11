import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libozzle/Logics/app_logic/app_controller.dart';
import 'package:libozzle/Logics/profile_logic/models/user_data.dart';
import 'package:libozzle/Screens/home_screen.dart';
import 'package:libozzle/Screens/no_internet.dart';
import 'package:libozzle/Screens/profile/my_account.dart';
import 'package:libozzle/Screens/profile/my_ads.dart';
import 'package:libozzle/Screens/profile/saved_search.dart';
import 'package:libozzle/commen_models/errors_models.dart';
import 'package:libozzle/shared/components/constans.dart';
import '../../all_controllers.dart';
import 'models/my_ad.dart';
import 'models/search_model.dart';

class ProfileController extends GetxController {
  late UserData userDetails;
  List<MySearch> savedSearch = [];
  List<DataSearch> dataSearch = [];
  late MessageError msg;
  List<MyAdsList> myAds = [];
  List<MyAdsData> myAdsData = [];
  var isLoading = false.obs;
  var allController = Get.find<ALlControllers>();

  void getUserData() {
    isLoading.value = true;
    dioHelper.getData(url: "profile").then((value) {
      return {
        print(value.data),
        userDetails = UserData.fromJson(value.data),
        update(),
        Get.to(MyAccount()),
        isLoading.value = false,
      };
    }).catchError((onError) {
      print(onError.toString());
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
            Icons.error,
            color: Colors.white,
          )),
          messageText: Center(
              child: connectionState(allController.stateIs.value,
                  clr: Colors.white)),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    });
  }

  void updateUserData(
      String name, String phone, String country, String dob, String gender) {
    isLoading.value = true;
    dioHelper.putData(url: "profile", data: {
      "name": name,
      "phone_number": phone,
      "country_id": country,
      "dob": dob,
      "gender": gender,
    }).then((value) {
      if (value.statusCode != 200) {
        msg = MessageError.fromJson(value.data);
        if (msg.errors != null) {
          msg.errors!.forEach((key, value) {
            if (value is List) {
              value.forEach((value) {
                Get.snackbar(
                  '',
                  '',
                  titleText: const Center(
                      child: Icon(
                    Icons.warning,
                    color: Colors.white,
                  )),
                  messageText: Center(
                      child: Text(
                    value.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                  backgroundColor: Colors.orange,
                  snackPosition: SnackPosition.BOTTOM,
                );
              });
            } else {
              Get.snackbar(
                '',
                '',
                titleText: const Center(
                    child: Icon(
                  Icons.check,
                  color: Colors.white,
                )),
                messageText: Center(
                    child: Text(
                  value.toString(),
                  style: TextStyle(color: Colors.white),
                )),
                backgroundColor: Colors.green,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          });
        } else {
          Get.snackbar(
            '',
            '',
            titleText: const Center(
                child: Icon(
              Icons.warning,
              color: Colors.white,
            )),
            messageText: Center(
                child: Text(
              msg.message.toString(),
              style: TextStyle(color: Colors.white),
            )),
            backgroundColor: Colors.orange,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          '',
          '',
          titleText: const Center(
              child: Icon(
            Icons.check,
            color: Colors.white,
          )),
          messageText: const Center(
              child: Text(
            'تمت العملية بنجاح',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
        );
        getUserData();
      }
    }).catchError((onError) {
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
            Icons.error,
            color: Colors.white,
          )),
          messageText: const Center(
              child: Text(
            'حدث خطاء الرجاء إعادة المحاولة',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    });
  }

  void updateUserToCompany(
      String name,
      String des,
      String license,
      String field,
      String size,
      String phone,
      String web_link,
      String location) {
    isLoading.value = true;
    dioHelper.postData(url: "profile/company", data: {
      "name": name,
      "description": des,
      "license_number": license,
      "field": field,
      "size": size,
      "phone_number": phone,
      "website_link": web_link,
      "location": location,
    }).then((value) {
      if (value.statusCode != 200) {
        msg = MessageError.fromJson(value.data);
        if (msg.errors != null) {
          msg.errors!.forEach((key, value) {
            if (value is List) {
              value.forEach((value) {
                Get.snackbar(
                  '',
                  '',
                  titleText: const Center(
                      child: Icon(
                    Icons.warning,
                    color: Colors.white,
                  )),
                  messageText: Center(
                      child: Text(
                    value.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                  backgroundColor: Colors.orange,
                  snackPosition: SnackPosition.BOTTOM,
                );
              });
            } else {
              Get.snackbar(
                '',
                '',
                titleText: const Center(
                    child: Icon(
                  Icons.check,
                  color: Colors.white,
                )),
                messageText: Center(
                    child: Text(
                  value.toString(),
                  style: TextStyle(color: Colors.white),
                )),
                backgroundColor: Colors.green,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          });
        } else {
          Get.snackbar(
            '',
            '',
            titleText: const Center(
                child: Icon(
              Icons.warning,
              color: Colors.white,
            )),
            messageText: Center(
                child: Text(
              msg.message.toString(),
              style: TextStyle(color: Colors.white),
            )),
            backgroundColor: Colors.orange,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        isLoading.value = false;
      } else {
        Get.snackbar(
          '',
          '',
          titleText: const Center(
              child: Icon(
            Icons.check,
            color: Colors.white,
          )),
          messageText: const Center(
              child: Text(
            'تمت العملية بنجاح',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
        );
        getUserData();
      }
    }).catchError((onError) {
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
            Icons.error,
            color: Colors.white,
          )),
          messageText: const Center(
              child: Text(
            'حدث خطاء الرجاء إعادة المحاولة',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    });
  }

  Future<bool> insertBalance(amount, methodId) async {
    isLoading.value = true;
    await dioHelper.postData(
        url: 'wallet',
        data: {"amount": amount, "payment_method_id": methodId}).then((value) {
      if (value.statusCode != 200) {
        msg = MessageError.fromJson(value.data);
        if (msg.errors != null) {
          msg.errors!.forEach((key, value) {
            if (value is List) {
              value.forEach((value) {
                Get.snackbar(
                  '',
                  '',
                  titleText: const Center(
                      child: Icon(
                    Icons.warning,
                    color: Colors.white,
                  )),
                  messageText: Center(
                      child: Text(
                    value.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                  backgroundColor: Colors.orange,
                  snackPosition: SnackPosition.BOTTOM,
                );
              });
            } else {
              Get.snackbar(
                '',
                '',
                titleText: const Center(
                    child: Icon(
                  Icons.check,
                  color: Colors.white,
                )),
                messageText: Center(
                    child: Text(
                  value.toString(),
                  style: TextStyle(color: Colors.white),
                )),
                backgroundColor: Colors.green,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          });
        } else {
          Get.snackbar(
            '',
            '',
            titleText: const Center(
                child: Icon(
              Icons.warning,
              color: Colors.white,
            )),
            messageText: Center(
                child: Text(
              msg.message.toString(),
              style: TextStyle(color: Colors.white),
            )),
            backgroundColor: Colors.orange,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          '',
          '',
          titleText: const Center(
              child: Icon(
            Icons.check,
            color: Colors.white,
          )),
          messageText: const Center(
              child: Text(
            'تمت العملية بنجاح',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      isLoading.value = false;
    }).catchError((onError) {
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
            Icons.error,
            color: Colors.white,
          )),
          messageText: const Center(
              child: Text(
            'حدث خطاء الرجاء إعادة المحاولة',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    });
    return true;
  }

  void getMyAds(bool home) {
    isLoading.value = true;
    myAds = [];
    myAdsData = [];
    dioHelper.getData(url: "profile/posts").then((value) {
      return {
        print(value.data),
        myAds.add(MyAdsList.fromJson(value.data)),
        update(),
        value.data["data"].forEach((element) {
          myAdsData.add(MyAdsData.fromJson(element));
        }),
        isLoading.value = false,
        if(home == true)
          Get.to(MyAds())
      };
    }).catchError((onError) {
      print(onError);
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
            Icons.error,
            color: Colors.white,
          )),
          messageText: Center(
              child: connectionState(allController.stateIs.value,
                  clr: Colors.white)),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    });
  }

  void getMoreAds() {
    var next;
    print(next);
    if (myAds.last.meta.currentPage < myAds.last.meta.lastPage!.toInt()) {
      next = myAds.last.meta.currentPage + 1;
      print(next);
      dioHelper
          .getData(url: "profile/posts", query: {"page": next}).then((value) {
        return {
          myAds.add(MyAdsList.fromJson(value.data)),
          value.data["data"].forEach((element) {
            myAdsData.add(MyAdsData.fromJson(element));
          }),
          update()
        };
      }).catchError((onError) {
        print(onError);
      });
    }
  }

  void updatePassword(String oldPass, String newPass, String confirm) {
    isLoading.value = true;
    dioHelper.putData(url: "profile/update-password", data: {
      "old_password": oldPass,
      "password": newPass,
      "password_confirmation": confirm,
    }).then((value) {
      if (value.statusCode != 200) {
        msg = MessageError.fromJson(value.data);
        if (msg.errors != null) {
          msg.errors!.forEach((key, value) {
            if (value is List) {
              value.forEach((value) {
                Get.snackbar(
                  '',
                  '',
                  titleText: const Center(
                      child: Icon(
                    Icons.warning,
                    color: Colors.white,
                  )),
                  messageText: Center(
                      child: Text(
                    value.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                  backgroundColor: Colors.orange,
                  snackPosition: SnackPosition.BOTTOM,
                );
              });
            } else {
              Get.snackbar(
                '',
                '',
                titleText: const Center(
                    child: Icon(
                  Icons.check,
                  color: Colors.white,
                )),
                messageText: Center(
                    child: Text(
                  value.toString(),
                  style: TextStyle(color: Colors.white),
                )),
                backgroundColor: Colors.green,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          });
        } else {
          Get.snackbar(
            '',
            '',
            titleText: const Center(
                child: Icon(
              Icons.warning,
              color: Colors.white,
            )),
            messageText: Center(
                child: Text(
              msg.message.toString(),
              style: TextStyle(color: Colors.white),
            )),
            backgroundColor: Colors.orange,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.back();
        Get.snackbar(
          '',
          '',
          titleText: const Center(
              child: Icon(
            Icons.check,
            color: Colors.white,
          )),
          messageText: const Center(
              child: Text(
            'تمت العملية بنجاح',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      isLoading.value = false;
    }).catchError((onError) {
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
            Icons.error,
            color: Colors.white,
          )),
          messageText: const Center(
              child: Text(
            'حدث خطاء الرجاء إعادة المحاولة',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    });
  }

  void getSavedSearch() {
    isLoading.value = true;
    savedSearch = [];
    dataSearch = [];
    dioHelper.getData(url: "search").then((value) {
      return {
        print(value.data.toString()),
        savedSearch.add(MySearch.fromJson(value.data)),
        value.data["data"].forEach((element) {
          dataSearch.add(DataSearch.fromJson(element));
        }),
        update(),
        isLoading.value = false,
        Get.to(SaveSearch()),
        print(allController.stateIs.value),
      };
    }).catchError((onError) {
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
            Icons.error,
            color: Colors.white,
          )),
          messageText: Center(
              child: connectionState(allController.stateIs.value,
                  clr: Colors.white)),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      print(allController.stateIs.value);
      isLoading.value = false;
    });
  }

  void getMoreSearch() {
    var next;
    if (savedSearch.last.meta!.currentPage <
        savedSearch.last.meta!.lastPage!.toInt()) {
      next = savedSearch.last.meta!.currentPage + 1;
      print(next);
      dioHelper.getData(url: 'search', query: {"page": next}).then((value) {
        return {
          savedSearch.add(MySearch.fromJson(value.data)),
          value.data["data"].forEach((element) {
            dataSearch.add(DataSearch.fromJson(element));
          }),
          update()
        };
      }).catchError((onError) {
        print(onError);
      });
    }
  }

  void deleteSavedSearch(int id) {
    isLoading.value = true;
    dioHelper.deleteData(url: "search/$id").then((value) {
      return {
        if (value.statusCode != 200)
          {
            msg = MessageError.fromJson(value.data),
            if (msg.errors != null)
              {
                msg.errors!.forEach((key, value) {
                  if (value is List) {
                    value.forEach((value) {
                      Get.snackbar(
                        '',
                        '',
                        titleText: const Center(
                            child: Icon(
                          Icons.warning,
                          color: Colors.white,
                        )),
                        messageText: Center(
                            child: Text(
                          value.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                        backgroundColor: Colors.orange,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    });
                  } else {
                    Get.snackbar(
                      '',
                      '',
                      titleText: const Center(
                          child: Icon(
                        Icons.check,
                        color: Colors.white,
                      )),
                      messageText: Center(
                          child: Text(
                        value.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                }),
              }
            else
              {
                Get.snackbar(
                  '',
                  '',
                  titleText: const Center(
                      child: Icon(
                    Icons.warning,
                    color: Colors.white,
                  )),
                  messageText: Center(
                      child: Text(
                    msg.message.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                  backgroundColor: Colors.orange,
                  snackPosition: SnackPosition.BOTTOM,
                ),
              }
          }
        else
          {
            Get.snackbar(
              '',
              '',
              titleText: const Center(
                  child: Icon(
                Icons.check,
                color: Colors.white,
              )),
              messageText: const Center(
                  child: Text(
                'تمت العملية بنجاح',
                style: TextStyle(color: Colors.white),
              )),
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM,
            ),
            getSavedSearch(),
          },
      };
    }).catchError((onError) {
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
            Icons.error,
            color: Colors.white,
          )),
          messageText: Center(
              child: connectionState(allController.stateIs.value,
                  clr: Colors.white)),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    });
  }



  void postSearch(String title, bool notifiable) {
    isLoading.value = true;
    Map<String, dynamic> map = {};
    map.addAll(filter);
    map.addIf(true, 'title', title);
    map.remove("sort_key");
    map.removeWhere((key, value) => value == '');
    map.remove("sort_type");
    map.addIf(true, 'notifiable', notifiable);
    print(map);
    dioHelper.postData(url: "search", data: map).then((value) {
      return {
        print(value.data),
        if (value.statusCode != 200)
          {
            msg = MessageError.fromJson(value.data),
            if (msg.errors != null)
              {
                msg.errors!.forEach((key, value) {
                  if (value is List) {
                    value.forEach((value) {
                      Get.snackbar(
                        '',
                        '',
                        titleText: const Center(
                            child: Icon(
                          Icons.warning,
                          color: Colors.white,
                        )),
                        messageText: Center(
                            child: Text(
                          value.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                        backgroundColor: Colors.orange,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    });
                  } else {
                    Get.snackbar(
                      '',
                      '',
                      titleText: const Center(
                          child: Icon(
                        Icons.check,
                        color: Colors.white,
                      )),
                      messageText: Center(
                          child: Text(
                        value.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                }),
              }
            else
              {
                Get.snackbar(
                  '',
                  '',
                  titleText: const Center(
                      child: Icon(
                    Icons.warning,
                    color: Colors.white,
                  )),
                  messageText: Center(
                      child: Text(
                    msg.message.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                  backgroundColor: Colors.orange,
                  snackPosition: SnackPosition.BOTTOM,
                ),
              }
          }
        else
          {
            Get.back(),
            Get.snackbar(
              '',
              '',
              titleText: const Center(
                  child: Icon(
                Icons.check,
                color: Colors.white,
              )),
              messageText: const Center(
                  child: Text(
                'تمت العملية بنجاح',
                style: TextStyle(color: Colors.white),
              )),
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM,
            ),
          },
        isLoading.value = false,
      };
    }).catchError((onError) {
      print(onError.toString());
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
            Icons.error,
            color: Colors.white,
          )),
          messageText: const Center(
              child: Text(
            'حدث خطاء الرجاء إعادة المحاولة',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    });
  }

  void publishUnPublishAd(String ad) {
    isLoading.value = true;
    dioHelper.putData(url: "profile/posts/$ad/publish").then((value) {
      if (value.statusCode != 200) {
        msg = MessageError.fromJson(value.data);
        if (msg.errors != null) {
          msg.errors!.forEach((key, value) {
            if (value is List) {
              value.forEach((value) {
                Get.snackbar(
                  '',
                  '',
                  titleText: const Center(
                      child: Icon(
                    Icons.warning,
                    color: Colors.white,
                  )),
                  messageText: Center(
                      child: Text(
                    value.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                  backgroundColor: Colors.orange,
                  snackPosition: SnackPosition.BOTTOM,
                );
              });
            } else {
              Get.snackbar(
                '',
                '',
                titleText: const Center(
                    child: Icon(
                  Icons.check,
                  color: Colors.white,
                )),
                messageText: Center(
                    child: Text(
                  value.toString(),
                  style: TextStyle(color: Colors.white),
                )),
                backgroundColor: Colors.green,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          });
        } else {
          Get.snackbar(
            '',
            '',
            titleText: const Center(
                child: Icon(
              Icons.warning,
              color: Colors.white,
            )),
            messageText: Center(
                child: Text(
              msg.message.toString(),
              style: TextStyle(color: Colors.white),
            )),
            backgroundColor: Colors.orange,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        getMyAds(false);
        Get.snackbar(
          '',
          '',
          titleText: const Center(
              child: Icon(
            Icons.check,
            color: Colors.white,
          )),
          messageText: const Center(
              child: Text(
            'تمت العملية بنجاح',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }).catchError((onError) {
      print(onError);
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
            Icons.error,
            color: Colors.white,
          )),
          messageText: Center(
              child: connectionState(allController.stateIs.value,
                  clr: Colors.white)),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    });
  }

  void updateSavedSearch(String ad, String title, bool noti) {
    isLoading.value = true;
    dioHelper.putData(url: "search/$ad", data: {
      "title": title,
      "notifiable": noti,
    }).then((value) {
      Get.snackbar(
        '',
        '',
        titleText: const Center(
            child: Icon(
          Icons.check,
          color: Colors.white,
        )),
        messageText: const Center(
            child: Text(
          'تمت العملية بنجاح',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
      getSavedSearch();
    }).catchError((onError) {
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
            Icons.error,
            color: Colors.white,
          )),
          messageText: Center(
              child: connectionState(allController.stateIs.value,
                  clr: Colors.white)),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    });
  }

  void updateProfileImage(XFile image) async {
    await uploadImageProfile(image).then((value1) {
      dioHelper
          .postData(url: "profile/update-avatar", data: value1)
          .then((value) {
        return {
          print(value.data),
          if (value.statusCode != 200)
            {
              msg = MessageError.fromJson(value.data),
              if (msg.errors != null || msg.errors!.isNotEmpty)
                {
                  msg.errors!.forEach((key, value) {
                    if (value is List) {
                      value.forEach((value) {
                        Get.snackbar(
                          '',
                          '',
                          titleText: const Center(
                              child: Icon(
                            Icons.warning,
                            color: Colors.white,
                          )),
                          messageText: Center(
                              child: Text(
                            value.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                          backgroundColor: Colors.orange,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      });
                    } else {
                      Get.snackbar(
                        '',
                        '',
                        titleText: const Center(
                            child: Icon(
                          Icons.check,
                          color: Colors.white,
                        )),
                        messageText: Center(
                            child: Text(
                          value.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  }),
                }
              else
                {
                  Get.snackbar(
                    '',
                    '',
                    titleText: const Center(
                        child: Icon(
                      Icons.warning,
                      color: Colors.white,
                    )),
                    messageText: Center(
                        child: Text(
                      msg.message.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                    backgroundColor: Colors.orange,
                    snackPosition: SnackPosition.BOTTOM,
                  ),
                }
            }
          else
            {
              Get.snackbar(
                '',
                '',
                titleText: const Center(
                    child: Icon(
                  Icons.check,
                  color: Colors.white,
                )),
                messageText: const Center(
                    child: Text(
                  'تمت العملية بنجاح',
                  style: TextStyle(color: Colors.white),
                )),
                backgroundColor: Colors.green,
                snackPosition: SnackPosition.BOTTOM,
              ),
            },
        };
      }).catchError((onError) {
        print(onError);
        Get.snackbar('', '',
            titleText: const Center(
                child: Icon(
              Icons.error,
              color: Colors.white,
            )),
            messageText: Center(
                child: connectionState(allController.stateIs.value,
                    clr: Colors.white)),
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM);
        isLoading.value = false;
      });
    });
  }

  void deleteUserAd(String id) {
    isLoading.value = true;
    dioHelper.deleteData(url: "profile/posts/$id").then((value) {
      return {
        if (value.statusCode != 200)
          {
            msg = MessageError.fromJson(value.data),
            if (msg.errors != null)
              {
                msg.errors!.forEach((key, value) {
                  if (value is List) {
                    value.forEach((value) {
                      Get.snackbar(
                        '',
                        '',
                        titleText: const Center(
                            child: Icon(
                              Icons.warning,
                              color: Colors.white,
                            )),
                        messageText: Center(
                            child: Text(
                              value.toString(),
                              style: TextStyle(color: Colors.white),
                            )),
                        backgroundColor: Colors.orange,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    });
                  } else {
                    Get.snackbar(
                      '',
                      '',
                      titleText: const Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          )),
                      messageText: Center(
                          child: Text(
                            value.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                }),
              }
            else
              {
                Get.snackbar(
                  '',
                  '',
                  titleText: const Center(
                      child: Icon(
                        Icons.warning,
                        color: Colors.white,
                      )),
                  messageText: Center(
                      child: Text(
                        msg.message.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  backgroundColor: Colors.orange,
                  snackPosition: SnackPosition.BOTTOM,
                ),
              }
          }
        else
          {
            Get.back(),
            Get.snackbar(
              '',
              '',
              titleText: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  )),
              messageText: const Center(
                  child: Text(
                    'تمت العملية بنجاح',
                    style: TextStyle(color: Colors.white),
                  )),
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM,
            ),
            getMyAds(false),
          },
      };
    }).catchError((onError) {
      print(onError.toString());
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
            Icons.error,
            color: Colors.white,
          )),
          messageText: Center(
              child: connectionState(allController.stateIs.value,
                  clr: Colors.white)),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    });
  }


  Future createUserAd(package_id, List<XFile> images) async {
    await uploadImagesPost(package_id, images).then((value) {
      isLoading.value = true;
      dioHelper.postData(url: "profile/posts", data: value).then((value) async {
        return {
          print(value.data),
          if (value.statusCode != 200)
          {
              msg = MessageError.fromJson(value.data),
              if (msg.errors != null)
                {
                  msg.errors!.forEach((key, value) {
                    if (value is List) {
                      value.forEach((value) {
                        Get.snackbar(
                          '',
                          '',
                          titleText: const Center(
                              child: Icon(
                            Icons.warning,
                            color: Colors.white,
                          )),
                          messageText: Center(
                              child: Text(
                            value.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                          backgroundColor: Colors.orange,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      });
                    } else {
                      Get.snackbar(
                        '',
                        '',
                        titleText: const Center(
                            child: Icon(
                          Icons.check,
                          color: Colors.white,
                        )),
                        messageText: Center(
                            child: Text(
                          value.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  }),
                }
              else
                {
                  Get.snackbar(
                    '',
                    '',
                    titleText: const Center(
                        child: Icon(
                      Icons.warning,
                      color: Colors.white,
                    )),
                    messageText: Center(
                        child: Text(
                      msg.message.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                    backgroundColor: Colors.orange,
                    snackPosition: SnackPosition.BOTTOM,
                  ),
                }
            }
          else
            {
              filter.clear(),
              //
              Get.offAll(HomeScreen()),
              Get.snackbar(
                '',
                '',
                titleText: const Center(
                    child: Icon(
                  Icons.check,
                  color: Colors.white,
                )),
                messageText: const Center(
                    child: Text(
                  'تمت العملية بنجاح',
                  style: TextStyle(color: Colors.white),
                )),
                backgroundColor: Colors.green,
                snackPosition: SnackPosition.BOTTOM,
              ),
            },
          isLoading.value = false,
        };
      }).catchError((onError) {
        print(onError);
        Get.snackbar('', '',
            titleText: const Center(
                child: Icon(
              Icons.error,
              color: Colors.white,
            )),
            messageText: Center(
                child: connectionState(allController.stateIs.value,
                    clr: Colors.white)),
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM);
        isLoading.value = false;
      });
    });
  }

  void updateUserAd(id, category, String title, String des, String price, phone,
      location, List<dynamic> images, List<dynamic> removedImages) async {
    await uploadImagesEditAd(
            category, title, des, price, phone, location, images, removedImages)
        .then((value) {
      isLoading.value = true;
      dioHelper
          .postData(url: "profile/posts/$id", data: value)
          .then((value) async {
        return {
          print(value.data),
          if (value.statusCode != 200)
            {
              msg = MessageError.fromJson(value.data),
              if (msg.errors != null)
                {
                  msg.errors!.forEach((key, value) {
                    if (value is List) {
                      value.forEach((value) {
                        Get.snackbar(
                          '',
                          '',
                          titleText: const Center(
                              child: Icon(
                            Icons.warning,
                            color: Colors.white,
                          )),
                          messageText: Center(
                              child: Text(
                            value.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                          backgroundColor: Colors.orange,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      });
                    } else {
                      Get.snackbar(
                        '',
                        '',
                        titleText: const Center(
                            child: Icon(
                          Icons.check,
                          color: Colors.white,
                        )),
                        messageText: Center(
                            child: Text(
                          value.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  }),
                }
              else
                {
                  Get.snackbar(
                    '',
                    '',
                    titleText: const Center(
                        child: Icon(
                      Icons.warning,
                      color: Colors.white,
                    )),
                    messageText: Center(
                        child: Text(
                      msg.message.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                    backgroundColor: Colors.orange,
                    snackPosition: SnackPosition.BOTTOM,
                  ),
                }
            }
          else
            {
              Get.offAll(HomeScreen()),
              Get.snackbar(
                '',
                '',
                titleText: const Center(
                    child: Icon(
                  Icons.check,
                  color: Colors.white,
                )),
                messageText: const Center(
                    child: Text(
                  'تمت العملية بنجاح',
                  style: TextStyle(color: Colors.white),
                )),
                backgroundColor: Colors.green,
                snackPosition: SnackPosition.BOTTOM,
              ),
            },
          isLoading.value = false,
        };
      }).catchError((onError) {
        print(onError);
        Get.snackbar('', '',
            titleText: const Center(
                child: Icon(
              Icons.error,
              color: Colors.white,
            )),
            messageText: Center(
                child: connectionState(allController.stateIs.value,
                    clr: Colors.white)),
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM);
        isLoading.value = false;
      });
    });
  }

  Future repostUserAd(id, packageId)async {
    isLoading.value = true;
    dioHelper.postData(
        url: "profile/posts/$id/repost",
        data: {"package_id": packageId}).then((value) {
      return {
        if (value.statusCode != 200)
          {
            msg = MessageError.fromJson(value.data),
            if (msg.errors != null)
              {
                msg.errors!.forEach((key, value) {
                  if (value is List) {
                    value.forEach((value) {
                      Get.snackbar(
                        '',
                        '',
                        titleText: const Center(
                            child: Icon(
                              Icons.warning,
                              color: Colors.white,
                            )),
                        messageText: Center(
                            child: Text(
                              value.toString(),
                              style: TextStyle(color: Colors.white),
                            )),
                        backgroundColor: Colors.orange,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    });
                  } else {
                    Get.snackbar(
                      '',
                      '',
                      titleText: const Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          )),
                      messageText: Center(
                          child: Text(
                            value.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                }),
              }
            else
              {
                Get.snackbar(
                  '',
                  '',
                  titleText: const Center(
                      child: Icon(
                        Icons.warning,
                        color: Colors.white,
                      )),
                  messageText: Center(
                      child: Text(
                        msg.message.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  backgroundColor: Colors.orange,
                  snackPosition: SnackPosition.BOTTOM,
                ),
              }
          }
        else
          {
            Get.back(),
      Get.back(),
            Get.snackbar(
              '',
              '',
              titleText: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  )),
              messageText: const Center(
                  child: Text(
                    'تمت العملية بنجاح',
                    style: TextStyle(color: Colors.white),
                  )),
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM,
            ),
            getMyAds(false),

          },
      };
    }).catchError((onError) {
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
                Icons.error,
                color: Colors.white,
              )),
          messageText: Center(
              child: connectionState(allController.stateIs.value,
                  clr: Colors.white)),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    });
  }

  void refreshUserAd(id,) {
    isLoading.value = true;
    dioHelper.postData(
        url: "profile/posts/$id/refresh",).then((value) {
      return {
        if (value.statusCode != 200)
          {
            msg = MessageError.fromJson(value.data),
            if (msg.errors != null)
              {
                msg.errors!.forEach((key, value) {
                  if (value is List) {
                    value.forEach((value) {
                      Get.snackbar(
                        '',
                        '',
                        titleText: const Center(
                            child: Icon(
                              Icons.warning,
                              color: Colors.white,
                            )),
                        messageText: Center(
                            child: Text(
                              value.toString(),
                              style: TextStyle(color: Colors.white),
                            )),
                        backgroundColor: Colors.orange,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    });
                  } else {
                    Get.snackbar(
                      '',
                      '',
                      titleText: const Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          )),
                      messageText: Center(
                          child: Text(
                            value.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                }),
              }
            else
              {
                Get.snackbar(
                  '',
                  '',
                  titleText: const Center(
                      child: Icon(
                        Icons.warning,
                        color: Colors.white,
                      )),
                  messageText: Center(
                      child: Text(
                        msg.message.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  backgroundColor: Colors.orange,
                  snackPosition: SnackPosition.BOTTOM,
                ),
              }
          }
        else
          {
            Get.back(),
            Get.snackbar(
              '',
              '',
              titleText: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  )),
              messageText: const Center(
                  child: Text(
                    'تمت العملية بنجاح',
                    style: TextStyle(color: Colors.white),
                  )),
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM,
            ),
            getMyAds(false),
          },
      };
    }).catchError((onError) {
      Get.snackbar('', '',
          titleText: const Center(
              child: Icon(
                Icons.error,
                color: Colors.white,
              )),
          messageText: Center(
              child: connectionState(allController.stateIs.value,
                  clr: Colors.white)),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
    });
  }

  @override
  void onInit() {
    super.onInit();
  }
}
