import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static late SharedPreferences prefs;

  static Future<void> initializePrefInstances() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setPrefsListApp({required data}) async {
    final result = jsonEncode(data);
    print(result);
    await prefs.setString('AppModel', result);
  }

  static Future<dynamic> getPrefsListApp() async {
    final result = prefs.getString('AppModel');
    return result;
  }

  static Future<void> removePrefsListApp() async {
    await prefs.setString('AppModel', '');
  }

  static Future<void> removeAllSavedDataPref() async {
    await prefs.clear();
  }
}
