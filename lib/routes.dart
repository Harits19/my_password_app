import 'package:flutter/material.dart';
import 'package:my_password_app/ui/pages/home/home_page.dart';
import 'package:my_password_app/ui/pages/password/password_create_page.dart';
import 'package:my_password_app/ui/pages/password/password_page.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:my_password_app/ui/pages/splash/splash_page.dart';

final kRoute = <String, Widget>{
  SplashScreen.routeName: const SplashScreen(),
  SignInPage.routeName: const SignInPage(),
  HomePage.routeName: HomePage(),
  PasswordPage.routeName: PasswordPage(),
  PasswordCreatePage.routeName: PasswordCreatePage(),
};
