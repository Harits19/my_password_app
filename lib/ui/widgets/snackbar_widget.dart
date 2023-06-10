import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_password_app/core/utils/my_print.dart';
import 'package:my_password_app/ui/widgets/widget_util.dart';

class SnackbarWidget extends StatelessWidget {
  const SnackbarWidget({
    super.key,
    required this.message,
    this.color,
  });
  final Object message;
  final Color? color;

  static void showError(
    BuildContext context,
    Object? error,
  ) async {
    if (error == null) return;
    WidgetUtil.checkWidget(() {
      mySnackBar(
        context,
        child: SnackbarWidget(
          message: error.toString(),
          color: Colors.red,
        ),
      );
    });
  }

  static void showSuccess(BuildContext context, String message) async {
    WidgetUtil.checkWidget(() {
      mySnackBar(
        context,
        child: SnackbarWidget(
          message: message,
          color: Colors.green,
        ),
      );
    });
  }

  static void mySnackBar(BuildContext context,
      {required SnackbarWidget child}) {
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
        return child;
      },
    ).then(
      (value) {
        myPrint('cancelTimer');
        timer?.cancel();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
