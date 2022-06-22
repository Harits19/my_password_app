import 'package:flutter/material.dart';
import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/core/models/password_application_model.dart';
import 'package:my_password_app/core/services/drive_service.dart';
import 'package:my_password_app/core/services/google_service.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/cubits/password/password_cubit.dart';
import 'package:my_password_app/env.dart';
import 'package:my_password_app/konstan/k_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/ui/helper/show.dart';
import 'package:my_password_app/ui/pages/home/view/drawer_view.dart';
import 'package:my_password_app/ui/pages/home/view/password_view.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:my_password_app/utils/k_navigator.dart';
import 'package:my_password_app/utils/k_state.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Show.modalPassword(
                    context: context,
                    onPressedSave: (val) async {
                      print("called");
                      Navigator.pop(context);
                      Show.showLoading(context);
                      try {
                        if ((authState is AuthSignIn)) {
                          print("called auth sign in");
                          await passwordRead.addPassword(
                            googleSignInAccount:
                                authState.userModel.googleSignInAccount,
                            password: val,
                          );
                        }
                      } catch (e) {
                        Show.snackbar(context, e.toString());
                      }
                      Navigator.pop(context);
                      print("end called");
                    },
                  );
                },
              ),
              appBar: AppBar(),
              drawer: DrawerView(),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(KSize.small),
                child: Column(
                  children: [
                    ...items.map((e) =>
                        PasswordView(password: e.password, name: e.name)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      file.readAsBytes();

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }
}
