import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static late SharedPreferences prefs;

  static Future<void> initializePrefInstances() async {
    prefs = await SharedPreferences.getInstance();
  }

  // static Future<void> setPrefsAuthWith({required value}) async {
  //   await initializePrefInstances();
  //   await prefs.setString('AuthWith', value.toString());
  // }
  //
  // static Future<String?> getPrefsAuthWith() async {
  //   await initializePrefInstances();
  //   return prefs.getString('AuthWith');
  // }

  static Future<void> setPrefsListApp({required data}) async {
    await initializePrefInstances();
    final result = jsonEncode(data);
    print(result);
    await prefs.setString('AppModel', result);
  }

  static Future<dynamic> getPrefsListApp() async {
    await initializePrefInstances();
    final result = prefs.getString('AppModel');
    return result;
  }

  static Future<void> removePrefsListApp() async {
    await initializePrefInstances();
    await prefs.setString('AppModel', '');
  }
}
