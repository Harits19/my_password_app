import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/cubits/password/password_cubit.dart';
import 'package:my_password_app/cubits/theme/theme_cubit.dart';
import 'package:my_password_app/routes.dart';
import 'package:my_password_app/ui/app_ui/app_ui.dart';
import 'package:my_password_app/ui/pages/splash/splash_page.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => PasswordCubit()),
        BlocProvider(create: (_) => ThemeCubit())
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen.routeName,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            builder: (BuildContext builderContext, Widget? child) => Overlay(
              initialEntries: <OverlayEntry>[
                OverlayEntry(
                  builder: (BuildContext context) => AppLifecycleOverlay(
                    child: child,
                  ),
                )
              ],
            ),
            theme: () {
              if (state is ThemeDarkMode)
                return MyTheme.dark;
              else
                return MyTheme.light;
            }(),
            routes: {
              ...kRoute.map((key, value) => MapEntry(key, (_) => value))
            },
          );
        },
      ),
    );
  }
}

class AppLifecycleOverlay extends StatefulWidget {
  const AppLifecycleOverlay({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget? child;

  @override
  State<AppLifecycleOverlay> createState() => _AppLifecycleOverlayState();
}

class _AppLifecycleOverlayState extends State<AppLifecycleOverlay>
    with WidgetsBindingObserver {
  bool _shouldBlur = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final state = WidgetsBinding.instance.lifecycleState;
    if (state == null) return;
    _updateBlurState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _updateBlurState(state);
  }

  void _updateBlurState(AppLifecycleState state) {
    _shouldBlur = state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_shouldBlur) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200.withOpacity(0.5),
        ),
      );
    }

    return widget.child ?? SizedBox();
  }
}
