
import 'package:get/get.dart';
import 'package:libozzle/Screens/chat/models/msg_model.dart';
import 'package:libozzle/Screens/notification/model/notification_model.dart';
import 'package:libozzle/commen_models/errors_models.dart';
import 'package:libozzle/shared/components/constans.dart';

import 'models/chat_model.dart';

class ChatController extends GetxController {
  var isLoading = false.obs;
  var msgIsLoading = false.obs;
  late MessageError msg;
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

  Future sendMSG(id, content, int user_id) async {
    msgData.insert(
        0,
        MessagesData(
            content: content,
            isRead: 2,
            sentAt: DateTime.now().toString(),
            senderId: user_id));
    update();
    dioHelper.postData(
        url: 'chats/$id',
        query: {"content": content, "user_id": user_id}).then((value) {
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
    isLoading.value = true;
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
        isLoading.value = false,
      };
    }).catchError((onError) {
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

  @override
  void onInit() {
    super.onInit();
  }
}
