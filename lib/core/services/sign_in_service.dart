import 'dart:convert';

import 'package:my_password_app/core/providers/sign_in/sign_in_state.dart';
import 'package:my_password_app/core/services/services.dart';

const _keyMasterPassword = 'keyMasterPassword';

class SignInService {
  static Future<void> saveState(SignInState signInState) {
    return Services.prefs.setString(
      _keyMasterPassword,
      jsonEncode(signInState.toJson()),
    );
  }

  static SignInState getMasterPassword() {
    final result = Services.prefs.getString(_keyMasterPassword);
    if (result == null) return SignInState();
    return SignInState.fromJson(jsonDecode(result));
  }
}
