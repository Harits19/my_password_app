import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/app.dart';
import 'package:my_password_app/firebase_options.dart';

import 'package:my_password_app/ui/app_ui/konstans/k_assets.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_locale.dart';
import 'package:my_password_app/utils/app_bloc_observer.dart';

/// TODO : Release apk
/// TODO : Update night mode
/// TODO : make a screen for explaination why the app need google drive
/// TODO : make a screen for explaination why the app need pin
/// TODO : add forget password
/// TODO : change all method widget to independent widget for readibility
/// TODO : update package on pubspec.yaml

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
