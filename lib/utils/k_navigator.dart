import 'package:flutter/material.dart';

class KNavigator {
  KNavigator._();

  static pushAndReplace(BuildContext context, Widget page) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((context) => page)));
  }
}
