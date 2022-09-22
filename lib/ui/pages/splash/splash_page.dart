import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/ui/app_ui/show_helper.dart';
import 'package:my_password_app/ui/pages/home/home_page.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:my_password_app/ui/app_ui/navigator_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/ui/app_ui/state_helper.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  void _checkLogin() {
    StateHelper.afterBuildDo(() async {
      final authRead = context.read<AuthCubit>();
      try {
        await authRead.checkSignInStatus();
        final state = authRead.state;
        if (state is AuthSignIn) {
          NavigatorHelper.popAll(context, HomePage.routeName);
        }
        if (state is AuthSignOut) {
          NavigatorHelper.popAll(context, SignInPage.routeName);
        }
      } catch (e) {
        if (!mounted) return;
        print(e.toString());
        ShowHelper.snackbar(context, e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        print(state);
        return Scaffold(
          body: Center(
            child: Text(tr("loading")),
          ),
        );
      },
    );
  }
}
