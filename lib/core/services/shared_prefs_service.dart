import 'dart:convert';

import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/core/models/password_application_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _Key {
  isFirstLogin,
  useBiometric,
  listPassword,
}

class SharedPrefService {
  static SharedPreferences? prefs;

  static Future<void> initPrefService() async {
    prefs = await SharedPreferences.getInstance();
  }

  static bool isFirstInstall() {
    return prefs.getBoolV2(_Key.isFirstLogin);
  }

  static Future<void> setFirsInstall() async {
    await prefs.setBoolV2(_Key.isFirstLogin, true);
  }

  static bool useBiometric() {
    return prefs.getBoolV2(_Key.useBiometric);
  }

  static Future<void> setUseBiometric() async {
    await prefs.setBoolV2(_Key.useBiometric, true);
  }

  static Future<void> setListPassword(
    final List<PasswordModel> listPassword,
  ) async {
    final toJson = listPassword.map((e) => e.toJson()).toList();
    print('toJson $toJson');

    // return;
    final encoded = jsonEncode(toJson);
    await prefs.setStringV2(
      _Key.listPassword,
      encoded,
    );
  }

  static List<PasswordModel> getListPassword() {
    final fromJson = prefs.getStringV2(_Key.listPassword);
    if (fromJson.isNullEmpty) {
      return [];
    }

    final decoded = jsonDecode(fromJson!);
    if (decoded is List) {
      final result = decoded.map((e) => PasswordModel.fromJson(e));
      return result.toList();
    }
    return [];
  }
}

extension on SharedPreferences? {
  bool getBoolV2(_Key key) {
    return this?.getBool(key.name) ?? false;
  }

  Future<void> setBoolV2(_Key key, bool value) async {
    await this?.setBool(key.name, value);
  }

  String? getStringV2(_Key key) {
    return this?.getString(key.name);
  }

  Future<void> setStringV2(_Key key, String value) async {
    await this?.setString(key.name, value);
  }
}
