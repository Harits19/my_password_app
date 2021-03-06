import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
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
import 'package:secure_application/secure_application.dart';

/// TODO : Release apk
/// TODO : Update night mode
/// TODO : make a screen for explaination why the app need google drive
/// TODO : make a screen for explaination why the app need pin
/// TODO : blur recent app
/// TODO : timer idle user force to show the dialog authentication
/// TODO : add forget password

void main() async {
  print("hot restart app ");
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
        assetLoader: YamlAssetLoader(),
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
              HomePage.routeName: (context) => SecureGate(
                    blurr: 60,
                    opacity: 0.8,
                    child: const HomePage(),
                  ),
            },
            builder: (context, child) {
              return SecureApplication(
                nativeRemoveDelay: 800,
                onNeedUnlock: (secure) {
                  print("onNeedUnlock");
                  return null;
                },
                child: child ?? SizedBox(),
              );
            },
          );
        },
      ),
    );
  }
}
