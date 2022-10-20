import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/core/konstans/key.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/cubits/password/password_cubit.dart';
import 'package:my_password_app/cubits/theme/theme_cubit.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_locale.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/ui/app_ui/show_helper.dart';
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
              floatingActionButton: _floatingButton(),
              appBar: _AppBarView(),
              drawer: _DrawerView(),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(KSize.s16),
                child: Column(
                  children: [
                    ...List.generate(
                      items.length,
                      (index) {
                        final e = items[index];
                        return PasswordView(
                          passwordModel: e,
                          index: index,
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

  Widget _floatingButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        ShowHelper.modalPassword(
          context: context,
          onPressedSave: (val) async {
            context.pop();
            ShowHelper.showLoading(context);
            try {
              await _passwordRead.addPassword(passwordModel: val);
            } catch (e) {
              ShowHelper.snackbar(context, e.toString());
            }
            context.pop();
          },
        );
      },
    );
  }
}

class _DrawerView extends StatelessWidget {
  const _DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.all(KSize.s16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("language".tr()),
            DropdownButton<Locale>(
              value: EasyLocalization.of(context)?.currentLocale,
              isExpanded: true,
              items: [
                ...KLocale.values.map(
                  (e) => DropdownMenuItem(
                    value: e.value,
                    onTap: () {
                      EasyLocalization.of(context)?.setLocale(e.value);
                    },
                    child: Text(
                      e.toString(),
                    ),
                  ),
                ),
              ],
              onChanged: (val) {},
            ),
            KSize.verti16,
            ElevatedButton(
              child: Text('Backup to Google Drive'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text('Restore from Google Drive'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text(
                "signOutGoogle".tr(),
              ),
              onPressed: () {
                final authCubit = context.read<AuthCubit>();

                ShowHelper.showLoading(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBarView extends StatelessWidget implements PreferredSizeWidget {
  _AppBarView({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
