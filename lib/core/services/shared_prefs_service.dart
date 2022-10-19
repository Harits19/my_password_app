import 'package:shared_preferences/shared_preferences.dart';

enum _Key {
  isFirstLogin,
  password,
  useBiometric,
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

  static String getPassword() {
    return prefs.getStringV2(_Key.password);
  }

  static Future<void> setPassword(String password) async {
    assert(password.isNotEmpty);
    await prefs.setStringV2(_Key.password, password);
  }

  static bool useBiometric() {
    return prefs.getBoolV2(_Key.useBiometric);
  }

  static Future<void> setUseBiometric() async {
    await prefs.setBoolV2(_Key.useBiometric, true);
  }

}

extension on SharedPreferences? {
  bool getBoolV2(_Key key) {
    return this?.getBool(key.name) ?? false;
  }

  Future<void> setBoolV2(_Key key, bool value) async {
    await this?.setBool(key.name, value);
  }

  String getStringV2(_Key key) {
    return this?.getString(key.name) ?? '';
  }

  Future<void> setStringV2(_Key key, String value) async {
    await this?.setString(key.name, value);
  }
}
