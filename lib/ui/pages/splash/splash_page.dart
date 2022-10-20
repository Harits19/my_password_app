import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/core/extensions/context_extension.dart';
import 'package:my_password_app/cubits/password/password_cubit.dart';
import 'package:my_password_app/ui/pages/password/password_create_page.dart';

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
    final passwordRead = context.read<PasswordCubit>();
    passwordRead.getListPassword();
    final isCreateAppPassword =
        passwordRead.state.passwordState == PasswordStateEnum.createAppPassword;
    if (isCreateAppPassword) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          context.popAll(PasswordCreatePage.routeName);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(tr("loading")),
      ),
    );
  }
}
