
import 'package:lbz/commen_models/models.dart';

import 'cat.dart';

class Pop {
  int? id;
  String? name;
  String? slug;
  String? icon;
  List<PopularAds> popularAds = [];
  Pop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    if (json['popular_ads'] != null) {
      json['popular_ads'].forEach((v) {
        popularAds.add(PopularAds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['icon'] = icon;
    if (popularAds != null) {
      data['popular_ads'] = popularAds.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PopularAds {
  late final String id;
  String? title;
  String? location;
  String? date;
  String? price;
  String? phoneNumber;
  late final Cat category;
  late final Taxonomy taxonomy;
  List<Images> images = [];

  PopularAds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    location = json['location'];
    date = json['date'];
    price = json['price'];
    phoneNumber = json['phone_number'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['location'] = location;
    data['date'] = date;
    data['price'] = price;
    data['phone_number'] = phoneNumber;
    if (category != null) {
      data['category'] = category.toJson();
    }
    if (taxonomy != null) {
      data['taxonomy'] = taxonomy.toJson();
    }
    if (images != null) {
      data['images'] = images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




