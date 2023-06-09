import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.onPressYes,
  });
  final String title;
  final VoidCallback onPressYes;

  static show(
    BuildContext context, {
    required AlertDialogWidget child,
  }) {
    showDialog(
      context: context,
      builder: (context) => child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [
        ElevatedButton(
          child: Text('Yes'),
          onPressed: () {
            onPressYes.call();
          },
        ),
        ElevatedButton(
          child: Text('No'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
