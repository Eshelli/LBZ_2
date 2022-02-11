import 'package:libozzle/commen_models/models.dart';
import 'package:libozzle/models/countries.dart';

class UserData {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? gender;
  String? type;
  String? dob;
  Countries? country;
  Company? company;
  int? adsCount;
  int? visitsCount;
  int? searchesCount;
  int? favoriteCount;
  String? balance;
  Avatar? avatar;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    type = json['type'];
    dob = json['dob'];
    country =
    json['country'] != null ? Countries.fromJson(json['country']) : null;
    company = json['company'] != null ? Company.fromJson(json['company']) : null;
    adsCount = json['ads_count'];
    visitsCount = json['visits_count'];
    searchesCount = json['searches_count'];
    favoriteCount = json['favorite_count'];
    balance = json['balance'];
    avatar =
    json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['gender'] = gender;
    data['type'] = type;
    data['dob'] = dob;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['ads_count'] = adsCount;
    data['visits_count'] = visitsCount;
    data['searches_count'] = searchesCount;
    data['favorite_count'] = favoriteCount;
    data['balance'] = balance;
    if (avatar != null) {
      data['avatar'] = avatar!.toJson();
    }
    return data;
  }
}
class Company {
  Company({
    required this.name,
    required this.description,
    required this.licenseNumber,
    required this.field,
    required this.size,
    required this.phoneNumber,
    required this.websiteLink,
    required this.location,
  });
  late final String name;
  late final String description;
  late final String licenseNumber;
  late final String field;
  late final String size;
  late final String phoneNumber;
  late final String websiteLink;
  late final String location;
  bool isApproved = false;

  Company.fromJson(Map<String, dynamic> json){
    name = json['name'];
    description = json['description'];
    licenseNumber = json['license_number'];
    field = json['field'];
    size = json['size'];
    phoneNumber = json['phone_number'];
    websiteLink = json['website_link'];
    location = json['location'];
    isApproved = json['is_approved'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['description'] = description;
    _data['license_number'] = licenseNumber;
    _data['field'] = field;
    _data['size'] = size;
    _data['phone_number'] = phoneNumber;
    _data['website_link'] = websiteLink;
    _data['location'] = location;
    return _data;
  }
}