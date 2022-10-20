import 'package:flutter/material.dart';

enum KLocale {
  id(value: Locale('id', 'ID')),
  en(value: Locale("en", "US"));

  const KLocale({required this.value});

  final Locale value;
}
