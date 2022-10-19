import 'package:flutter/material.dart';

class PasswordCreatePage extends StatelessWidget {
  static const routeName = '/password-create';

  const PasswordCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(PasswordCreatePage.routeName)),
    );
  }
}
