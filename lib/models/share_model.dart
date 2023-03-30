import 'package:my_password_app/core/providers/sign_in/sign_in_state.dart';
import 'package:my_password_app/models/password_model.dart';

class ShareModel {
  final List<PasswordModel> passwords;
  final SignInState signInState;

  ShareModel({
    this.passwords = const [],
    required this.signInState,
  });

  ShareModel.fromJson(Map<String, dynamic> json)
      : passwords = (json['passwords'] as List)
            .map((e) => PasswordModel.fromJson(e))
            .toList(),
        signInState = SignInState.fromJson(json['signInState']);

  Map<String, dynamic> toJson() {
    return {
      'passwords': passwords.map((e) => e.toJson()).toList(),
      'signInState': signInState.toJson(),
    };
  }
}
