import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/ui/konstans/k_assets.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_notifier.dart';

class SignInPage extends ConsumerStatefulWidget {
  static const routeName = "/sign-in";
  const SignInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(),
              Image.asset(
                KAssets.letterIconAppLight,
              ),
              Spacer(),
              ElevatedButton(
                child: Text('Login/Register with Google'),
                onPressed: () async {
                  ref.read(signInProvider.notifier).signIn();
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
