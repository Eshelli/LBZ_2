import 'package:flutter/material.dart';
import 'package:libozzle/shared/components/constans.dart';
import 'package:libozzle/shared/components/varibales_combonents.dart';
import 'package:libozzle/shared/styles/colors.dart';

class FilterText2 extends StatelessWidget {
  var txtController = TextEditingController();
  int id;

  FilterText2({Key? key, required this.id}) : super(key: key);

  // StatelessElement createElement() {
  //   // TODO: implement createElement
  //   return super.createElement();
  // }
  @override
  Widget build(BuildContext context) {
    get();
    return defualtTextForm(context, controler: txtController,label: 'Type here', type: TextInputType.text,onChanged:  (txt){
      filter.update('attribute_${id}[value]', (value) {
        return txt;
      });
    }, radius: 5);
  }

  void get() {
    txtController.text = filter.entries
        .firstWhere((element) => element.key == 'attribute_$id[value]')
        .value
      ..toString();
  }
}
