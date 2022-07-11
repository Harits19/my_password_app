import 'package:flutter/material.dart';
import 'package:my_password_app/core/models/password_application_model.dart';
import 'package:my_password_app/ui/widgets/modal_password_widget.dart';

class ShowHelper {
  ShowHelper._();

  static void snackbar(BuildContext context, dynamic text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text.toString()),
      ),
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static void showLoading(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<void> modalPassword(
      {required BuildContext context,
      String? name,
      String? password,
      bool isAppPassword = false,
      required ValueChanged<PasswordModel>? onPressedSave}) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      isDismissible: isAppPassword ? false : true,
      enableDrag: false,
      builder: (BuildContext context) {
        return ModalPasswordWidget(
          name: name,
          password: password,
          onPressSave: onPressedSave,
          isAppPassword: isAppPassword,
        );
      },
    );
  }
}
