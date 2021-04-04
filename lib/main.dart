import 'package:flutter/material.dart';
import 'package:my_password_app/binding.dart';
import 'package:my_password_app/core/viewmodels/auth_model.dart';
import 'package:my_password_app/core/viewmodels/local_auth_model.dart';
import 'package:my_password_app/ui/views/auth_view.dart';
import 'package:my_password_app/ui/views/home_view.dart';

import 'package:get/get.dart';
import 'package:my_password_app/ui/views/splash_view.dart';

void main() {
  final AuthModel authModel = Get.put(AuthModel());
  runApp(
    GetMaterialApp(
      home: SplashView(),
      theme: ThemeData.dark(),
    ),
  );
}
