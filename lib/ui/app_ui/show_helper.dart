import 'package:flutter/material.dart';
import 'package:my_password_app/core/konstans/key.dart';
import 'package:my_password_app/core/models/password_model.dart';
import 'package:my_password_app/ui/widgets/modal_password_widget.dart';

class ShowHelper {
  ShowHelper._();

  

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

  
}
