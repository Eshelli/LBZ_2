import 'package:libozzle/commen_models/models.dart';
import 'package:libozzle/models/ads_list.dart';
import 'package:libozzle/models/popular_ads.dart';

import 'cat.dart';

class AdDetails {
  String? id;
  String? title;
  String? description;
  String? price;
  String? phoneNumber;
  String? location;
  String? latitude;
  String? longitude;
  String? date;
  City? city;
  bool? isFav;
  User? user;
  Cat? category;
  Taxonomy? taxonomy;
  List<Images> images = [];
  List<Attributes> attributes = [];

  AdDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    phoneNumber = json['phone_number'];
    location = json['location'];
    isFav = json['is_favorite'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    city = City.fromJson(json['city']);
    date = json['date'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    category = json['category'] != null
        ? Cat.fromJson(json['category'])
        : null;
    taxonomy = json['taxonomy'] != null
        ? Taxonomy.fromJson(json['taxonomy'])
        : null;
    if (json['images'] != null) {
      json['images'].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      json['attributes'].forEach((v) {
        attributes.add(Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['is_favorite'] = isFav;
    data['description'] = description;
    data['price'] = price;
    data['phone_number'] = phoneNumber;
    data['location'] = location;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['date'] = date;
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