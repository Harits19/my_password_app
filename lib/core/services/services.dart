import 'package:shared_preferences/shared_preferences.dart';

class Services {
  static late  SharedPreferences prefs;

  static Future<void> initPrefService() async {
    prefs = await SharedPreferences.getInstance();
  }

}
