import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/components/varibales_combonents.dart';

class EditText extends StatelessWidget {
  var txtController = TextEditingController();
  int id;
  var appController = Get.find<AppController>();
  EditText({Key? key, required this.id}) : super(key: key);
  StatelessElement createElement() {
    // TODO: implement createElement

    return super.createElement();
  }
  @override
  Widget build(BuildContext context) {
    return defualtTextForm(context, controler: txtController,label: 'Type here', type: TextInputType.text,onChanged:  (txt){
      editAd.update('attribute_${id}[value]', (value) {
        return txt;
      });
    }, radius: 5);
  }
}