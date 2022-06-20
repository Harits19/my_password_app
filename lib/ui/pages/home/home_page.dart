import 'package:flutter/material.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/konstan/k_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/ui/helper/show.dart';
import 'package:my_password_app/ui/pages/home/view/drawer_view.dart';
import 'package:my_password_app/ui/pages/home/view/password_view.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:my_password_app/utils/k_navigator.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignOut) {
          KNavigator.popAll(context, SignInPage.routeName);
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Show.modalPassword(
              context: context,
              onPressedSave: () {},
            );
          },
        ),
        appBar: AppBar(),
        drawer: DrawerView(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(KSize.small),
          child: Column(
            children: [
              PasswordView(
                password: "password",
                name: "name",
              )
            ],
          ),
        ),
      ),
    );
  }
}
