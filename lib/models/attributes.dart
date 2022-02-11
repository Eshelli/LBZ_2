class Attribute {
  int? id;
  String? name;
  String? icon;
  String? type;
  List<Option>? options = [];

  Attribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    type = json['type'];
    if (json['options'] != null) {
      json['options'].forEach((v) {
        options!.add(Option.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    data['type'] = type;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Option {
  int? id;
  String? name;
  int? attributeId;

  Option({this.id, this.name, this.attributeId});

  Option.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    attributeId = json['attribute_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['attribute_id'] = attributeId;
    return data;
  }
}