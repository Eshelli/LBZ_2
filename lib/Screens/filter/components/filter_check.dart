import 'package:flutter/material.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/styles/colors.dart';

class FilterCheck extends StatefulWidget {
  final String text;
  bool value = false;
  int id;
  FilterCheck({Key? key, required this.text,required this.id}) : super(key: key);

  @override
  _FilterCheckState createState() => _FilterCheckState();
}

class _FilterCheckState extends State<FilterCheck> {

  @override
  Widget build(BuildContext context) {
    widget.value = filter.entries.firstWhere((element) => element.key == 'attribute_${widget.id}').value.contains(widget.text.toString());
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
        activeColor: blackDefaultColor,
        title: Text(
          widget.text,
          style: const TextStyle(fontSize: 17.5),
        ),
        value: widget.value,
        onChanged: (v) {
          setState((){
            widget.value = v!;
          });
          if(v == true) {
            filter.update('attribute_${widget.id}', (value) {
              List<dynamic> list = value;
              list.add(widget.text);
              return list;
            });
            print(filter);
          }
          if(v == false) {
            filter.update('attribute_${widget.id}', (value) {
              List<dynamic> list = value;
              list.remove(widget.text);
              return list;
            });
            print(filter);
          }
          print(filter);
        });
  }
}
