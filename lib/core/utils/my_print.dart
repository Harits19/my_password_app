import 'package:flutter/foundation.dart';

void myPrint(Object? object) {
  if (kReleaseMode) {
    return;
  }

  print(object);
}
