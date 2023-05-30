import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/ui/pages/theme_state.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>(
  (ref) => ThemeNotifier(
    ThemeState(
      brightness: null,
      themeMode: ThemeMode.system,
    ),
  )..init(),
);

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier(super.state);

  void init() {
    state = state.copyWith(
      brightness:
          SchedulerBinding.instance.platformDispatcher.platformBrightness,
    );
  }

  void setTheme(ThemeMode themeMode) async {
    state = state.copyWith(
      themeMode: themeMode,
    );
  }
}
