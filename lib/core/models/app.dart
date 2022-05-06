import 'package:flutter/cupertino.dart';
import 'package:my_password_app/core/services/share_pref_service.dart';

class App {
  String? name;
  String? password;

  App({required this.name, required this.password});

  App.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['password'] = this.password;
    return data;
  }
}