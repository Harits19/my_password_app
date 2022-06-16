import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_password_app/core/models/app.dart';
import 'package:my_password_app/core/services/secure_storage_service.dart';
import 'package:my_password_app/core/services/share_pref_service.dart';

class AppModel extends GetxController {
  RxList items = [].obs;

  Future<void> getApp() async {
    items.clear(); // reset items
    var temp = await SecureStorage.readStorageAppModel();
    if (temp != null) {
      var parsed = json.decode(temp) as List<dynamic>;
      print(parsed);
      for (var post in parsed) {
        items.add(App.fromJson(post));
      }
    }
    updateAppData();
  }

  Future<void> updateAppData() async {
    await SecureStorage.writeStorageAppModel(data: items);
    print('called update pref');
  }

  Future<void> addAppItem({required App appItem}) async {
    items.add(appItem);
    await updateAppData();
  }

  Future<void> updateAppItem({required App appItem, required int index}) async {
    items.elementAt(index).name = appItem.name;
    items.elementAt(index).password = appItem.password;
    print(items.elementAt(index));
    await updateAppData();
    await getApp();
  }

  Future<void> removeApp({required int index}) async {
    items.removeAt(index);
    await updateAppData();
  }

  Future<void> removeAllApp() async {
    items.clear();
    await SharePref.removePrefsListApp();
  }
}
