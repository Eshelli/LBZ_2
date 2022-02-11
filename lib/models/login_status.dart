class LoginStatus {
  late final bool loggedIn;

  LoginStatus.fromJson(Map<String, dynamic> json) {
    loggedIn = json['logged_in'];
    if (json['user'] != null) {
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['logged_in'] = loggedIn;
    return _data;
  }
}

