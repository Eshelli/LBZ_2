class Images {
  late final int id;
  late final String url;
  late final String size;

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = url;
    data['size'] = size;
    return data;
  }
}
class Links {
   String? first;
   String? last;
   String? prev;
   String? next;

  Links.fromJson(Map<String, dynamic> json){
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first'] = first;
    _data['last'] = last;
    _data['prev'] = prev;
    _data['next'] = next;
    return _data;
  }
}

class Meta {
  late final int currentPage;
  int? from;
  int? lastPage;
  // late final List<MetaLinks>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    // links = List.from(json['links']).map((e)=>Links.fromJson(e)).toList();
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['from'] = from;
    _data['last_page'] = lastPage;
    // _data['links'] = links.map((e)=>e.toJson()).toList();
    _data['path'] = path;
    _data['per_page'] = perPage;
    _data['to'] = to;
    _data['total'] = total;
    return _data;
  }
}

class MetaLinks {
  String? url;
  String? label;
  bool? active;

  MetaLinks.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}

class Taxonomy {
  int? id;
  late final String? name;
  String? slug;
  String? icon;

  Taxonomy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['icon'] = icon;
    return data;
  }
}


class Package {
  Package({
    required this.id,
    required this.name,
    required this.color,
  });
  late final int id;
  late final String name;
  late final String color;

  Package.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['color'] = color;
    return _data;
  }
}

class Avatar {
  Avatar({
    required this.url,
    required this.size,
  });
  String? url;
  String? size;

  Avatar.fromJson(Map<String, dynamic> json){
    url = json['url'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['size'] = size;
    return _data;
  }
}
class City {
  City({
    required this.id,
    required this.name,
  });
  int? id;
  String? name;

  City.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}