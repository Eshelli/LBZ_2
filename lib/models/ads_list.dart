import 'package:lbz/commen_models/models.dart';
import 'package:lbz/models/popular_ads.dart';

import 'cat.dart';

class Ads_List {
  List<DataList> data = [];
  Links? links;
  Meta? meta;

  Ads_List.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(DataList.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null){
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class DataList {
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
  DataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    location = json['location'];
    date = json['date'];
    price = json['price'];
    phoneNumber = json['phone_number'];
    package = json['package'] != null
        ? Package.fromJson(json['package'])
        : null;
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['location'] = location;
    data['date'] = date;
    data['price'] = price;
    data['phone_number'] = phoneNumber;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (taxonomy != null) {
      data['taxonomy'] = taxonomy!.toJson();
    }
    if (images != null) {
      data['images'] = images.map((v) => v.toJson()).toList();
    }
    if (attributes != null) {
      data['attributes'] = attributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.type,
    required this.avatar,
  });
  int? id;
   String? name;
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



class Attributes {
  late final int id;
  late final String value;
  late final Atb atb;

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value =
    json['value'];
    atb = (json['attribute'] != null
        ? Atb.fromJson(json['attribute'])
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
  int? id;
  String? name;
  int? attributeId;

  Option.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    attributeId = json['attribute_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['attribute_id'] = attributeId;
    return data;
  }
}

class Atb {
  late final int id;
  late final String name;
  String? icon;
  String? type;

  Atb.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    return data;
  }
}