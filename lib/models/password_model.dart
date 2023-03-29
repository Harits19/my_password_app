import 'package:flutter/material.dart';

class PasswordModel {
  final String? name;
  final String? password;
  final String id;

  PasswordModel({
    String? id,
    required this.name,
    required this.password,
  }) : this.id = id ?? UniqueKey().toString();

  PasswordModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        password = json['password'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['password'] = this.password;
    data['id'] = this.id;
    return data;
  }

  @override
  bool operator ==(Object other){
    if (identical(this, other)) {
    return true;
  }
  if (other.runtimeType != runtimeType) {
    return false;
  }
  return other is PasswordModel
      && other.id == id;
  }
}
