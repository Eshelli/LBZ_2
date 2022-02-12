import 'package:lbz/commen_models/models.dart';

class GetChatId {
  GetChatId({
    required this.user,
    required this.chat,
  });
  late final User user;
  Chat? chat;
  GetChatId.fromJson(Map<String, dynamic> json){
    user = User.fromJson(json['user']);
    chat = Chat.fromJson(json['chat']);
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.type,
    required this.avatar,
  });
  late final int id;
  late final String name;
  late final int type;
  late final Avatar avatar;

  User.fromJson(Map<String, dynamic> json){
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
    _data['avatar'] = avatar.toJson();
    return _data;
  }
}

class Chat {
  Chat({
    required this.id,
    required this.date,
    required this.users,
  });
  late final String id;
  late final String date;
  late final List<Users> users;

  Chat.fromJson(Map<String, dynamic> json){
    id = json['id'];
    date = json['date'];
    users = List.from(json['users']).map((e)=>Users.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['date'] = date;
    _data['users'] = users.map((e)=>e.toJson()).toList();
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
  late final int id;
  late final String name;
  late final int type;
  late final Avatar avatar;

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
    _data['avatar'] = avatar.toJson();
    return _data;
  }
}