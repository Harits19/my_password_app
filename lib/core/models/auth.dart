class Auth {
  String? pin;
  bool? useLocalAuth;

  Auth({this.pin, this.useLocalAuth});

  Auth.fromJson(Map<String, dynamic> json) {
    pin = json['pin'];
    useLocalAuth = json['use_local_auth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pin'] = this.pin;
    data['use_local_auth'] = this.useLocalAuth;
    return data;
  }
}
