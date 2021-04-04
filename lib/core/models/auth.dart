class Auth {
  String? pin;
  bool? isLocalAuth;

  Auth({this.pin, this.isLocalAuth});

  Auth.fromJson(Map<String, dynamic> json) {
    pin = json['pin'];
    isLocalAuth = json['isLocalAuth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pin'] = this.pin;
    data['isLocalAuth'] = this.isLocalAuth;
    return data;
  }
}
