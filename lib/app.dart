import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/ui/pages/splash/splash_page.dart';
import 'package:my_password_app/ui/pages/guard/guard_screen.dart';

class App extends ConsumerStatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );
    final inputDecorationTheme = InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );

    return HandleTimeOutWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark().copyWith(
          cardTheme: CardTheme(
            shape: shape,
          ),
          listTileTheme: ListTileThemeData(
            shape: shape,
          ),
          inputDecorationTheme: inputDecorationTheme.copyWith(
            fillColor: ThemeData.dark().cardColor,
          ),
        ),
        themeMode: ThemeMode.system,
        navigatorKey: navigatorKey,
        theme: ThemeData.light().copyWith(
          cardTheme: CardTheme(
            shape: shape,
          ),
          listTileTheme: ListTileThemeData(
            shape: shape,
          ),
          inputDecorationTheme: inputDecorationTheme.copyWith(
            fillColor: ThemeData.light().cardColor,
          ),
        ),
        home: SplashPage(),
      ),
    );
  }
}

final navigatorKey = GlobalKey<NavigatorState>();
