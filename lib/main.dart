import 'package:flutter/material.dart';
import 'package:my_password_app/core/viewmodels/local_auth_model.dart';
import 'package:my_password_app/ui/views/auth_view.dart';
import 'package:my_password_app/ui/views/home_view.dart';
import 'package:provider/provider.dart';

import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(home: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Password App',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Colors.blue,
          secondary: Colors.blue,
        ),
      ),
      home: ChangeNotifierProvider<LocalAuthModel?>(
          create: (_) => LocalAuthModel(), child: CheckAuth()),
    );
  }
}
