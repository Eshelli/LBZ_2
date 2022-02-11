import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:lbz/Logics/profile_logic/profile_controller.dart';
import 'package:lbz/Screens/components/components.dart';
import 'package:lbz/shared/components/varibales_combonents.dart';
import 'package:lbz/shared/styles/colors.dart';

class ChangePass extends StatelessWidget {
  ChangePass({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();
  var confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    return Scaffold(
      appBar:
          AppBar(title: const Text('Change your password'), centerTitle: true),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              defualtTextForm(
                context,
                controler: oldPassController,
                type: TextInputType.visiblePassword,
                clr: Colors.grey,
                radius: 10,
                label: 'Old Password',
              ),
              const SizedBox(
                height: 10,
              ),
              defualtTextForm(context,
                  controler: newPassController,
                  type: TextInputType.visiblePassword,
                  clr: Colors.grey,
                  radius: 10,
                  label: 'New Password', validator: (value) {
                if (value.length < 7) {
                  return 'The password must be at least 8 characters';
                }
                return null;
              }),
              const SizedBox(
                height: 10,
              ),
              defualtTextForm(context,
                  controler: confirmPassController,
                  type: TextInputType.visiblePassword,
                  clr: Colors.grey,
                  radius: 10,
                  label: 'Confirm Password', validator: (value) {
                if (value.length < 7) {
                  return 'The password must be at least 8 characters';
                }
                return null;
              }),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                child: button('Change Password', Icons.security, onPress: () {
                  if (formKey.currentState!.validate()) {
                    if(GetUtils.hasMatch(confirmPassController.text, newPassController.text)){
                    if (newPassController.text == confirmPassController.text) {
                      profileController.updatePassword(
                          oldPassController.text, newPassController.text,confirmPassController.text);
                    }
                    }else{
                      Get.defaultDialog(title: 'تنبيه',titleStyle: const TextStyle(color: Colors.white),titlePadding: EdgeInsets.zero,middleText: 'الرجاء التاكد من تطابق كلمة المرور الجديدة',middleTextStyle: TextStyle(color: Colors.white),backgroundColor: Colors.red.shade300);
                    }
                  }
                }, color: redDefaultColor, clr: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
