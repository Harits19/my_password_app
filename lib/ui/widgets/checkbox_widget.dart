import 'package:flutter/material.dart';
import 'package:my_password_app/konstan/k_style.dart';

class CheckboxWidget extends StatelessWidget {
  final value;
  final onChanged;
  final text;

  CheckboxWidget({required this.value, this.onChanged, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(
          text,
          style: KStyle.h2,
        )
      ],
    );
  }
}