import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libozzle/Logics/app_logic/app_controller.dart';
import 'package:libozzle/Logics/profile_logic/profile_controller.dart';
import 'package:libozzle/assets/flaticon_icons.dart';
import 'package:libozzle/shared/components/varibales_combonents.dart';
import 'package:libozzle/shared/styles/colors.dart';

import '../../../all_controllers.dart';
import '../../no_internet.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({Key? key}) : super(key: key);

  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  var appController = Get.find<AppController>();

  var profileController = Get.find<ProfileController>();

  var nameController = TextEditingController();

  var desController = TextEditingController();

  var fieldController = TextEditingController();

  var phoneController = TextEditingController();

  var licenseController = TextEditingController();

  var sizeController = TextEditingController();

  var webController = TextEditingController();

  var locationController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    initProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var allController = Get.find<ALlControllers>();
    bool isApproved = profileController.userDetails.company != null
        ? profileController.userDetails.company!.isApproved
        : false;
    return Obx(() {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (profileController.isLoading.value)
                const LinearProgressIndicator(
                  color: darkGrayDefaultColor,
                  backgroundColor: Colors.white,
                ),
              SizedBox(
                  height: 50,
                  child: defualtTextForm2(context,
                      controler: nameController,
                      type: TextInputType.text,
                      label: 'Company Name',
                      readOnly: isApproved ? true : false,
                      radius: 5)),
              const SizedBox(
                height: 20,
              ),
              defualtTextForm2(context,
                  controler: desController,
                  label: 'Description',
                  type: TextInputType.text,
                  maxLine: 5,
                  readOnly: isApproved ? true : false,
                  radius: 5),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 50,
                  child: defualtTextForm2(context,
                      controler: licenseController,
                      type: TextInputType.number,
                      label: 'License Number',
                      readOnly: isApproved ? true : false,
                      radius: 5)),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 50,
                  child: defualtTextForm2(context,
                      controler: phoneController,
                      type: TextInputType.number,
                      label: 'Phone Number',
                      readOnly: isApproved ? true : false,
                      radius: 5)),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 50,
                  child: defualtTextForm2(context,
                      controler: fieldController,
                      type: TextInputType.text,
                      label: 'Field',
                      readOnly: isApproved ? true : false,
                      radius: 5)),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 50,
                  child: defualtTextForm2(context,
                      controler: sizeController,
                      type: TextInputType.text,
                      label: 'Size',
                      readOnly: isApproved ? true : false,
                      radius: 5)),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 50,
                  child: defualtTextForm2(context,
                      controler: webController,
                      type: TextInputType.url,
                      label: 'Website',
                      readOnly: isApproved ? true : false,
                      radius: 5)),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 50,
                  child: defualtTextForm2(context,
                      controler: locationController,
                      type: TextInputType.text,
                      label: 'Location',
                      readOnly: isApproved ? true : false,
                      radius: 5)),
              const SizedBox(
                height: 20,
              ),
              if (profileController.isLoading.value == false)
                buttonUserForm(
                    'Update Company info', FlatIcon.edit, redDefaultColor,
                    mainAxis: MainAxisAlignment.center,
                    iconColor: Colors.white,
                    txtColor: Colors.white, onPress: () {
                  if (isApproved == false) {
                    profileController.updateUserToCompany(
                        nameController.text,
                        desController.text,
                        licenseController.text,
                        fieldController.text,
                        sizeController.text,
                        phoneController.text,
                        webController.text,
                        locationController.text);
                  }
                }),
              if (profileController.isLoading.value)
                Center(child: CircularProgressIndicator()),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    });
  }

  void initProfile() {
    if (profileController.userDetails.company != null) {
      var company = profileController.userDetails.company!;
      nameController.text = company.name.toString();
      phoneController.text = company.phoneNumber.toString();
      licenseController.text = company.licenseNumber.toString();
      desController.text = company.description.toString();
      fieldController.text = company.field.toString();
      sizeController.text = company.size.toString();
      webController.text = company.websiteLink.toString();
      locationController.text = company.location.toString();
    }
  }
}
