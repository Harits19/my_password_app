import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/extensions/context_extension.dart';
import 'package:my_password_app/core/providers/sign_in/sign_in_notifier.dart';
import 'package:my_password_app/ui/pages/home/home_page.dart';
import 'package:my_password_app/ui/widgets/snack_bar_widget.dart';
import 'package:my_password_app/ui/widgets/text_field_password_widget.dart';
import 'package:my_password_app/utils/my_print.dart';

class SignInPasswordView extends ConsumerStatefulWidget {
  const SignInPasswordView({super.key});

  @override
  ConsumerState<SignInPasswordView> createState() => _SignInPasswordViewState();
}

class _SignInPasswordViewState extends ConsumerState<SignInPasswordView> {
  String password = '', confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    final signInWatch = ref.watch(signInProvider);
    final haveMasterPassword = signInWatch.haveMasterPassword;
    final signInRead = ref.read(signInProvider.notifier);
    myPrint(signInWatch.password);
    ref.listen(signInProvider, (prev, next) {
      context.pushAndReplace(HomePage());
    });
    return Column(
      children: [
        TextFieldPasswordWidget(
          onChanged: (val) {
            password = val;
            setState(() {});
          },
          decoration: InputDecoration(
            labelText: "Master Password",
          ),
        ),
        if (!haveMasterPassword)
          TextFieldPasswordWidget(
            onChanged: (val) {
              confirmPassword = val;
              setState(() {});
            },
            decoration: InputDecoration(
              labelText: "Confirm Master Password",
            ),
          ),
        Spacer(),
        ElevatedButton(
          onPressed: () {
            SnackBarWidget.catchError(
              context,
              () {
                if (!haveMasterPassword) {
                  signInRead.createMasterPassword(password, confirmPassword);
                } else {
                  signInRead.signIn(password);
                }
              },
            );
          },
          child: Text(
            !haveMasterPassword ? 'Save' : "Sign In",
          ),
        )
      ],
    );
  }
}
