import 'package:flutter/material.dart';
import 'package:my_password_app/core/models/password_application_model.dart';
import 'package:my_password_app/core/services/drive_service.dart';
import 'package:my_password_app/core/services/google_service.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/konstan/k_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/ui/helper/show.dart';
import 'package:my_password_app/ui/pages/home/view/drawer_view.dart';
import 'package:my_password_app/ui/pages/home/view/password_view.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:my_password_app/utils/k_navigator.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
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
              ),
              ElevatedButton(
                child: Text("Create File"),
                onPressed: () {
                  if (authState is AuthSignIn) {
                    DriveService.createFilePassword(
                      googleSignInAccount:
                          authState.userModel.googleSignInAccount,
                      password: PasswordApplicationModel(
                        name: "name1",
                        password: "password1",
                      ),
                    );
                  } else {
                    Show.snackbar(context, "User already sign out");
                  }
                },
              ),
              ElevatedButton(
                child: Text("Get File"),
                onPressed: () {
                  if (authState is AuthSignIn) {
                    DriveService.getFile(
                      googleSignInAccount:
                          authState.userModel.googleSignInAccount,
                    );
                  } else {
                    Show.snackbar(context, "User already sign out");
                  }
                },
              ),
              ElevatedButton(
                child: Text("Update File"),
                onPressed: () {
                  if (authState is AuthSignIn) {
                    DriveService.updateFilePassword(
                      googleSignInAccount:
                          authState.userModel.googleSignInAccount,
                      password: PasswordApplicationModel(
                        name: "name2",
                        password: "password2",
                      ),
                    );
                  } else {
                    Show.snackbar(context, "User already sign out");
                  }
                },
              ),
            ],
          ),
        ),
      ),
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
