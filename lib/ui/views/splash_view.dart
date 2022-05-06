import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_password_app/ui/shared/custom_styles.dart';
import 'package:my_password_app/ui/shared/image_assets.dart';
import 'package:my_password_app/ui/views/auth_view.dart';

class SplashView extends StatelessWidget {
  Future<Timer> startSplashScreen(context) async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Get.off(() => CheckAuth());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Image.asset(AssetConst.letterIconAppDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
