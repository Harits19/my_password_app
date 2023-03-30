import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/providers/sign_in/sign_in_notifier.dart';
import 'package:my_password_app/extensions/context_extension.dart';
import 'package:my_password_app/ui/konstans/k_assets.dart';
import 'package:my_password_app/ui/konstans/k_size.dart';
import 'package:my_password_app/ui/pages/sign_in/views/sign_in_finger_print_page.dart';
import 'package:my_password_app/ui/pages/sign_in/views/sign_in_password_view.dart';

class SignInPage extends ConsumerStatefulWidget {
  static const routeName = "/sign-in";
  const SignInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  bool forceUsePassword = false;
  @override
  Widget build(BuildContext context) {
    final useFingerprint = ref.watch(signInProvider).useFingerprint;

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
              if (useFingerprint) ...[
                Center(
                  child: InkWell(
                    onTap: () {
                      forceUsePassword = !forceUsePassword;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(KSize.s16),
                      child: Text(
                        'Use ${!forceUsePassword ? 'Password' : 'Fingerprint'}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
              Expanded(
                flex: 3,
                child: useFingerprint && !forceUsePassword
                    ? SignInFingerPrintView()
                    : SignInPasswordView(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
