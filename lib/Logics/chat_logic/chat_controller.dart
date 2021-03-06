
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/Screens/chat/chat_screen.dart';
import 'package:lbz/Screens/chat/models/msg_model.dart';
import 'package:lbz/Screens/notification/model/notification_model.dart';
import 'package:lbz/commen_models/errors_models.dart';
import 'package:lbz/models/get_chat_id.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/components/varibales_combonents.dart';

import 'models/chat_model.dart';

class ChatController extends GetxController {
  var isLoading = false.obs;
  var msgIsLoading = false.obs;
  late MessageError msg;
  late GetChatId chatId;
  late Noti notification;
  var unreadCount = 0.obs;
  List<ChatModel> chatModel = [];
  List<Messages> msgModel = [];
  List<ChatData> chatData = [];
  List<MessagesData> msgData = [];

  // final WebSocketChannel channel = IOWebSocketChannel.connect(
  //   Uri.parse('"wss://api.libozzle.ly/api/chats'),
  //   headers: {
  //     Headers.contentTypeHeader: "application/json",
  //     Headers.acceptHeader: "application/json",
  //     "Authorization": "Bearer ${token.toString()}",
  //     "X-Localization": lang
  //   },
  // );
  Future getListUserChats() async {
    isLoading.value = true;
    chatModel = [];
    chatData = [];
    dioHelper.getData(url: 'chats').then((value) {
      return {
        chatModel.add(ChatModel.fromJson(value.data)),
        value.data["data"].forEach((element) {
          chatData.add(ChatData.fromJson(element));
        }),
        update(),
        isLoading.value = false,
      };
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  Future getMoreListUserChats() async {
    isLoading.value = true;
    var page = chatModel.last.meta.currentPage;
    dioHelper
        .getData(url: 'chats', query: {"page": page.toString()}).then((value) {
      return
        {
        chatModel.add(ChatModel.fromJson(value.data)),
        value.data["data"].forEach((element) {
          chatData.add(ChatData.fromJson(element));
        }),
        update(),
        isLoading.value = false,
      };
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  Future sendMSG(id, content, int myId,int user_id) async {
    msgData.insert(
        0,
        MessagesData(
            content: content,
            isRead: 2,
            sentAt: DateTime.now().toString(),
            senderId: myId)
    );
    update();
    dioHelper.postData(
        url: id != null ? 'chats/$id' : 'chats',
        query: {"content": content, "user_id": user_id}
    ).then((value)
    {
      if (value.statusCode == 200) {
        print('done');
        ChatData element = chatData.where((element) => element.id == id).first;
        element.latestMessage.content = content;
        chatData.removeWhere((element) => element.id == id);
        chatData.insert(0,element);
        msgData[0].isRead = 0;
        update();
      } else {
        msgData[0].isRead = 3;
        update();
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  Future getMSGChats(String id) async {
    msgIsLoading.value = true;
    msgModel = [];
    msgData = [];
    print(id);
    dioHelper.getData(url: 'chats/$id').then((value) {
      return {
        msgModel.add(Messages.fromJson(value.data)),
        value.data["data"].forEach((element) {
          msgData.add(MessagesData.fromJson(element));
        }),
        update(),
        msgIsLoading.value = false,
      };
    }).catchError((onError) {
      msgIsLoading.value = false;
      print(onError.toString());
    });
  }

  Future getMoreMSGChats(id) async {
    print(msgModel.length);
    print(msgModel.last.meta.currentPage);
    var page = msgModel.length + 1;
    print(page);
    dioHelper.getData(url: 'chats/$id', query: {"page": page.toString()}).then(
        (value) {
      return {
        if (value.data["data"].isNotEmpty)
          {
            print(value.data),
            msgModel.add(Messages.fromJson(value.data)),
            value.data["data"].forEach((element) {
              msgData.add(MessagesData.fromJson(element));
            }),
            update(),
          }
      };
    }).catchError((onError) {
      print(onError.toString());
    });
  }


  Future getChatId(id ) async {
    msgIsLoading.value = true;
    msgModel = [];
    msgData = [];
    dioHelper.getData(url: 'chats/user/$id',).then(
        (value) {
        print(value.data);
        chatId = GetChatId.fromJson(value.data);
        update();

        if(chatId.chat != null){
          getMSGChats(chatId.chat!.id.toString());
          ChatScreen(
            id: chatId.chat!.id,
            user_id: chatId.user.id,
          );
        };
        msgIsLoading.value = false;
    }).catchError((onError) {
      msgIsLoading.value = false;
      print(onError.toString());
    });
  }

  @override
  void onInit() {
    super.onInit();
  }
}
