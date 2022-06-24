import 'package:flutter/material.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/ui/helper/show_helper.dart';
import 'package:my_password_app/ui/pages/home/home_page.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:my_password_app/ui/helper/navigator_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/ui/helper/state_helper.dart';

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
      await authRead.checkSignInStatus(onError: (error) {
        print(error);
        ShowHelper.snackbar(context, error);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignIn) {
          NavigatorHelper.popAll(context, HomePage.routeName);
        }
        if (state is AuthSignOut) {
          NavigatorHelper.popAll(context, SignInPage.routeName);
        }
      },
      child: Scaffold(
        body: Center(
          child: Text("Loading"),
        ),
      ),
    );
  }
}
