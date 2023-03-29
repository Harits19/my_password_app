import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/app.dart';
import 'package:my_password_app/core/services/services.dart';

/// TODO : Release apk
/// TODO : add forget password
/// TODO : implement export and import file

void main() async {
  await _loadAllService();
  runApp(
    ProviderScope(child: App()),
  );
}

Future<void> _loadAllService() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Services.initPrefService();
}
