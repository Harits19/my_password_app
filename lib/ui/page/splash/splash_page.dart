import 'package:flutter/material.dart';
import 'package:my_password_app/ui/page/onboarding/onboarding_page.dart';
import 'package:my_password_app/utils/k_navigator.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      KNavigator.popAll(context, OnboardingPage.routeName);
    });
    return Scaffold(
      body: Center(
        child: Text("Loading"),
      ),
    );
  }
}
