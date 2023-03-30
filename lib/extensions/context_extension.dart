import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  pushAndReplace(Widget page) {
    Navigator.pushReplacement(
        this, MaterialPageRoute(builder: ((context) => page)));
  }

}
