import 'dart:convert';

import 'package:my_password_app/core/models/master_password_model.dart';
import 'package:my_password_app/core/services/services.dart';

const _keyMasterPassword = 'keyMasterPassword';

class SignInService {
  static Future<void> saveMasterPassword(
      MasterPasswordModel masterPasswordModel) {
    return Services.prefs.setString(
      _keyMasterPassword,
      jsonEncode(masterPasswordModel.toJson()),
    );
  }

  static final getMasterPassword = () {
    final result = Services.prefs.getString(_keyMasterPassword) ?? '';
    return MasterPasswordModel.fromJson(jsonDecode(result));
  };
}
