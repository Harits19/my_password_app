import 'package:flutter/material.dart';

class KNavigator {
  KNavigator._();

  static pushAndReplace(BuildContext context, Widget page) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((context) => page)));
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }
}
