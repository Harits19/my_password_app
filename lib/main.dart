import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/app.dart';
import 'package:my_password_app/core/services/services.dart';

import 'package:my_password_app/ui/app_ui/konstans/k_assets.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_locale.dart';
import 'package:my_password_app/utils/app_bloc_observer.dart';

/// TODO : Release apk
/// TODO : Update night mode
/// TODO : add forget password
/// TODO : change all method widget to independent widget for readibility
/// TODO : implement export and import file
///

void main() async {
  await _loadAllService();
  BlocOverrides.runZoned(() {
    runApp(
      EasyLocalization(
        child: ProviderScope(child: App()),
        supportedLocales: KLocale.values.map((e) => e.value).toList(),
        fallbackLocale: KLocale.id.value,
        path: KAssets.translations,
        saveLocale: true,
        startLocale: KLocale.id.value,
        assetLoader: YamlAssetLoader(),
      ),
    );
  }, blocObserver: AppBlocObserver());
}

Future<void> _loadAllService() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Services.initPrefService();
}
