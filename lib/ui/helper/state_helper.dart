import 'package:flutter/cupertino.dart';

class StateHelper {
  StateHelper._();

  static void afterBuildDo(VoidCallback func) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      func();
    });
  }
}
