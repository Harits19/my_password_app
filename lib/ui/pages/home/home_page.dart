import 'package:easy_localization/easy_localization.dart';
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
import 'package:my_password_app/core/extensions/context_extension.dart';
import 'package:my_password_app/ui/app_ui/state_helper.dart';
import 'package:my_password_app/ui/utils/dialog_util.dart';

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
      _passwordRead.getListPassword();
      final state = _passwordRead.state;

      if (state.passwordState == PasswordStateEnum.createAppPassword) {}

      if (state.passwordState == PasswordStateEnum.loaded) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, authState) {
        if (authState is AuthSignOut) {
          context.popAll(SignInPage.routeName);
        }
      },
      builder: (context, authState) {
        print("authState : " + authState.toString());

        return BlocConsumer<PasswordCubit, PasswordState>(
          listener: (context, state) {
            final passwordState = state.passwordState;
            if (state.isAuthenticated == false &&
                passwordState == PasswordStateEnum.loaded) {
              DialogUtil.dialogAuthentication(
                context,
                
              );
            }
            if (passwordState == PasswordStateEnum.createAppPassword) {
              ShowHelper.modalPassword(
                context: context,
                name: AppConfig.appPassword,
                onPressedSave: (val) async {
                  final password = val.password;
                  if (password.isNullEmpty) return;
                  context.pop();
                  ShowHelper.showLoading(context);
                  try {
                    await _passwordRead.setAppPassword(val.password!);
                  } catch (e) {
                    print("error " + e.toString());
                    ShowHelper.snackbar(context, e);
                  }
                  context.pop();
                },
              );
            }
          },
          builder: (context, passwordState) {
            final items = passwordState.listPassword;

            print(items);
            return Scaffold(
              // floatingActionButton: _floatingButton(googleSignInAccount),
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
                        final isDisable = false;
                        return PasswordView(
                          password: e.password,
                          name: e.name,
                          onTapEdit: () {
                            if (isDisable) return;
                            // _handlerEdit( // TODO
                            //   googleSignInAccount: googleSignInAccount,
                            //   index: index,
                            //   e: e,
                            // );
                          },
                          onTapDelete: () {
                            if (isDisable) return;
                            // _handlerDelete( // TODO
                            //   googleSignInAccount: googleSignInAccount,
                            //   index: index,
                            // );
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
              // TODO
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
          // TODO
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
      // TODO
    } catch (e) {
      ShowHelper.snackbar(context, e.toString());
    }
    Navigator.pop(context);
  }
}
