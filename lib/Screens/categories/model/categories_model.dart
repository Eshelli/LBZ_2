 class Section {
  late final int id;
  late final String name;
  late final String slug;
  late final String icon;
  late final List<Category> categories;
  late final List<dynamic> featuredAds;
  late final String? cover;

  Section.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    categories = List.from(json['categories']).map((e)=>Category.fromJson(e)).toList();
    featuredAds = List.castFrom<dynamic, dynamic>(json['featured_ads']);
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['icon'] = icon;
    _data['categories'] = categories.map((e)=>e.toJson()).toList();
    _data['featured_ads'] = featuredAds;
    _data['cover'] = cover;
    return _data;
  }
}

class Category {
  late final int id;
  late final String name;
  late final String slug;
  late final int? parentId;
  late final List<Category> categories;
  late final int? totalAds;

  Category.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    parentId = json['parent_id'];
    categories = List.from(json['categories']).map((e)=>Category.fromJson(e)).toList();
    totalAds = json['total_ads'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['parent_id'] = parentId;
    _data['categories'] = categories.map((e)=>e.toJson()).toList();
    _data['total_ads'] = totalAds;
    return _data;
  }
}