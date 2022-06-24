import 'package:flutter/material.dart';
import 'package:my_password_app/konstan/k_size.dart';
import 'package:my_password_app/konstan/k_style.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback? onPressedParam;
  final String text;

  const ElevatedButtonWidget(
      {required this.text, required this.onPressedParam});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: KSize.s48,
      margin: EdgeInsets.symmetric(horizontal: KSize.s4),
      child: ElevatedButton(
        onPressed: onPressedParam,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: KStyle.h1.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
