import 'package:lbz/commen_models/models.dart';

class ChatModel {
  ChatModel({
    required this.chatData,
    required this.links,
    required this.meta,
  });
  late final List<ChatData> chatData;
  late final Links links;
  late final Meta meta;

  ChatModel.fromJson(Map<String, dynamic> json){
    chatData = List.from(json['data']).map((e)=>ChatData.fromJson(e)).toList();
    links = Links.fromJson(json['links']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = chatData.map((e)=>e.toJson()).toList();
    _data['links'] = links.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class ChatData {
  ChatData({
    required this.id,
    required this.date,
    required this.latestMessage,
    required this.users,
  });
  late final String id;
  late final String date;
  late final LatestMessage latestMessage;
  late final List<Users> users;

  ChatData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    date = json['date'];
    latestMessage = LatestMessage.fromJson(json['latest_message']);
    users = List.from(json['users']).map((e)=>Users.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['date'] = date;
    _data['latest_message'] = latestMessage.toJson();
    _data['users'] = users.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class LatestMessage {
  LatestMessage({
    required this.id,
    required this.content,
    required this.isRead,
    required this.sentAt,
    required this.isSent,
  });
  int? id;
  String? content;
  int? isRead;
  String? sentAt;
  bool? isSent;

  LatestMessage.fromJson(Map<String, dynamic> json){
    id = json['id'];
    content = json['content'];
    isRead = json['is_read'];
    sentAt = json['sent_at'];
    isSent = json['is_sent'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['content'] = content;
    _data['is_read'] = isRead;
    _data['sent_at'] = sentAt;
    _data['is_sent'] = isSent;
    return _data;
  }
}

class Users {
  Users({
    required this.id,
    required this.name,
    required this.type,
    required this.avatar,
  });
  int? id;
  String? name;
  int? type;
  Avatar? avatar;

  Users.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    type = json['type'];
    avatar = Avatar.fromJson(json['avatar']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['type'] = type;
    _data['avatar'] = avatar!.toJson();
    return _data;
  }
}