import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_password_app/core/konstans/key.dart';
import 'package:my_password_app/core/models/password_application_model.dart';
import 'package:my_password_app/core/services/drive_service.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit()
      : super(PasswordLoaded(
          listPassword: [],
          isAuthenticated: false,
        ));

  Future<void> receivePassword(
    GoogleSignInAccount googleSignInAccount,
  ) async {
    bool isAuthenticated = false;
    final state = this.state;
    if (state is PasswordLoaded) {
      isAuthenticated = state.isAuthenticated;
    }
    final listPassword = await DriveService.receiveFilePassword(
      googleSignInAccount: googleSignInAccount,
    );
    final appPassword = listPassword
        .where((element) => element.name == AppKey.appPassword)
        .toList();
    if (appPassword.isEmpty) {
      emit(PasswordCreatePasswordApp());
    }

    emit(PasswordIdle(listPassword: listPassword));
    emit(
      PasswordLoaded(
        listPassword: listPassword,
        appPassword: appPassword.first,
        isAuthenticated: isAuthenticated,
      ),
    );
  }

  Future<void> addPassword({
    required GoogleSignInAccount googleSignInAccount,
    required PasswordModel password,
  }) async {
    final currentState = this.state;
    var tempPassword = <PasswordModel>[];
    if (currentState is PasswordLoaded) {
      tempPassword = currentState.listPassword;
    }
    tempPassword.add(password);
    print("temp password " + tempPassword.toString());
    await DriveService.updateFilePassword(
      googleSignInAccount: googleSignInAccount,
      password: tempPassword,
    );
    await receivePassword(googleSignInAccount);
  }

  Future<void> editPassword({
    required GoogleSignInAccount googleSignInAccount,
    required int index,
    required PasswordModel password,
  }) async {
    final currentState = this.state;
    if (currentState is PasswordLoaded) {
      currentState.listPassword[index] = password;
      await DriveService.updateFilePassword(
        googleSignInAccount: googleSignInAccount,
        password: currentState.listPassword,
      );
      await receivePassword(googleSignInAccount);
    }
  }

  Future<void> deletePassword({
    required GoogleSignInAccount googleSignInAccount,
    required int index,
  }) async {
    final currentState = this.state;
    if (currentState is PasswordLoaded) {
      currentState.listPassword.removeAt(index);
      await DriveService.updateFilePassword(
        googleSignInAccount: googleSignInAccount,
        password: currentState.listPassword,
      );
      await receivePassword(googleSignInAccount);
    }
  }

  void checkAuthenticated(String password) {
    final state = this.state;
    if (state is PasswordLoaded) {
      if (password == state.appPassword?.password) {
        emit(PasswordIdle(listPassword: state.listPassword));
        emit(
          PasswordLoaded(
            listPassword: state.listPassword,
            isAuthenticated: true,
            appPassword: state.appPassword,
          ),
        );
      } else {
        print("called check auth");

        throw "Wrong Password";
      }
    }
  }
}
