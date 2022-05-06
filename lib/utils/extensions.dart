import 'package:flutter/material.dart';

class KExtension {
  KExtension._();
}

extension StringExtension on String? {
  bool get isNullEmpty {
    return this?.isEmpty ?? true;
  }
}
