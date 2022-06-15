import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_password_app/ui/konstan/k_style.dart';
import 'package:my_password_app/ui/konstan/k_ui.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final onPressedParam;
  final String text;

  const ElevatedButtonWidget(
      {required this.text, required this.onPressedParam});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: KUi.buttonHeight,
      margin: EdgeInsets.symmetric(horizontal: KUi.edgeSmall),
      child: ElevatedButton(
        onPressed: onPressedParam,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: KStyle.titleStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final onChanged;
  final controller;
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
        padding: const EdgeInsets.symmetric(horizontal: KUi.edgeLarge),
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
          style: KStyle.subtitleStyle,
        )
      ],
    );
  }
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final size = Get.size.width * 0.25;
    return SizedBox(
        width: 40.0, height: 40.0, child: CircularProgressIndicator());
  }
}

class SnackBarWidget {
  static void show({required title, required message}) {
    Get.snackbar(title, message,
        margin: EdgeInsets.symmetric(
          vertical: KUi.edgeLarge,
          horizontal: KUi.edgeMedium,
        ));
  }
}
