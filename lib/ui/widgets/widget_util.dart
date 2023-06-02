import 'package:flutter/material.dart';

class WidgetUtil {
  static showLoading(BuildContext context) {
    checkWidget(context, () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  static dimissLoading(BuildContext context) {
    checkWidget(context, () {
      Navigator.pop(context);
    });
  }

  static checkWidget(BuildContext context, VoidCallback voidCallback) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.mounted) {
        voidCallback();
      }
    });
  }

  static void showError(
      BuildContext context, Object error, StackTrace stackTrace) async {
    checkWidget(context, () {
      mySnackBar(
        context,
        error.toString(),
        color: Colors.red,
      );
    });
  }

   static void showSuccess(
      BuildContext context, String message) async {
    checkWidget(context, () {
      mySnackBar(
        context,
        message,
        color: Colors.green,
      );
    });
  }

  static void mySnackBar(BuildContext context, String message, {Color? color}) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(8.0),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color ?? Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              message.toString(),
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
    checkWidget(context, () async {
      await Future.delayed(Duration(seconds: 3));
      Navigator.pop(context);
    });
  }
}
