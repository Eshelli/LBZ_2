class LoginModel {
  bool? success;
  String? token;

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    data['token'] = token;
    return data;
  }
}