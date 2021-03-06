import 'package:flutter/material.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/components/varibales_combonents.dart';
import 'package:lbz/shared/styles/colors.dart';

class FilterText extends StatelessWidget {
  var txtController = TextEditingController();
  int id;

  FilterText({Key? key, required this.id}) : super(key: key);

  // StatelessElement createElement() {
  //   // TODO: implement createElement
  //   return super.createElement();
  // }
  @override
  Widget build(BuildContext context) {
    get();
    return defualtTextForm(context, controler: txtController,label: 'Type here', type: TextInputType.text,onChanged:  (txt){
      filter.update('attribute_${id}', (value) {
        return txt;
      });
    }, radius: 5);
  }

  void get() {
    txtController.text = filter.entries
        .firstWhere((element) => element.key == 'attribute_$id')
        .value
      ..toString();
  }
}
