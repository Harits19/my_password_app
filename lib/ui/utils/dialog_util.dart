import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/cubits/password/password_cubit.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';

class DialogUtil {
  DialogUtil._();

  static void dialogAuthentication(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        String? password;
        bool obscureText = false;
        String? error;
        return WillPopScope(
          onWillPop: () async => false,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 8.0,
              sigmaY: 8.0,
            ),
            child: Dialog(
              child: Padding(
                padding: const EdgeInsets.all(KSize.s16),
                child: StatefulBuilder(builder: (context, localState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        obscureText: obscureText,
                        onChanged: (val) {
                          password = val;
                          localState(() {});
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              obscureText = !obscureText;
                              localState(() {});
                            },
                            icon: Icon(
                              obscureText
                                  ? CupertinoIcons.eye_fill
                                  : CupertinoIcons.eye_slash_fill,
                            ),
                          ),
                        ),
                      ),
                      KSize.verti8,
                      Text(error ?? ""),
                      KSize.verti16,
                      ElevatedButton(
                        child: Text("Submit"),
                        onPressed: password.isNullEmpty
                            ? null
                            : () {
                                try {
                                  final passwordRead = context.read<PasswordCubit>();
                                  passwordRead.checkAuthenticated(password!);
                                  Navigator.pop(context);
                                } catch (e) {
                                  error = e.toString();
                                  localState(() {});
                                }
                              },
                      )
                    ],
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
