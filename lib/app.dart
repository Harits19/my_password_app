import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/ui/pages/splash/splash_page.dart';

// TODO mengubah menjadi aplikasi full offiline
// TODO app can send file backup via bluetooth
// TODO

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: Theme.of(context).copyWith(
        cardTheme: CardTheme(
          shape: shape,
        ),
        listTileTheme: ListTileThemeData(
          shape: shape,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Theme.of(context).cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: SplashPage(),
    );
  }
}

final navigatorKey = GlobalKey<NavigatorState>();
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
