import 'package:flutter/cupertino.dart';
import 'package:my_password_app/core/services/share_pref_service.dart';

class AppItem extends ChangeNotifier{
  String? name;
  String? password;

  AppItem({this.name, this.password});

  AppItem.fromJson(Map<String, dynamic> json) {
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
