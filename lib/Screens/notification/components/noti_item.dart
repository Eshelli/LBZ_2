import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:libozzle/Logics/notification_logic/notification_controller.dart';
import 'package:libozzle/Screens/notification/model/notification_model.dart';
import 'package:libozzle/assets/flaticon_icons.dart';
import 'package:libozzle/shared/styles/colors.dart';

class NotiItem extends StatefulWidget {
  final NotiData data;
  bool value = false;
  NotiItem({Key? key, required this.data}) : super(key: key);

  @override
  _NotiItemState createState() => _NotiItemState();
}

class _NotiItemState extends State<NotiItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var notiController = Get.find<NotificationController>();
    var size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.zero,
      color: widget.data.isRead?Colors.white: Colors.grey.shade200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children:
      [
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: FittedBox(child: Icon(widget.data.type == 'SAVED_SEARCH'?FlatIcon.save_instagram : FlatIcon.advertisement,color: Colors.black45,)),
            ),
          ),
        ),
        SizedBox(
          width: size.width * .85,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.data.content,style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 20,height: 1,fontWeight: widget.data.isRead ? FontWeight.bold : FontWeight.normal),maxLines: 2,overflow: TextOverflow.ellipsis,),
                Text(widget.data.date,style: TextStyle(fontSize: 17,color: Colors.black45,height: 1,fontWeight: widget.data.isRead ? FontWeight.bold : FontWeight.normal),),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Checkbox(value: isChecked, onChanged: (value) {
              setState(() {
                isChecked = value!;
              });
              if(value == true){
                notiController.notiId.add(widget.data.id);
              }else{
                notiController.notiId.removeWhere((element) => element == widget.data.id);
              }
            },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7)
              ),
            ),
          ),
        ),

      ],),
    );
  }
}
