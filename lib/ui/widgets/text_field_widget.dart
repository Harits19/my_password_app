import 'package:flutter/material.dart';
import 'package:my_password_app/konstan/k_size.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final obscureText;

  TextFieldWidget(
      {required this.hintText,
      this.onChanged,
      this.controller,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KSize.edgeLarge),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            labelText: hintText,
          ),
          autofocus: false,
          obscureText: obscureText,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

