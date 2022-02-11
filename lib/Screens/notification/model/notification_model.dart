import 'package:lbz/commen_models/models.dart';

class Noti {
  List<NotiData> data = [];
  late final Links links;
  late final Meta meta;

  Noti.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>NotiData.fromJson(e)).toList();
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

class NotiData {
  NotiData({
    required this.id,
    required this.content,
    required this.type,
    // required this.data,
    required this.isRead,
    required this.date,
  });
  late final String id;
  late final String content;
  late final String type;
  // late final Data data;
  late final bool isRead;
  late final String date;

  NotiData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    content = json['content'];
    type = json['type'];
    // data = Data.fromJson(json['data']);
    isRead = json['is_read'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['content'] = content;
    _data['type'] = type;
    // _data['data'] = data.toJson();
    _data['is_read'] = isRead;
    _data['date'] = date;
    return _data;
  }
}