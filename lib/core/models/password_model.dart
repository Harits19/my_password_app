import 'package:flutter/material.dart';

class PasswordModel {
  final String? email;
  final String name;
  final String password;
  final String? note;

  PasswordModel({
    required this.name,
    required this.password,
    this.note,
    this.email,
  });

  PasswordModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        password = json['password'],
        note = json['note'],
        email = json['email'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['password'] = this.password;
    data['note'] = this.note;
    data['email'] = this.email;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is PasswordModel &&
        other.email == email &&
        other.name == name &&
        other.password == password &&
        other.note == note;
  }

  @override
  int get hashCode => Object.hash(email, name, password, note);
}
