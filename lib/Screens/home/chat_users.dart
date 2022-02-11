import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/Logics/chat_logic/chat_controller.dart';
import 'package:lbz/Logics/chat_logic/models/chat_model.dart';
import 'package:lbz/shared/styles/colors.dart';

import '../chat/chat_screen.dart';

class ChatUsers extends StatelessWidget {
  ChatUsers({Key? key}) : super(key: key);
  var chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    chatController.getListUserChats();
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        centerTitle: true,
      ),
      body: GetBuilder<ChatController>(builder: (controller) {
        if (controller.isLoading.value)
          return Center(
            child: CircularProgressIndicator(),
          );
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => listButton(
                  controller.chatData[index],
                ),
            separatorBuilder: (context, index) => Divider(),
            itemCount: controller.chatData.length);
      }),
    );
  }

  Widget listButton(ChatData data) {
    return ListTile(
      title: Text(
        data.users[0].name.toString(),
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        data.latestMessage.content.toString(),
        style: const TextStyle(color: darkGrayDefaultColor, fontSize: 14),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: darkGrayDefaultColor,
        backgroundImage: NetworkImage(data.users[0].avatar!.url.toString()),
      ),
      trailing: FittedBox(
          child: Text(data.date.toString(),
              style: TextStyle(color: redDefaultColor))
      ),
      onTap: () {
        chatController.getMSGChats(data.id);
        Get.to(ChatScreen(
          id: data.id,
          user_id: data.users[0].id!.toInt(),
        ));

      },
    );
  }
}
