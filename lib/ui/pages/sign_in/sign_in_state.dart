import 'package:my_password_app/extensions/string_extension.dart';

class SignInState {
  final bool isLoggedIn;
  final String? password;
  final bool useFingerprint;

  SignInState({
    this.password,
    this.isLoggedIn = false,
    this.useFingerprint = false,
  });

  SignInState copyWith({
    bool? isLoggedIn,
    bool? useFingerprint,
  }) {
    return SignInState(
      password: password,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      useFingerprint: useFingerprint ?? this.useFingerprint,
    );
  }

  SignInState.fromJson(Map<String, dynamic> json)
      : this.password = json['password'],
        this.useFingerprint = json['useFingerprint'],
        this.isLoggedIn = false;

  Map<String, dynamic> toJson() => {
        'password': this.password,
        'useFingerprint': this.useFingerprint,
      };
  bool get haveMasterPassword => (password).isNotNullEmpty;
}
