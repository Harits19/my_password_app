import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_password_app/core/models/app_item.dart';
import 'package:my_password_app/core/services/secure_storage_service.dart';
import 'package:my_password_app/core/services/share_pref_service.dart';

class AppModel extends GetxController {
  RxList items = [].obs;

  Future<void> getItem() async {
    items.clear(); // reset items
    var temp = await SecureStorage.readStorageAppModel();
    if (temp != null) {
      var parsed = json.decode(temp) as List<dynamic>;
      print(parsed);
      for (var post in parsed) {
        items.add(AppItem.fromJson(post));
      }
    }
    updateItemPref();
  }

  Future<void> updateItemPref() async {
    await SecureStorage.writeStorageAppModel(data: items);
    print('called update pref');
  }

  Future<void> addItem({required AppItem appItem}) async {
    items.add(appItem);
    await updateItemPref();
  }

  Future<void> removeItem({required int index}) async {
    items.removeAt(index);
    await updateItemPref();
  }

  Future<void> removeAllItem() async {
    items.clear();
    await SharePref.removePrefsListApp();
  }
}
