import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/ui/app_ui/app_ui.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/cubits/password/password_cubit.dart';
import 'package:my_password_app/cubits/theme/theme_cubit.dart';
import 'package:my_password_app/firebase_options.dart';

import 'package:my_password_app/ui/app_ui/konstans/k_assets.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_locale.dart';
import 'package:my_password_app/ui/pages/home/home_page.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:my_password_app/ui/pages/splash/splash_page.dart';
import 'package:my_password_app/utils/app_bloc_observer.dart';

/// TODO : Implement easy localization
/// TODO : Release apk
/// TODO : Update night mode

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
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
        BlocProvider(
          create: (_) => ThemeCubit(),
        )
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: () {
              if (state is ThemeDarkMode)
                return MyTheme.dark;
              else
                return MyTheme.light;
            }(),
            initialRoute: SplashScreen.routeName,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routes: {
              SplashScreen.routeName: (context) => const SplashScreen(),
              SignInPage.routeName: (context) => const SignInPage(),
              HomePage.routeName: (context) => const HomePage(),
            },
          );
        },
      ),
    );
  }
}
