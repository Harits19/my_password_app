import 'package:flutter/material.dart';
import 'package:my_password_app/core/models/password_application_model.dart';
import 'package:my_password_app/ui/widgets/modal_password_widget.dart';

class ShowHelper {
  ShowHelper._();

  static void snackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
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
      required ValueChanged<PasswordModel>? onPressedSave}) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return ModalPasswordWidget(
          name: name,
          password: password,
          onPressSave: onPressedSave,
        );
      },
    );
  }
}
