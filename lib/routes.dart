import 'package:flutter/material.dart';
import 'package:my_password_app/ui/pages/home/home_page.dart';
import 'package:my_password_app/ui/pages/password/password_page.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_page.dart';

final kRoute = <String, Widget>{
  SignInPage.routeName: const SignInPage(),
  HomePage.routeName: HomePage(),
  PasswordPage.routeName: PasswordPage(),
};
