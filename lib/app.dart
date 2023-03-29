import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/providers/theme/theme_notifier.dart';
import 'package:my_password_app/routes.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:my_password_app/ui/widgets/handle_time_out_widget.dart';

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
    return HandleTimeOutWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SignInPage.routeName,
        darkTheme: ThemeData.dark(),
        themeMode: ref.watch(themeProvider),
        routes: {...kRoute.map((key, value) => MapEntry(key, (_) => value))},
      ),
    );
  }
}
