import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/core/konstans/key.dart';
import 'package:my_password_app/core/models/password_application_model.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/cubits/password/password_cubit.dart';
import 'package:my_password_app/cubits/theme/theme_cubit.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/ui/app_ui/show_helper.dart';
import 'package:my_password_app/ui/pages/home/view/drawer_view.dart';
import 'package:my_password_app/ui/pages/home/view/password_view.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:my_password_app/ui/app_ui/navigator_helper.dart';
import 'package:my_password_app/ui/app_ui/state_helper.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final _passwordRead = context.read<PasswordCubit>();
  late final _authRead = context.read<AuthCubit>();

  @override
  void initState() {
    super.initState();
    _receivePassword();
  }

  void _receivePassword() async {
    StateHelper.afterBuildDo(() async {
      ShowHelper.showLoading(context);
      try {
        if (!(_authRead.state is AuthSignIn)) {
          throw tr("userSignOut");
        }
        await _passwordRead.receivePassword(
            (_authRead.state as AuthSignIn).userModel.googleSignInAccount);
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
        print("authState : " + authState.toString());
        final googleSignInAccount = authState is AuthSignIn
            ? authState.userModel.googleSignInAccount
            : null;
        return BlocConsumer<PasswordCubit, PasswordState>(
          listener: (context, passwordState) {
            if (passwordState.passwordState ==
                PasswordStateEnum.createAppPassword) {
              ShowHelper.modalPassword(
                context: context,
                name: AppKey.appPassword,
                onPressedSave: (val) async {
                  print("called add password 1");
                  if (googleSignInAccount == null) return;
                  print("called add password 2");
                  Navigator.pop(context);
                  ShowHelper.showLoading(context);
                  try {
                    await _passwordRead.addPassword(
                      googleSignInAccount: googleSignInAccount,
                      password: val,
                    );
                    print("called add password 3");
                  } catch (e) {
                    print("error " + e.toString());
                    ShowHelper.snackbar(context, e);
                  }
                  ShowHelper.pop(context);
                },
              );
            }
            if (!passwordState.isAuthenticated &&
                passwordState.listPassword.isNotEmpty) {
              _dialogAuthentication();
            }
          },
          builder: (context, passwordState) {
            final items = passwordState.listPassword;

            print(items);
            return Scaffold(
              floatingActionButton: _floatingButton(googleSignInAccount),
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
                padding: EdgeInsets.all(KSize.s16),
                child: Column(
                  children: [
                    ...List.generate(
                      items.length,
                      (index) {
                        final e = items[index];
                        final isDisable = googleSignInAccount == null;
                        return PasswordView(
                          password: e.password,
                          name: e.name,
                          onTapEdit: () {
                            if (isDisable) return;
                            _handlerEdit(
                              googleSignInAccount: googleSignInAccount,
                              index: index,
                              e: e,
                            );
                          },
                          onTapDelete: () {
                            if (isDisable) return;
                            _handlerDelete(
                              googleSignInAccount: googleSignInAccount,
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
    GoogleSignInAccount? googleSignAccount,
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
              if (googleSignAccount == null) return;
              await _passwordRead.addPassword(
                googleSignInAccount: googleSignAccount,
                password: val,
              );
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
    required GoogleSignInAccount googleSignInAccount,
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
          await _passwordRead.editPassword(
            index: index,
            googleSignInAccount: googleSignInAccount,
            password: val,
          );
        } catch (e) {
          ShowHelper.snackbar(context, e.toString());
        }
        Navigator.pop(context);
      },
    );
  }

  void _handlerDelete({
    required GoogleSignInAccount googleSignInAccount,
    required int index,
  }) async {
    ShowHelper.showLoading(context);
    try {
      await _passwordRead.deletePassword(
        index: index,
        googleSignInAccount: googleSignInAccount,
      );
    } catch (e) {
      ShowHelper.snackbar(context, e.toString());
    }
    Navigator.pop(context);
  }

  void _dialogAuthentication() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        String? password;
        bool obscureText = false;
        String? error;
        return WillPopScope(
          onWillPop: () async => false,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 8.0,
              sigmaY: 8.0,
            ),
            child: Dialog(
              child: Padding(
                padding: const EdgeInsets.all(KSize.s16),
                child: StatefulBuilder(builder: (context, localState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        obscureText: obscureText,
                        onChanged: (val) {
                          password = val;
                          localState(() {});
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              obscureText = !obscureText;
                              localState(() {});
                            },
                            icon: Icon(
                              obscureText
                                  ? CupertinoIcons.eye_fill
                                  : CupertinoIcons.eye_slash_fill,
                            ),
                          ),
                        ),
                      ),
                      KSize.verti8,
                      Text(error ?? ""),
                      KSize.verti16,
                      ElevatedButton(
                        child: Text("Submit"),
                        onPressed: password.isNullEmpty
                            ? null
                            : () {
                                try {
                                  _passwordRead.checkAuthenticated(password!);
                                  Navigator.pop(context);
                                } catch (e) {
                                  error = e.toString();
                                  localState(() {});
                                }
                              },
                      )
                    ],
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
