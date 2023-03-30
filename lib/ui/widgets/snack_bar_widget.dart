import 'package:flutter/material.dart';
import 'package:my_password_app/ui/konstans/k_size.dart';

class SnackBarWidget {
  static void show(BuildContext context, dynamic text) {
    showModalBottomSheet<void>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (_) {
        Future.delayed(const Duration(seconds: 3), () {
          try {
            Navigator.pop(context);
          } on Exception {}
        });
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(KSize.s16),
          child: Wrap(
            children: [
              Text(
                text.toString().trim(),
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        );
      },
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
