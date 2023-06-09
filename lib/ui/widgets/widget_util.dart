import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_password_app/core/utils/my_print.dart';
import 'package:my_password_app/ui/widgets/loading_widget.dart';

class WidgetUtil {
  static showLoading(BuildContext context) {
    debugPrint('showLoading');
    checkWidget(() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: LoadingWidget(),
        ),
      );
    });
  }

  static safePop(BuildContext context) {
    checkWidget(() {
      Navigator.pop(context);
    });
  }

  static checkWidget(VoidCallback voidCallback) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      voidCallback();
    });
  }

  static void showError(
    BuildContext context,
    Object error,
  ) async {
    checkWidget(() {
      mySnackBar(
        context,
        error.toString(),
        color: Colors.red,
      );
    });
  }

  static void showSuccess(BuildContext context, String message) async {
    checkWidget(() {
      mySnackBar(
        context,
        message,
        color: Colors.green,
      );
    });
  }

  static void mySnackBar(BuildContext context, String message, {Color? color}) {
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
