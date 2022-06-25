import 'package:flutter/material.dart';

class KLocale {
  KLocale._();

  static const id = Locale('id', 'ID');
  static const en = Locale("en", "US");

  static Locale get idDebug {
    print("called idDebug");
    return id;
  }

  static const supportedLocale = [id, en];
}
