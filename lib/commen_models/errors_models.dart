class MessageError {
  MessageError({
    required this.message,
    required this.errors,
  });
  String? message;
  Map<String,dynamic>?  errors;

  MessageError.fromJson(Map<String, dynamic> json){
    message = json['message'];
      errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['errors'] = errors;
    return _data;
  }
}