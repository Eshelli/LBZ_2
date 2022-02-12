import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/Logics/chat_logic/chat_controller.dart';
import 'package:lbz/assets/flaticon_icons.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/styles/colors.dart';

class ChatInputField extends StatefulWidget {
  final String id;
  final int user_id;
   ChatInputField({
    Key? key, required this.id, required this.user_id,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
   TextEditingController txtController = TextEditingController();
   var chatController = Get.find<ChatController>();

   bool full = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: Colors.red.withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children:
                  [
                     Expanded(
                      child: TextFormField(
                        onChanged: (txt){
                          setState(() {
                            if(txt.isNotEmpty){
                              full = true;
                            }else{
                              full = false;
                            }
                          });
                        },
                        textDirection: TextDirection.rtl,
                        controller: txtController,
                        decoration: const InputDecoration(
                          hintText: "Type a message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: kDefaultPadding / 4),
                    if(full == true)
                      TextButton(
                        onPressed: (){
                          chatController.sendMSG(widget.id, txtController.text,-200,widget.user_id,);
                          txtController.text = '';
                        },
                        child: Icon(
                          FlatIcon.send,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(0.64),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
