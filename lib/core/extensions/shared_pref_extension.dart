import 'package:my_password_app/core/enums/pref_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension SharedPrefExtension on SharedPreferences? {
  String? getStringV2(PrefEnum key) {
    return this?.getString(key.name);
  }

  Future<void> setStringV2(PrefEnum key, String value) async {
    await this?.setString(key.name, value);
  }
}
