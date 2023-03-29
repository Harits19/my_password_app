import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  pushAndReplace(Widget page) {
    Navigator.pushReplacement(
        this, MaterialPageRoute(builder: ((context) => page)));
  }


  popAll(String routeName) {
    Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }
}
