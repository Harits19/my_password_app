import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

extension BuildContextExtension on BuildContext {
  void pushAndReplace(Widget page) {
    print('pushAndReplace to $page');
    Navigator.pushReplacement(
        this, MaterialPageRoute(builder: ((context) => page)));
  }

  void  push(Widget page) {
    print('push to $page');
    Navigator.push(this, MaterialPageRoute(builder: ((context) => page)));
  }

  void popAll(Widget page) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    );
  }

  bool get isDarkMode {
    // var brightness = MediaQuery.of(this).platformBrightness;
    // bool isDarkMode = brightness == Brightness.dark;
    // return isDarkMode;

    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return isDarkMode;
  }

  Size get mSize => MediaQuery.of(this).size;
}
