import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final storage = FlutterSecureStorage();

  static Future<void> writeStorageAppModel({required data}) async {
    final result = json.encode(data);
    await storage.write(key: 'AppModel', value: result);
  }

  static Future<dynamic> readStorageAppModel() async {
    final result = await storage.read(key: 'AppModel');
    return result;
  }

  static Future<void> deleteStorageAppModel() async {
    await storage.delete(key: 'AppModel');
  }
}
