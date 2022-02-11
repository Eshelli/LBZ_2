class Cat {
  int? id;
  String? name;
  String? slug;
  int? parentId;
  Cat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['parent_id'] = parentId;
    return data;
  }
}