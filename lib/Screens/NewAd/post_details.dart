import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libozzle/Logics/app_logic/app_controller.dart';
import 'package:libozzle/Logics/profile_logic/profile_controller.dart';
import 'package:libozzle/Screens/NewAd/package_screen.dart';
import 'package:libozzle/Screens/components/components.dart';
import 'package:libozzle/Screens/filter/components/filter_text2.dart';
import 'package:libozzle/Screens/filter/filter.dart';
import 'package:libozzle/shared/components/constans.dart';
import 'package:libozzle/shared/components/varibales_combonents.dart';
import 'package:libozzle/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostDetails extends StatefulWidget {
  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
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
  List<XFile> _imageList = [];
  int activeImage = 0;

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
      ),
      body: Form(
        key: formKey,
        child: Obx((){
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'You’re almost there!',
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontSize: 35),
                  ),
                  Text(
                    'Include as much details and pictures as possible and set the right price!',
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  defualtTextForm(context,
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
                  defualtTextForm(context,
                      label: 'Description',
                      controler: desController,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Description';
                        }
                        return null;
                      },
                      radius: 20),
                  SizedBox(
                    height: 10,
                  ),
                  defualtTextForm(context,
                      label: 'Phone number',
                      controler: phoneController,
                      type: TextInputType.phone,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                      radius: 20),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: button(
                        '  Add Pictures', Icons.image, color: redDefaultColor,
                        clr: Colors.white,
                        onPress: () {
                          selectImage();
                        }),
                  ),
                  if (_imageList.isNotEmpty)
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CarouselSlider(
                          items: _imageList
                              .map((e) =>
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Image(
                                    image: FileImage(File(e.path)),
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error,
                                        stackTrace) =>
                                        Image.network(
                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png',
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          height: 225,
                                        ),
                                  ),
                                  IconButton(onPressed: () {
                                    setState(() {
                                      _imageList.removeWhere((
                                          element) => element == e);
                                    });
                                  },
                                      icon: Icon(
                                        Icons.close, color: redDefaultColor,
                                        size: 25,))
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
                  defualtTextForm(context,
                      label: 'Price',
                      controler: priceController,
                      type: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter price';
                        }
                        return null;
                      },
                      radius: 20),
                  SizedBox(
                    height: 10,
                  ),
                  defualtTextForm(context,
                      label: 'Location',
                      controler: locationController,
                      type: TextInputType.streetAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Location';
                        }
                        return null;
                      },
                      radius: 20),
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
                        filter.addIf(true,
                            "attribute_${attributes[index1].id}[value]", "");
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
                              group(attributes[index1].options,attributes[index1].id),
                            if (attributes[index1].type == 'text')
                              FilterText2(id: attributes[index1].id!.toInt())
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
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  if (profileController.isLoading.value)
                    const Center(child: CircularProgressIndicator()),
                  if (profileController.isLoading.value == false)
                    button('Add post', Icons.add, onPress: ()
                    {
                      print(categorySlug);
                      print(taxonomySlug);
                      if (formKey.currentState!.validate()){
                        if (_imageList.isEmpty) {
                          dialog([
                            const Center(
                                child:
                                Text('الرجاء اضافة صورة واحدة على الاقل'))
                          ]);
                        } else if (cityController.text.isEmpty || cityController.text == '') {
                          dialog([
                            const Center(child: Text('الرجاء إختيار مدينة'))
                          ]);
                        } else{
                          filter.addAll({
                            "category": categorySlug,
                            "city_id": cityController.text,
                            "title": titleController.text,
                            "description": desController.text,
                            "price": priceController.text,
                            "phone_number": phoneController.text,
                            "location": locationController.text,
                          });
                          Get.to(PackageScreen(imageList: _imageList,isNew: true,adId: null,));
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
    }
  }

  Widget profileDropDown(List<dynamic> list, String title) {
    return DropdownButtonFormField<String>(
      hint: const Text(
        'City',
        style: TextStyle(fontSize: 21),
      ),
      isDense: false,
      isExpanded: true,
      value: null,
      onChanged: (value) {
        cityController.text = value!;
      },
      items: list
          .map((data) =>
          DropdownMenuItem<String>(
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
}
