import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_password_app/core/utils/my_print.dart';
import 'package:my_password_app/ui/widgets/loading_widget.dart';

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
