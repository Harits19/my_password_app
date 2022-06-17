import 'package:flutter/cupertino.dart';

class KState {
  KState._();

  static void afterBuildDo(VoidCallback func) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      func();
    });
  }
}
