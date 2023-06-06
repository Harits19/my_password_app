import 'package:flutter/material.dart';
import 'package:my_password_app/app.dart';

class WidgetUtil {
  static BuildContext get context => navigatorKey.currentContext!;
  static showLoading() {
    debugPrint('showLoading');
    checkWidget(() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    });
  }

  static safePop() {
    checkWidget(() {
      Navigator.pop(context);
    });
  }

  static checkWidget(VoidCallback voidCallback) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      voidCallback();
    });
  }

  static void showError(Object error, StackTrace stackTrace) async {
    checkWidget(() {
      mySnackBar(
        error.toString(),
        color: Colors.red,
      );
    });
  }

  static void showSuccess(String message) async {
    checkWidget(() {
      mySnackBar(
        message,
        color: Colors.green,
      );
    });
  }

  static void mySnackBar(String message, {Color? color}) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      isDismissible: false,
      isScrollControlled: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Container(
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
      ),
    );
    checkWidget(() async {
      await Future.delayed(Duration(seconds: 3));
      Navigator.pop(context);
    });
  }
}
