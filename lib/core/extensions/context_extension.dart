import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void push(Widget page) {
    print('push to $page');
    Navigator.push(this, MaterialPageRoute(builder: ((context) => page)));
  }

  void popAll(Widget page) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    );
  }

  Size get mSize => MediaQuery.of(this).size;
}
