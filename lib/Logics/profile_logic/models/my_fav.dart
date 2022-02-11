import 'package:lbz/commen_models/models.dart';
import 'package:lbz/models/cat.dart';

class MyFavList {
  List<MyFavData> data = [];
  Links? links;
  Meta? meta;

  MyFavList.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>MyFavData.fromJson(e)).toList();
    links = Links.fromJson(json['links']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['links'] = links!.toJson();
    _data['meta'] = meta!.toJson();
    return _data;
  }
}

class MyFavData {
  // late final String id;
  // late final String title;
  // String? location;
  // late final String date;
  // late final String price;
  // late final String phoneNumber;
  // User? user;
  // late final Cat category;
  // late final Taxonomy taxonomy;
  // List<Images> images = [];
  // List<Attributes> attributes = [];
  // City? city;
  // Package? package;

  String? id;
  String? title;
  String? location;
  String? date;
  String? price;
  String? phoneNumber;
  User? user;
  Cat? category;
  Taxonomy? taxonomy;
  List<Images> images = [];
  List<Attributes> attributes = [];
  Package? package;
  MyFavData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    location = json['location'];
    date = json['date'];
    price = json['price'];
    phoneNumber = json['phone_number'];
    user = (json['user'] != null ? User.fromJson(json['user']) : null)!;
    category = (json['category'] != null
        ? Cat.fromJson(json['category'])
        : null)!;
    taxonomy = (json['taxonomy'] != null
        ? Taxonomy.fromJson(json['taxonomy'])
        : null)!;
    if (json['images'] != null) {
      json['images'].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      json['attributes'].forEach((v) {
        attributes.add( Attributes.fromJson(v));
      });
    }
    package = json['package'] != null
        ? Package.fromJson(json['package'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['location'] = location;
    _data['date'] = date;
    _data['price'] = price;
    _data['phone_number'] = phoneNumber;
    _data['user'] = user!.toJson();
    _data['category'] = category!.toJson();
    _data['taxonomy'] = taxonomy!.toJson();
    _data['images'] = images.map((e)=>e.toJson()).toList();
    _data['attributes'] = attributes.map((e)=>e.toJson()).toList();
    return _data;
  }
}



class User {
  User({
    required this.id,
    required this.name,
    required this.type,
  });
  late final int id;
  late final String name;
  late final int type;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['type'] = type;
    return _data;
  }
}

class Attributes {
  late final int id;
  late final String value;
  late final Attribute atb;

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value =
    json['value'];
    atb = (json['attribute'] != null
        ? Attribute.fromJson(json['attribute'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;

    data['value'] = value;
    if (atb != null) {
      data['attribute'] = atb.toJson();
    }
    return data;
  }
}

class Option {
  Option({
    required this.id,
    required this.name,
    required this.attributeId,
  });
  late final int id;
  late final String name;
  late final int attributeId;

  Option.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    attributeId = json['attribute_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['attribute_id'] = attributeId;
    return _data;
  }
}

class Attribute {
  late final int id;
  late final String name;
  String? icon;

  Attribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    return data;
  }
}