import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_password_app/core/services/shared_prefs_service.dart';
import 'package:my_password_app/firebase_options.dart';
import 'package:my_password_app/ui/pages/password/password_create_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (SharedPrefService.getPassword().isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushNamed(context, PasswordCreatePage.routeName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(tr("loading")),
      ),
    );
  }
}
