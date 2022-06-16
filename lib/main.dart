import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_password_app/konstan/k_assets.dart';
import 'package:my_password_app/ui/page/home/home_page.dart';
import 'package:my_password_app/ui/page/onboarding/onboarding_page.dart';
import 'package:my_password_app/ui/page/splash/splash_page.dart';
import 'package:my_password_app/utils/app_bloc_observer.dart';
import 'package:my_password_app/utils/k_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupDependencyInjection();
  final useDevicePreview =
      !kReleaseMode && !Platform.isAndroid && !Platform.isIOS;
  BlocOverrides.runZoned(() {
    runApp(
      EasyLocalization(
        child: DevicePreview(
          enabled: useDevicePreview,
          builder: (context) => App(),
        ),
        supportedLocales: [
          Locale('en', 'US'),
          Locale('id', 'ID'),
        ],
        path: KAssets.translations,
      ),
    );
  }, blocObserver: AppBlocObserver());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: SplashScreen.routeName,
      useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        OnboardingPage.routeName: (context) => const OnboardingPage(),
        HomePage.routeName: (context) => const HomePage(),
      },
    );
  }
}
