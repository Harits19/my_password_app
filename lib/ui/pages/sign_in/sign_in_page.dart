import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/extensions/context_extension.dart';
import 'package:my_password_app/core/providers/sign_in/sign_in_notifier.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_assets.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';
import 'package:my_password_app/ui/pages/home/home_page.dart';
import 'package:my_password_app/ui/widgets/snack_bar_widget.dart';

class SignInPage extends ConsumerStatefulWidget {
  static const routeName = "/sign-in";
  const SignInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  String password = '', confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    final signInWatch = ref.watch(signInProvider);
    final haveMasterPassword = signInWatch.haveMasterPassword;
    final signInRead = ref.read(signInProvider.notifier);

    ref.listen(signInProvider, (prev, next) {
      context.pushAndReplace(HomePage());
    });
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(KSize.s24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(),
              Image.asset(KAssets.letterIconAppDark),
              Spacer(),
              TextField(
                onChanged: (val) {
                  password = val;
                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: "Master Password",
                ),
              ),
              if (!haveMasterPassword)
                TextField(
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
                        signInRead.createMasterPassword(
                            password, confirmPassword);
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
          ),
        ),
      ),
    );
  }
}
