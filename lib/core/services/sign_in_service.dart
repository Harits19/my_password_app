import 'dart:convert';

import 'package:my_password_app/enums/pref_enum.dart';
import 'package:my_password_app/extensions/shared_pref_extension.dart';
import 'package:my_password_app/core/providers/sign_in/sign_in_state.dart';
import 'package:my_password_app/core/services/services.dart';


class SignInService {
  static Future<void> saveState(SignInState signInState) {
    return Services.prefs.setStringV2(
      PrefEnum.keyMasterPassword,
      jsonEncode(signInState.toJson()),
    );
  }

  static SignInState getMasterPassword() {
    final result = Services.prefs.getStringV2(PrefEnum.keyMasterPassword);
    if (result == null) return SignInState();
    return SignInState.fromJson(jsonDecode(result));
  }
}
