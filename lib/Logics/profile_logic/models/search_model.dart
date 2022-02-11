
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:lbz/commen_models/models.dart';

class MySearch {
  MySearch({
    required this.links,
    required this.meta,
  });
  late final List<DataSearch> data;
  Links? links;
  Meta? meta;

  MySearch.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>DataSearch.fromJson(e)).toList();
    links = Links.fromJson(json['links']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['links'] = links!.toJson();
    _data['meta'] = meta!.toJson();
    return _data;
  }
}

class DataSearch {
  DataSearch({
    required this.id,
    required this.title,
    required this.parameters,
    required this.date,
    required this.notifiable,
  });
  late final int id;
  late final String title;
  late final Parameters parameters;
  late final String date;
  late final int notifiable;

  DataSearch.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    parameters = Parameters.fromJson(json['parameters']);
    date = json['date'];
    notifiable = json['notifiable'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['parameters'] = parameters.toJson();
    _data['date'] = date;
    _data['notifiable'] = notifiable;
    return _data;
  }
}

class Parameters {
  Parameters({
    required this.priceFrom,
    required this.priceTo,
    required this.keywords,
    this.city,
    required this.taxonomy,
    required this.category,
  });
  late final dynamic priceFrom;
  late final dynamic priceTo;
  late final String? keywords;
  late final String? city;
  late final String taxonomy;
  late final String? category;
  late final Map<String,dynamic> att = {};
  

Parameters.fromJson(Map<String, dynamic> json){
    priceFrom = json['price_from'];
    priceTo = json['price_to'];
keywords = json['keywords'];
city = json['city'];
taxonomy = json['taxonomy'];
category = json['category'];
json.entries.forEach((element) {
   att.addIf(element.key.startsWith('attribute_'),element.key, element.value);
});
}

Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['price_from'] = priceFrom;
  _data['price_to'] = priceTo;
  _data['keywords'] = keywords;
  _data['city'] = city;
  _data['taxonomy'] = taxonomy;
  _data['category'] = category;
  return _data;
}
}