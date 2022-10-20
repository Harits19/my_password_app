import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_assets.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:my_password_app/ui/app_ui/show_helper.dart';
import 'package:my_password_app/ui/pages/home/home_page.dart';
import 'package:my_password_app/core/extensions/context_extension.dart';

class SignInPage extends StatelessWidget {
  static const routeName = "/sign-in";

  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(KSize.s16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(),
              Image.asset(KAssets.letterIconAppDark),
              Spacer(),
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSignIn) {
                    context.popAll(HomePage.routeName);
                  }
                },
                child: ElevatedButton(
                  child: Text(
                    "signInGoogle".tr(),
                  ),
                  onPressed: () async {
                    ShowHelper.showLoading(context);
                    try {
                      // TODO
                    } catch (e) {
                      ShowHelper.snackbar(context, e);
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
