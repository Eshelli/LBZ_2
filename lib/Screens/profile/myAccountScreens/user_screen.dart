import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/Logics/profile_logic/profile_controller.dart';
import 'package:lbz/Screens/walletCharge.dart';
import 'package:lbz/assets/flaticon_icons.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/components/varibales_combonents.dart';
import 'package:lbz/shared/styles/colors.dart';

import '../../../all_controllers.dart';
import '../../no_internet.dart';
import 'change_pass.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  var formKey = GlobalKey<FormState>();

  var appController = Get.find<AppController>();

  var profileController = Get.find<ProfileController>();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var countryController = TextEditingController();

  var genderController = TextEditingController();

  var dateController = TextEditingController();

  var emailController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _imageList;

  @override
  void initState() {
    // TODO: implement initState
    initProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var allController = Get.find<ALlControllers>();
    var size = MediaQuery.of(context).size;
    return Obx(() {
      return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (profileController.isLoading.value)
                  const LinearProgressIndicator(
                    color: darkGrayDefaultColor,
                    backgroundColor: Colors.white,
                  ),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      if (_imageList != null)
                        SizedBox(
                          height: 120,
                          child: CircleAvatar(
                            radius: 90,
                            backgroundImage: FileImage(File(_imageList!.path)),
                          ),
                        ),
                      if (_imageList == null)
                        SizedBox(
                          height: 150,
                          child: CircleAvatar(
                            radius: 90,
                            backgroundImage: NetworkImage(
                              profileController.userDetails.avatar!.url
                                  .toString(),
                            ),
                            onBackgroundImageError: (exception, stackTrace) =>
                                Image.asset(
                              'assets/image/lbz.png',
                              fit: BoxFit.contain,
                            ),
                            // child: Image.network(profileController
                            //     .userDetails.avatar!.url
                            //     .toString(),
                            //   fit: BoxFit.cover,
                            //   alignment: Alignment.center,
                            //   errorBuilder: (context, error, stackTrace) => Image.asset('assets/image/lbz.png',fit: BoxFit.contain,),
                            //   loadingBuilder: (context, child, loadingProgress) {
                            //     if(loadingProgress == null) {
                            //       return child;
                            //     }
                            //     return Center(child: CircularProgressIndicator(value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded/loadingProgress.expectedTotalBytes!:null,),);
                            //   },
                            // ),
                          ),
                        ),
                      SizedBox(
                          height: 45,
                          width: 45,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: IconButton(
                                  onPressed: () {
                                    selectImage();
                                  },
                                  icon: const Icon(
                                    FlatIcon.edit,
                                    size: 18,
                                    color: redDefaultColor,
                                  )))),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                buttonUserForm(
                    lang == 'ar' ? 'تغيير كلمة المرور' : 'Change Your Password',
                    FlatIcon.key,
                    Colors.grey.shade300, onPress: () {
                  Get.to(ChangePass());
                }),

                const SizedBox(
                  height: 10,
                ),
                buttonUserForm(
                    '${lang == 'ar' ? 'رصيدك' : 'Your balance'} : ${appController.appData.balance}',
                    Icons.wallet_travel_outlined,
                    Colors.grey.shade300, onPress: () async {
                      Get.to(WalletCharge());
                }),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 50,
                    child: defualtTextForm2(context,
                        controler: nameController,
                        type: TextInputType.text,
                        label: lang == 'ar' ? 'الاسم' : 'Name',
                        validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your Name';
                      }
                      return null;
                    }, radius: 5)),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 50,
                    child: defualtTextForm2(context,
                        controler: emailController,
                        label: lang == 'ar' ? 'البريد الالكتروني' : 'Email',
                        type: TextInputType.emailAddress,
                        readOnly: true,
                        radius: 5)),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 50,
                    child: defualtTextForm2(context,
                        controler: phoneController,
                        type: TextInputType.text,
                        label: lang == 'ar' ? 'رقم الهاتف' : 'Phone Number',
                        validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your Phone Number';
                      }
                      return null;
                    }, radius: 5)),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: size.width * .8,
                        height: 50,
                        child: defualtTextForm2(context,
                            controler: dateController,
                            type: TextInputType.text,
                            label: lang == 'ar'
                                ? 'تاريخ الميلاد'
                                : 'Date of birth',
                            readOnly: true,
                            radius: 5)),
                    Spacer(),
                    SizedBox(
                      width: size.width * .15,
                      child: TextButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.utc(1960),
                                    lastDate: DateTime.now())
                                .then((value) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(value!);
                              dateController.text = formattedDate;
                            });
                          },
                          child: Icon(
                            Icons.date_range,
                            color: redDefaultColor,
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang == 'ar' ? 'الجنس' : 'Gender',
                      style:
                          TextStyle(fontSize: 20, color: darkGrayDefaultColor),
                    ),
                    DropdownButtonFormField<String>(
                      hint: Text(
                        lang == 'ar' ? 'الجنس' : 'Gender',
                        style: TextStyle(fontSize: 21),
                      ),
                      isExpanded: true,
                      itemHeight: 50,
                      value: profileController.userDetails.gender ?? null,
                      onChanged: (value) {
                        genderController.text = value!;
                        print(value);
                      },
                      items: ["Male", "Female"]
                          .map((data) => DropdownMenuItem<String>(
                                child: FittedBox(
                                  child: Text(
                                    data.toString(),
                                  ),
                                ),
                                value: data,
                              ))
                          .toList(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                profileDropDown(appController.appData.countries, 'Country'),
                const SizedBox(
                  height: 20,
                ),
                buttonUserForm(
                    lang == 'ar' ? 'تعديل الملف الشخصي ' : 'Edit profile',
                    FlatIcon.edit,
                    redDefaultColor,
                    mainAxis: MainAxisAlignment.center,
                    iconColor: Colors.white,
                    txtColor: Colors.white, onPress: () {
                  if (formKey.currentState!.validate()) {
                    profileController.updateUserData(
                        nameController.text,
                        phoneController.text,
                        countryController.text,
                        dateController.text,
                        genderController.text);
                  }
                }),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget profileData(String? text, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, color: darkGrayDefaultColor),
        ),
        Text(
          text ?? 'No data to show',
          style: const TextStyle(
            fontSize: 25,
          ),
        )
      ],
    );
  }

  Widget profileDropDown(List<dynamic> list, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, color: darkGrayDefaultColor),
        ),
        DropdownButtonFormField<String>(
          hint: Text(
            lang == 'ar' ? 'البلد' : 'Country',
            style: TextStyle(fontSize: 21),
          ),
          isExpanded: true,
          value: profileController.userDetails.country != null
              ? countryController.text
              : null,
          onChanged: (value) {
            countryController.text = value!;
            print(value);
          },
          items: list
              .map((data) => DropdownMenuItem<String>(
                    child: FittedBox(
                      child: Text(
                        data.name.toString(),
                        style: TextStyle(fontSize: 21),
                      ),
                    ),
                    value: data.id,
                  ))
              .toList(),
        ),
      ],
    );
  }

  void selectImage() async {
    var selected = await _picker.pickImage(source: ImageSource.gallery);
    if (selected!.path.isNotEmpty) {
      setState(() {
        _imageList = selected;
        print(_imageList);
      });
      profileController.updateProfileImage(_imageList!);
    }
  }

  void initProfile() {
    nameController.text = profileController.userDetails.name.toString();
    phoneController.text = profileController.userDetails.phoneNumber.toString();
    emailController.text = profileController.userDetails.email.toString();
    genderController.text = profileController.userDetails.gender.toString();
    if (profileController.userDetails.country != null) {
      countryController.text =
          profileController.userDetails.country!.id.toString();
      dateController.text =
          profileController.userDetails.dob ?? 'No date to show';
    }
  }

}

