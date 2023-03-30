
import 'package:flutter/material.dart';
import 'package:my_password_app/ui/konstans/k_size.dart';

class ConfirmImportView extends StatelessWidget {
  static Future<bool> show(BuildContext context) async {
    final confirmImport = await showDialog<bool>(
      context: context,
      builder: (context) {
        return const ConfirmImportView();
      },
    );
    return confirmImport ?? false;
  }

  const ConfirmImportView({super.key});

  @override
  Widget build(BuildContext context) {
    buttonItem({
      required String text,
      Color? color,
      required VoidCallback onPress,
    }) {
      return Expanded(
        child: SizedBox(
          width: double.maxFinite,
          child: TextButton(
            onPressed: onPress,
            child: Text(
              text,
              style: TextStyle(color: color),
            ),
          ),
        ),
      );
    }

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(KSize.s16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Import akan menimpa data yang ada sekarang, \nApakah kamu yakin?',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            const SizedBox(
              height: KSize.s16,
            ),
            Row(
              children: [
                buttonItem(
                  text: 'Import',
                  onPress: () {
                    Navigator.pop(context, true);
                  },
                  color: Colors.red,
                ),
                buttonItem(
                  text: 'Cancel',
                  onPress: () {
                    Navigator.pop(context, false);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
