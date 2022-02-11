import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libozzle/Logics/app_logic/app_controller.dart';
import 'package:libozzle/Logics/profile_logic/profile_controller.dart';
import 'package:libozzle/Screens/components/components.dart';
import 'package:libozzle/Screens/filter/components/filter_text2.dart';
import 'package:libozzle/models/attributes.dart';
import 'package:libozzle/shared/components/constans.dart';
import 'package:libozzle/shared/components/varibales_combonents.dart';
import 'package:libozzle/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'CMB/text.dart';

class MyAdDetails extends StatefulWidget {
  @override
  State<MyAdDetails> createState() => _MyAdDetailsState();
}

class _MyAdDetailsState extends State<MyAdDetails> {

  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var desController = TextEditingController();
  var phoneController = TextEditingController();
  var priceController = TextEditingController();
  var cityController = TextEditingController();
  var locationController = TextEditingController();
  var appController = Get.find<AppController>();
  String? valueString;
  final ImagePicker _picker = ImagePicker();
  List<dynamic> _imageList = [];
  List<dynamic> _removedImageList = [];
  int activeImage = 0;

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    print(_imageList);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Form(
        key: formKey,
        child: Obx(() {
          if (appController.appData.adsDetailsLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'You’re almost there!',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 35),
                  ),
                  Text(
                    'Include as much details and pictures as possible and set the right price!',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  defualtTextForm2(context,
                      controler: titleController,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                      radius: 20,
                      onChanged: (txt) {
                        // filter.update('attribute_$id', (value) => txtController.text);
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  defualtTextForm2(context,
                      label: 'Description',
                      controler: desController,
                      type: TextInputType.text, validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Description';
                    }
                    return null;
                  }, radius: 20),
                  SizedBox(
                    height: 10,
                  ),
                  defualtTextForm2(context,
                      label: 'Phone number',
                      controler: phoneController,
                      type: TextInputType.phone, validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  }, radius: 20),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: button('  Add Pictures', Icons.image,
                        color: redDefaultColor, clr: Colors.white, onPress: () {
                      selectImage();
                    }),
                  ),
                  if (_imageList.isNotEmpty)
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CarouselSlider(
                          items: _imageList
                              .map((e) => Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      if (e is XFile)
                                        Image(
                                          image: FileImage(File(e.path)),
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                'assets/image/lbz.png');
                                          },
                                        ),
                                      if (e is String)
                                        Image(
                                          image: NetworkImage(e),
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                'assets/image/lbz.png');
                                          },
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if(e is String){
                                                setState(() {
                                                  _removedImageList.add(appController.appData.adsDetails.images.firstWhere((element) => element.url == e).id);
                                                });
                                                print(_removedImageList);
                                              }
                                              _imageList.removeWhere(
                                                  (element) => element == e);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: redDefaultColor,
                                            size: 25,
                                          ))
                                    ],
                                  ))
                              .toList(),
                          options: CarouselOptions(
                            height: 225,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            autoPlay: false,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeImage = index;
                              });
                            },
                          ),
                        ),
                        if (_imageList.length > 1)
                          AnimatedSmoothIndicator(
                            activeIndex: activeImage,
                            count: _imageList.length,
                            effect: const ScrollingDotsEffect(
                                activeDotColor: Colors.white,
                                dotColor: Color(0xffaeaeae),
                                dotHeight: 8,
                                dotWidth: 8),
                          ),
                      ],
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  defualtTextForm2(context,
                      label: 'Price',
                      controler: priceController,
                      type: TextInputType.number, validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter price';
                    }
                    return null;
                  }, radius: 20),
                  SizedBox(
                    height: 10,
                  ),
                  defualtTextForm2(context,
                      label: 'Location',
                      controler: locationController,
                      type: TextInputType.streetAddress, validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Location';
                    }
                    return null;
                  }, radius: 20),
                  const SizedBox(
                    height: 10,
                  ),
                  profileDropDown(appController.appData.cities, 'City'),
                  const SizedBox(
                    height: 10,
                  ),
                  GetBuilder<AppController>(builder: (controller) {
                    var attributes = controller.appData.attributes;
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index1) {
                        editAd.putIfAbsent( "attribute_${attributes[index1].id}[value]", () => '');
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              attributes[index1].name.toString(),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle2,
                            ),
                            if (attributes[index1].type != 'text')
                              editAdGroup(attributes[index1].options,attributes[index1].id),
                            if (attributes[index1].type == 'text')
                              editText(attributes[index1].id!.toInt())
                          ],
                        );
                      },
                      itemCount: attributes.length,
                      separatorBuilder: (BuildContext context, int index) =>
                      attributes[index].type != 'text'
                          ? const Divider()
                          : SizedBox(
                        height: 10,
                      ),
                    );
                  }
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (profileController.isLoading.value)
                    const Center(child: CircularProgressIndicator()),
                  if (profileController.isLoading.value == false)
                    button('Edit Post', Icons.add,color: redDefaultColor,clr: Colors.white, onPress: () {
                      print(categorySlug);
                      print(taxonomySlug);
                      if (formKey.currentState!.validate()){
                        if (_imageList.isEmpty) {
                          dialog([
                            const Center(
                                child:
                                    Text('الرجاء اضافة صورة واحدة على الاقل'))
                          ]);
                        } else if (cityController.text == null) {
                          dialog([
                            const Center(child: Text('الرجاء إختيار مدينة'))
                          ]);
                        } else
                        {
                          profileController.updateUserAd(
                            appController.appData.adsDetails.id,
                            appController.appData.adsDetails.category!.slug.toString(),
                              titleController.text,
                              desController.text,
                              priceController.text,
                              phoneController.text,
                              locationController.text,
                              _imageList,
                              _removedImageList,
                          );
                        }
                      }
                    }),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void selectImage() async {
    var selected = await _picker.pickImage(source: ImageSource.gallery);
    if (selected!.path.isNotEmpty) {
      setState(() {
        _imageList.add(selected);
      });
      print(_imageList);
    }
  }

  void getData() {
    _imageList = [];
        titleController.text =
            appController.appData.adsDetails.title.toString();
        desController.text =
            appController.appData.adsDetails.description.toString();
        phoneController.text =
            appController.appData.adsDetails.phoneNumber.toString();
        priceController.text = appController.appData.adsDetails.price.toString().replaceAll(new RegExp(r'[^0-9]'),'');
        cityController.text =
            appController.appData.adsDetails.city!.id.toString();
        locationController.text =
            appController.appData.adsDetails.location.toString();
        appController.appData.adsDetails.images.forEach((element) {
          _imageList.add(element.url.toString());
      });
    appController.appData.adsDetails.attributes.forEach((element)
    {
        editAd.addIf(true,'attribute_${element.atb.id}[value]',element.value );
    });
  }

  Widget profileDropDown(List<dynamic> list, String title) {
    return DropdownButtonFormField<String>(
      hint: const Text(
        'City',
        style: TextStyle(fontSize: 21),
      ),
      isDense: false,
      isExpanded: true,
      value: cityController.text,
      onChanged: (value) {
        cityController.text = value!;
      },
      items: list
          .map((data) => DropdownMenuItem<String>(
                alignment: Alignment.topLeft,
                child: Text(
                  data.name.toString(),
                  style: TextStyle(fontSize: 21),
                ),
                value: data.id.toString(),
              ))
          .toList(),
    );
  }

  Widget editAdGroup(List<Option>? list, id) {
    var adAttributesName = editAd.entries.firstWhere((element) => element.key == 'attribute_${id}[value]').value;
    List<String> names = [];
    list!.forEach((element) {
      names.add(element.name.toString());
    });
    var controller = GroupButtonController(selectedIndex: names.indexWhere((element) => element == adAttributesName));
    return Center(
      child: GroupButton.radio(
        buttons: names,
        selectedColor: redDefaultColor,
        alignment: Alignment.center,
        controller: controller,
        onSelected: (index) {
          editAd.update('attribute_${id}[value]', (value) {
            return names[index];
          });
          print(filter);
        },
      ),
    );
  }

  Widget editText(int id,)
  {
    var txtController = TextEditingController(text: editAd.entries.firstWhere((element) => element.key == 'attribute_${id}[value]').value);
    return defualtTextForm(context, controler: txtController,label: 'Type here', type: TextInputType.text,onChanged:  (txt){
      editAd.update('attribute_${id}[value]', (value) {
        return txt;
      });
      print(editAd);
    }, radius: 5);
  }
}
