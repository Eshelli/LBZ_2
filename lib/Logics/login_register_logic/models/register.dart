class RegisterModel {
  bool? success;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    return data;
  }
}