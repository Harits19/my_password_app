import 'package:flutter/material.dart';
import 'package:my_password_app/core/services/generate_password_service.dart';
import 'package:my_password_app/konstan/k_size.dart';
import 'package:my_password_app/ui/widgets/custom_widget.dart';

class Show {
  Show._();

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
      passwordController,
      nameController,
      required onPressedSave}) {
    bool number = false;
    bool letter = false;
    bool symbol = false;
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: KSize.edgeMedium, vertical: KSize.edgeLarge * 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFieldWidget(
                  hintText: 'Nama Aplikasi',
                  controller: nameController,
                ),
                TextFieldWidget(
                  hintText: 'Password',
                  controller: passwordController,
                ),
                KSize.verticalSmall,
                StatefulBuilder(builder: (context, setState) {
                  return Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CheckboxWidget(
                          text: 'Number',
                          value: number,
                          onChanged: (newValue) {
                            setState(() => {number = newValue});
                            print(number);
                          },
                        ),
                      ),
                      Expanded(
                        child: CheckboxWidget(
                          text: 'Letter',
                          value: letter,
                          onChanged: (newValue) {
                            setState(() => {letter = newValue});
                            print(letter);
                          },
                        ),
                      ),
                      Expanded(
                        child: CheckboxWidget(
                          text: 'Symbol',
                          value: symbol,
                          onChanged: (newValue) {
                            setState(() => {symbol = newValue});
                            print(symbol);
                          },
                        ),
                      ),
                    ],
                  );
                }),
                StatefulBuilder(builder: (context, setState) {
                  return ElevatedButtonWidget(
                      text: 'Generate Random Password',
                      onPressedParam: () {
                        var temp = GeneratePassword.getRandomString(
                            letter: letter, number: number, symbol: symbol);
                        setState(() {
                          passwordController.text = temp;
                        });
                        print(temp);
                      });
                }),
                KSize.verticalSmall,
                ElevatedButtonWidget(
                    text: 'Simpan', onPressedParam: onPressedSave),
                KSize.horizontalLarge,
                KSize.horizontalLarge,
              ],
            ),
          ),
        );
      },
    );
  }
}
