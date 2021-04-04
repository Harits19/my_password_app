import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
    updateApp();
  }

  Future<void> updateApp() async {
    await SecureStorage.writeStorageAppModel(data: items);
    print('called update pref');
  }

  Future<void> addApp({required App appItem}) async {
    items.add(appItem);
    await updateApp();
  }

  Future<void> removeApp({required int index}) async {
    items.removeAt(index);
    await updateApp();
  }

  Future<void> removeAllApp() async {
    items.clear();
    await SharePref.removePrefsListApp();
  }
}
