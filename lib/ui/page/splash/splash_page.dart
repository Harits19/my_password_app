import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("SplashScreen"),
      ),
    );
  }
}
