import 'package:flutter/material.dart';

class ThemeState {
  final Brightness? brightness;
  final ThemeMode themeMode;

  ThemeState({
    required this.brightness,
    required this.themeMode,
  });

  ThemeState copyWith({
    Brightness? brightness,
    ThemeMode? themeMode,
  }) =>
      ThemeState(
        brightness: brightness ?? this.brightness,
        themeMode: themeMode ?? this.themeMode,
      );
}
