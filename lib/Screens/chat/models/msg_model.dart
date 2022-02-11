import 'package:lbz/commen_models/models.dart';

class Messages {
  Messages({
    required this.data,
    required this.links,
    required this.meta,
  });
  late final List<MessagesData> data;
  late final Links links;
  late final Meta meta;

  Messages.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>MessagesData.fromJson(e)).toList();
    links = Links.fromJson(json['links']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['links'] = links.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class MessagesData {
  MessagesData({
    required this.content,
    required this.isRead,
    required this.sentAt,
    required this.senderId,
  });
  late final int id;
  late final String content;
  int? isRead;
  late final String sentAt;
  late final int senderId;

  MessagesData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    content = json['content'];
    isRead = json['is_read'];
    sentAt = json['sent_at'];
    senderId = json['sender_id'];
  }

  Map<String, dynamic> toJson(){
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['content'] = content;
    _data['is_read'] = isRead;
    _data['sent_at'] = sentAt;
    _data['sender_id'] = senderId;
    return _data;
  }
}