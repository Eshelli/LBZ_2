class Sections {
  int? id;
  String ?name;
  String? slug;
  String? icon;
  List<Categories> categories = [];
  int? totalAds;

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    if (json['categories'] != null) {
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    totalAds = json['total_ads'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['icon'] = icon;
    if (categories != null) {
      data['categories'] = categories.map((v) => v.toJson()).toList();
    }
    data['total_ads'] = totalAds;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? slug;
  int? parentId;
  List<Categories> categories =[];

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    parentId = json['parent_id'];
    if (json['categories'] != null) {
      json['categories'].forEach((v) {
        categories.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    if (categories != null) {
      data['categories'] = categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}