import 'package:flutter/material.dart';
import 'package:my_password_app/core/viewmodels/auth_model.dart';

import 'package:get/get.dart';
import 'package:my_password_app/ui/views/splash_view.dart';

void mainOld() {
  final AuthModel authModel = Get.put(AuthModel());
  runApp(
    GetMaterialApp(
      home: SplashView(),
      theme: ThemeData.dark(),
    ),
  );
}

void main(){
runApp(
    MaterialApp(
      home: SplashView(),
      theme: ThemeData.dark(),
    ),
  );
}
