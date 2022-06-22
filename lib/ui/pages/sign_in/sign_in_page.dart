import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/konstan/k_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:my_password_app/ui/helper/show.dart';
import 'package:my_password_app/ui/pages/home/home_page.dart';
import 'package:my_password_app/utils/k_navigator.dart';

class SignInPage extends StatelessWidget {
  static const routeName = "/sign-in";

  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(KSize.edgeLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSignIn) {
                      KNavigator.popAll(context, HomePage.routeName);
                    }
                  },
                  child: ElevatedButton(
                    child: Text(
                      "signInGoogle".tr(),
                    ),
                    onPressed: () async {
                      Show.showLoading(context);
                      await authCubit.signInWithGoogle(onError: (error) {
                        Show.snackbar(context, error);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}