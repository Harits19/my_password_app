import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/core/services/share_pref_service.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/cubits/password/password_cubit.dart';
import 'package:my_password_app/firebase_options.dart';

import 'package:my_password_app/konstan/k_assets.dart';
import 'package:my_password_app/konstan/k_locale.dart';
import 'package:my_password_app/ui/pages/home/home_page.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:my_password_app/ui/pages/splash/splash_page.dart';
import 'package:my_password_app/utils/app_bloc_observer.dart';
import 'package:my_password_app/utils/k_injection.dart';
import 'package:my_password_app/utils/k_state.dart';

/// TODO : Implement change language

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  await setupDependencyInjection();
  await SharePref.initializePrefInstances();
  BlocOverrides.runZoned(() {
    runApp(
      EasyLocalization(
        child: App(),
        supportedLocales: KLocale.supportedLocale,
        fallbackLocale: KLocale.id,
        path: KAssets.translations,
        saveLocale: true,
        startLocale: KLocale.id,
      ),
    );
  }, blocObserver: AppBlocObserver());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(),
        ),
        BlocProvider(
          create: (_) => PasswordCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        initialRoute: SplashScreen.routeName,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          SignInPage.routeName: (context) => const SignInPage(),
          HomePage.routeName: (context) => const HomePage(),
        },
      ),
    );
  }
}
