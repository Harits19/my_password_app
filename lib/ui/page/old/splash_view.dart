import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_password_app/ui/page/old/auth_view.dart';
// import 'package:get/get.dart';
import 'package:my_password_app/konstan/k_assets.dart';
import 'package:my_password_app/utils/k_navigator.dart';

class SplashView extends StatelessWidget {
  Future<Timer> _startSplashScreen(BuildContext context) async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      KNavigator.pushAndReplace(context, CheckAuth());
    });
  }

  @override
  Widget build(BuildContext context) {
    _startSplashScreen(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Image.asset(KAssets.letterIconAppDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
