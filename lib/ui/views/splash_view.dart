import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_password_app/ui/shared/custom_styles.dart';
import 'package:my_password_app/ui/views/auth_view.dart';

class SplashView extends StatelessWidget {
  Future<Timer> startSplashScreen(context) async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    startSplashScreen(context);
    final screenData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Icon(
                  Icons.lock,
                  size: screenData.size.height * 0.3,
                ),
              ),
              // Image.asset(ImageAssets.splashScreenIcon),
              const Text(
                'My Password App',
                style: CustomStyle.titleStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
