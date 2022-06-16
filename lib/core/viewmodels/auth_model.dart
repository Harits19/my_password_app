import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_password_app/core/models/auth.dart';
import 'package:my_password_app/core/services/local_auth_service.dart';
import 'package:my_password_app/core/services/secure_storage_service.dart';

class AuthModel extends GetxController {
  RxBool loading = false.obs;
  RxBool error = false.obs;
  RxBool pending = false.obs;

  var data = Auth(pin: '', useLocalAuth: false).obs;

  @override
  void onInit() {
    super.onInit();
    getAuthModel();
    // deleteAll();
  }

  Future<void> getAuthModel() async {
    loading.toggle();
    //simulasi loading animation
    var temp = await SecureStorage.readStorageAuthModel();
    if (temp != null) {
      var parsed = json.decode(temp);
      print(parsed);

      data = Auth.fromJson(parsed).obs;
    } else {
      data = Auth(pin: '', useLocalAuth: false).obs;
    }
    loading.toggle();
  }

  Future<void> addAuthModel({required Auth auth}) async {
    await SecureStorage.writeStorageAuthModel(data: auth);
    var temp = await SecureStorage.readStorageAuthModel();
  }

  Future<void> deleteAll() async {
    await SecureStorage.deleteStorageAuthModel();
  }

  Future<bool> checkLocalAuth() async {
    return await LocalAuthService.isDeviceSupported();
  }

  Future<bool> runLocalAuth() async {
    return await LocalAuthService.authenticate();
  }
}
