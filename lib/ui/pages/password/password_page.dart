import 'package:flutter/material.dart';

class PasswordPage extends StatelessWidget {
  static const routeName = '/password';

  const PasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(PasswordPage.routeName)),
    );
  }
}
