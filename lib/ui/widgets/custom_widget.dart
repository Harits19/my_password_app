import 'package:flutter/material.dart';
import 'package:my_password_app/ui/shared/custom_styles.dart';
import 'package:my_password_app/ui/shared/ui_helpers.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final onPressedParam;
  final String text;

  const ElevatedButtonWidget(
      {required this.text, required this.onPressedParam});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: UIHelper.buttonHeight,
      margin: EdgeInsets.symmetric(horizontal: UIHelper.edgeSmall),
      child: ElevatedButton(
        onPressed: onPressedParam,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: CustomStyle.titleStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final onChanged;
  final controller;

  TextFieldWidget({required this.hintText, this.onChanged, this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: UIHelper.edgeLarge),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              labelText: hintText),
          autofocus: false,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}
