import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void pushAndReplace(Widget page) {
    Navigator.pushReplacement(
        this, MaterialPageRoute(builder: ((context) => page)));
  }

  void popAll(Widget page) {
    Navigator.of(this).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
        (Route<dynamic> route) => false);
  }
}
