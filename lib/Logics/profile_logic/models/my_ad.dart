import 'package:lbz/commen_models/models.dart';
import 'package:lbz/models/ads_list.dart';
import 'package:lbz/models/cat.dart';

class MyAdsList {
  MyAdsList({
    required this.data,
    required this.links,
    required this.meta,
  });
  late final List<MyAdsData> data;
  late final Links links;
  late final Meta meta;

  MyAdsList.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>MyAdsData.fromJson(e)).toList();
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

class MyAdsData {
  MyAdsData({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.price,
    required this.phoneNumber,
    required this.city,
    required this.user,
    required this.category,
    required this.taxonomy,
    required this.images,
    required this.attributes,
    required this.isExpired,
    required this.expirationDate,
    required this.status,
    required this.isPublished,
  });
  late final String id;
  late final String title;
  String? location;
  late final String date;
  late final String price;
  late final String phoneNumber;
  late final City city;
  late final User user;
  late final Cat category;
  late final Taxonomy taxonomy;
  List<Images> images = [];
  List<Attributes> attributes = [];
  late final bool isExpired;
  String? expirationDate;
  int? remainingRefreshes;
  late final String? status;
  late final bool isPublished;
  Package? package;
  MyAdsData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    location = json['location'];
    date = json['date'];
    price = json['price'];
    phoneNumber = json['phone_number'];
    city = City.fromJson(json['city']);
    user = User.fromJson(json['user']);
    category = Cat.fromJson(json['category']);
    taxonomy = Taxonomy.fromJson(json['taxonomy']);
    images = List.from(json['images']).map((e)=>Images.fromJson(e)).toList();
    if (json['attributes'] != null) {
      json['attributes'].forEach((v) {
        attributes.add( Attributes.fromJson(v));
      });
    }
    package = json['package'] != null
        ? Package.fromJson(json['package'])
        : null;
    isExpired = json['is_expired'];
    expirationDate = json['expiration_date'];
    remainingRefreshes = json['remaining_refreshes'];
    status = json['status'];
    isPublished = json['is_published'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['location'] = location;
    _data['date'] = date;
    _data['price'] = price;
    _data['phone_number'] = phoneNumber;
    _data['city'] = city.toJson();
    _data['user'] = user.toJson();
    _data['category'] = category.toJson();
    _data['taxonomy'] = taxonomy.toJson();
    _data['images'] = images.map((e)=>e.toJson()).toList();
    _data['attributes'] = attributes;
    _data['is_expired'] = isExpired;
    _data['expiration_date'] = expirationDate;
    _data['status'] = status;
    _data['is_published'] = isPublished;
    return _data;
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