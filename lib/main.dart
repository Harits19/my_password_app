import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/app.dart';
import 'package:my_password_app/core/services/services.dart';

// TODO fix bug when snackbar show
// TODO create field for name system or website
// TODO add dummy floating button for list

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
