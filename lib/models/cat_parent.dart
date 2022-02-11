class CategoryParent {
  int? id;
  String? name;
  String ?slug;
  int ?parentId;
  CategoryParent? parent;

  CategoryParent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    parentId = json['parent_id'];
    parent = json['parent'] != null ? CategoryParent.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['parent_id'] = parentId;
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    return data;
  }
}