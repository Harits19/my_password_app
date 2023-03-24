import 'package:flutter/material.dart';

class SnackBarWidget {
  static void show(BuildContext context, dynamic text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text.toString()),
      ),
    );
  }

  static void catchError(BuildContext context, VoidCallback voidCallback) {
    try {
      voidCallback();
    } catch (e) {
      show(context, e.toString());
    }
  }
}
