import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_password_app/app.dart';
import 'package:my_password_app/core/utils/my_print.dart';

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

  static void showError(Object error,{ StackTrace? stackTrace}) async {
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
    Timer? timer;
    myPrint('showSnacbar');
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      isScrollControlled: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (builderContext) {
        myPrint('setTimer');
        timer = Timer(Duration(seconds: 3), () {
          Navigator.of(context).pop();
          myPrint('popSnackbar');
        });
        return Container(
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
        );
      },
    ).then(
      (value) {
        myPrint('cancelTimer');
        timer?.cancel();
      },
    );
  }
}
