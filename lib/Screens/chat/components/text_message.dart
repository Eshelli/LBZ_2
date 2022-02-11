import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/Logics/chat_logic/chat_controller.dart';
import 'package:lbz/Screens/chat/models/msg_model.dart';
import 'package:lbz/assets/flaticon_icons.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/styles/colors.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.message,
    required this.isSender,
  }) : super(key: key);

  final MessagesData message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: size.width *.6
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 0.75,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: isSender? redDefaultColor : Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color: isSender
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(isSender)...[
                  Icon(message.isRead == 1 ?FlatIcon.read:message.isRead == 0 ?Icons.check:message.isRead == 2 ?Icons.timer_outlined:Icons.error,size: 15,color: Colors.white,),
                  SizedBox(width: 5,),
                ],
                Text("12:30 pm",style: TextStyle(
                color: isSender
                ? Colors.white
                    : Theme.of(context).textTheme.bodyText1!.color,
      ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
