import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_password_app/ui/konstans/k_size.dart';

class SnackBarWidget {
  static void show(BuildContext context, dynamic text) {
    showModalBottomSheet<void>(
      context: context,
      barrierColor: Colors.transparent,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SnackbarWidget(
          text: text,
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

class SnackbarWidget extends StatefulWidget {
  const SnackbarWidget({
    super.key,
    this.text,
  });
  final dynamic text;

  @override
  State<SnackbarWidget> createState() => _SnackbarWidgetState();
}

class _SnackbarWidgetState extends State<SnackbarWidget> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              timer?.cancel();
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(KSize.s16),
          child: Wrap(
            children: [
              Text(
                widget.text.toString().trim(),
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
