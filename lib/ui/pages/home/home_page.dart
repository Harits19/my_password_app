import 'package:flutter/material.dart';
import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/core/models/password_application_model.dart';
import 'package:my_password_app/core/services/drive_service.dart';
import 'package:my_password_app/core/services/google_service.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/cubits/password/password_cubit.dart';
import 'package:my_password_app/env.dart';
import 'package:my_password_app/konstan/k_locale.dart';
import 'package:my_password_app/konstan/k_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/ui/helper/show.dart';
import 'package:my_password_app/ui/pages/home/view/drawer_view.dart';
import 'package:my_password_app/ui/pages/home/view/password_view.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:my_password_app/utils/k_navigator.dart';
import 'package:my_password_app/utils/k_state.dart';
import 'package:easy_localization/easy_localization.dart';

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
    KState.afterBuildDo(() async {
      Show.showLoading(context);
      try {
        if (!(authRead.state is AuthSignIn)) {
          throw "User Sign Out";
        }
        await passwordRead.receivePassword(
            (authRead.state as AuthSignIn).userModel.googleSignInAccount);
      } catch (e) {
        Show.snackbar(context, e.toString());
      }
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, authState) {
        if (authState is AuthSignOut) {
          KNavigator.popAll(context, SignInPage.routeName);
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
              appBar: AppBar(),
              drawer: DrawerView(),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(KSize.small),
                child: Column(
                  children: [
                    Text("language".tr()),
                    ElevatedButton(
                      onPressed: () {
                        EasyLocalization.of(context)?.setLocale(KLocale.id);
                      },
                      child: Text("Indonesia"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        EasyLocalization.of(context)?.setLocale(KLocale.en);
                      },
                      child: Text("English"),
                    ),
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
        Show.modalPassword(
          context: context,
          onPressedSave: (val) async {
            Navigator.pop(context);
            Show.showLoading(context);
            try {
              if ((authState is AuthSignIn)) {
                await passwordRead.addPassword(
                  googleSignInAccount: authState.userModel.googleSignInAccount,
                  password: val,
                );
              }
            } catch (e) {
              Show.snackbar(context, e.toString());
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
    Show.modalPassword(
      name: e.name,
      password: e.password,
      context: context,
      onPressedSave: (val) async {
        Navigator.pop(context);
        Show.showLoading(context);
        try {
          if ((authState is AuthSignIn)) {
            await passwordRead.editPassword(
              index: index,
              googleSignInAccount: authState.userModel.googleSignInAccount,
              password: val,
            );
          }
        } catch (e) {
          Show.snackbar(context, e.toString());
        }
        Navigator.pop(context);
      },
    );
  }

  void _handlerDelete({
    required AuthState authState,
    required int index,
  }) async {
    Show.showLoading(context);
    try {
      if ((authState is AuthSignIn)) {
        await passwordRead.deletePassword(
          index: index,
          googleSignInAccount: authState.userModel.googleSignInAccount,
        );
      }
    } catch (e) {
      Show.snackbar(context, e.toString());
    }
    Navigator.pop(context);
  }
}
