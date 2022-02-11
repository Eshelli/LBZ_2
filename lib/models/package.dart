class NewPackage {
  NewPackage({
    required this.id,
    required this.name,
    required this.price,
    required this.order,
    required this.activeDays,
    required this.featuredDays,
    required this.numberOfRefreshes,
    required this.color,
  });
  late final int id;
  late final String name;
  late final double price;
  late final int order;
  late final int activeDays;
  late final int featuredDays;
  late final int numberOfRefreshes;
  late final String color;

  NewPackage.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    price = json['price'].toDouble();
    order = json['order'];
    activeDays = json['active_days'];
    featuredDays = json['featured_days'];
    numberOfRefreshes = json['number_of_refreshes'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['price'] = price;
    _data['order'] = order;
    _data['active_days'] = activeDays;
    _data['featured_days'] = featuredDays;
    _data['number_of_refreshes'] = numberOfRefreshes;
    _data['color'] = color;
    return _data;
  }
}