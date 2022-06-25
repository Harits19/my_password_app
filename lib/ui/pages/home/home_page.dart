import 'package:flutter/material.dart';
import 'package:my_password_app/core/models/password_application_model.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/cubits/password/password_cubit.dart';
import 'package:my_password_app/cubits/theme/theme_cubit.dart';
import 'package:my_password_app/konstan/k_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/ui/helper/show_helper.dart';
import 'package:my_password_app/ui/pages/home/view/drawer_view.dart';
import 'package:my_password_app/ui/pages/home/view/password_view.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:my_password_app/ui/helper/navigator_helper.dart';
import 'package:my_password_app/ui/helper/state_helper.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final passwordRead = context.read<PasswordCubit>();
  late final authRead = context.read<AuthCubit>();

  @override
  void initState() {
    super.initState();
    _receivePassword();
  }

  void _receivePassword() async {
    StateHelper.afterBuildDo(() async {
      ShowHelper.showLoading(context);
      try {
        if (!(authRead.state is AuthSignIn)) {
          throw "User Sign Out";
        }
        await passwordRead.receivePassword(
            (authRead.state as AuthSignIn).userModel.googleSignInAccount);
      } catch (e) {
        ShowHelper.snackbar(context, e.toString());
      }
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, authState) {
        if (authState is AuthSignOut) {
          NavigatorHelper.popAll(context, SignInPage.routeName);
        }
      },
      builder: (context, authState) {
        print(authState.toString());
        return BlocBuilder<PasswordCubit, PasswordState>(
          builder: (context, passwordState) {
            var items = <PasswordModel>[];
            if (passwordState is PasswordIdle) {
              items = passwordState.listPassword;
            }
            if (passwordState is PasswordLoaded) {
              items = passwordState.listPassword;
            }

            print(passwordState.toString());

            return Scaffold(
              floatingActionButton: _floatingButton(authState),
              appBar: AppBar(
                actions: [
                  BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                        icon: () {
                          if (state is ThemeDarkMode) {
                            return Icon(Icons.sunny);
                          }
                          return Icon(Icons.nightlight);
                        }(),
                      );
                    },
                  ),
                ],
              ),
              drawer: DrawerView(),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(KSize.s8),
                child: Column(
                  children: [
                    ...List.generate(
                      items.length,
                      (index) {
                        final e = items[index];
                        return PasswordView(
                          password: e.password,
                          name: e.name,
                          onTapEdit: () {
                            _handlerEdit(
                              authState: authState,
                              index: index,
                              e: e,
                            );
                          },
                          onTapDelete: () {
                            _handlerDelete(
                              authState: authState,
                              index: index,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _floatingButton(
    AuthState authState,
  ) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        ShowHelper.modalPassword(
          context: context,
          onPressedSave: (val) async {
            Navigator.pop(context);
            ShowHelper.showLoading(context);
            try {
              if ((authState is AuthSignIn)) {
                await passwordRead.addPassword(
                  googleSignInAccount: authState.userModel.googleSignInAccount,
                  password: val,
                );
              }
            } catch (e) {
              ShowHelper.snackbar(context, e.toString());
            }
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _handlerEdit({
    required AuthState authState,
    required int index,
    required PasswordModel e,
  }) async {
    ShowHelper.modalPassword(
      name: e.name,
      password: e.password,
      context: context,
      onPressedSave: (val) async {
        Navigator.pop(context);
        ShowHelper.showLoading(context);
        try {
          if ((authState is AuthSignIn)) {
            await passwordRead.editPassword(
              index: index,
              googleSignInAccount: authState.userModel.googleSignInAccount,
              password: val,
            );
          }
        } catch (e) {
          ShowHelper.snackbar(context, e.toString());
        }
        Navigator.pop(context);
      },
    );
  }

  void _handlerDelete({
    required AuthState authState,
    required int index,
  }) async {
    ShowHelper.showLoading(context);
    try {
      if ((authState is AuthSignIn)) {
        await passwordRead.deletePassword(
          index: index,
          googleSignInAccount: authState.userModel.googleSignInAccount,
        );
      }
    } catch (e) {
      ShowHelper.snackbar(context, e.toString());
    }
    Navigator.pop(context);
  }
}
