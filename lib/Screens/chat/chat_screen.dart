import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/Logics/chat_logic/chat_controller.dart';
import 'package:lbz/Screens/chat/components/text_message.dart';
import 'package:lbz/assets/flaticon_icons.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/styles/colors.dart';
import 'components/chat_input_field.dart';

class ChatScreen extends StatefulWidget {
  final String id;
  final int user_id;

  ChatScreen({Key? key, required this.id, required this.user_id}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var chatController = Get.find<ChatController>();
  ScrollController _scrollController = ScrollController();
  // PusherClient pusher = new PusherClient(
  //   "cbabd39d7757fedbdec1",
  //   PusherOptions(
  //     encrypted: false,
  //     cluster: 'eu',
  //     auth: PusherAuth(
  //       'https://api.libozzle.ly/api/broadcasting/auth',
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //     ),
  //   ),
  //   enableLogging: true,
  // );


@override
  void initState() {
    // TODO: implement initState
  _scrollController.addListener(()
  {
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      chatController.getMoreMSGChats(widget.id);
    }
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // pusher.onConnectionStateChange((state) {
    //   log("previousState: ${state!.previousState}, currentState: ${state.currentState}");
    // });
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'User Name',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  FlatIcon.phone_call,
                  color: redDefaultColor,
                )),
          ],
        ),
        body: GetBuilder<ChatController>(builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: ListView.separated(
                    controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Align(
                              alignment:
                                  controller.msgData[index].senderId != widget.user_id
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: TextMessage(
                                  message: controller.msgData[index],
                                  isSender: controller.msgData[index].senderId != widget.user_id),
                            ),
                          ),
                      reverse: true,
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: controller.msgData.length),
                ),
              ),
              ChatInputField(id: widget.id,user_id: widget.user_id,),
            ],
          );
        }));
  }

  Widget myMSG(String txt, double right, double left, BuildContext context,
      {Color color = Colors.grey}) {
    var size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: size.width * .6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(left),
                bottomRight: Radius.circular(right),
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(txt),
          ),
        ),
      ),
    );
  }
}
