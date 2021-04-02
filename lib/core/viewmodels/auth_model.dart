import 'package:my_password_app/core/enums/auth_state_enum.dart';

class AuthModel {
  late AuthStateEnum authWith;

  AuthModel({required this.authWith});

  AuthModel.initial() : this.authWith = AuthStateEnum.unknown;

  AuthModel.fromJson(Map<String, dynamic> json) {
    authWith = json['authWith'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authWith'] = this.authWith;
    return data;
  }
}
