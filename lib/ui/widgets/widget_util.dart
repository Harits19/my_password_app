import 'package:flutter/material.dart';

class WidgetUtil {
  static safePop(BuildContext context) {
    checkWidget(() {
      Navigator.pop(context);
    });
  }

  static checkWidget(VoidCallback voidCallback) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      voidCallback();
    });
  }
}
