import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_password_app/core/konstans/key.dart';
import 'package:my_password_app/core/models/password_application_model.dart';
import 'package:my_password_app/core/services/drive_service.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit()
      : super(PasswordState(
          listPassword: [],
          isAuthenticated: false,
          appPassword: null,
          passwordState: PasswordStateEnum.loaded,
        ));

  Future<void> receivePassword(
    GoogleSignInAccount googleSignInAccount,
  ) async {
    final listPassword = await DriveService.receiveFilePassword(
      googleSignInAccount: googleSignInAccount,
    );
    final appPassword = listPassword
        .where((element) => element.name == AppKey.appPassword)
        .toList();
    if (appPassword.isEmpty) {
      emit(
        PasswordState(
          listPassword: listPassword,
          isAuthenticated: false,
          appPassword: null,
          passwordState: PasswordStateEnum.createAppPassword,
        ),
      );
      return;
    }

    emit(
      PasswordState(
        listPassword: listPassword,
        appPassword: appPassword.first,
        isAuthenticated: state.isAuthenticated,
        passwordState: PasswordStateEnum.loaded,
      ),
    );
  }

  Future<void> addPassword({
    required GoogleSignInAccount googleSignInAccount,
    required PasswordModel password,
  }) async {
    final tempPassword = state.listPassword;
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
    state.listPassword[index] = password;
    await DriveService.updateFilePassword(
      googleSignInAccount: googleSignInAccount,
      password: state.listPassword,
    );
    await receivePassword(googleSignInAccount);
  }

  Future<void> deletePassword({
    required GoogleSignInAccount googleSignInAccount,
    required int index,
  }) async {
    state.listPassword.removeAt(index);
    await DriveService.updateFilePassword(
      googleSignInAccount: googleSignInAccount,
      password: state.listPassword,
    );
    await receivePassword(googleSignInAccount);
  }

  void checkAuthenticated(String password) {
    final state = this.state;
    if (password == state.appPassword?.password) {
      emit(
        PasswordState(
          listPassword: state.listPassword,
          isAuthenticated: true,
          appPassword: state.appPassword,
          passwordState: PasswordStateEnum.loaded,
        ),
      );
    } else {
      print("called check auth");

      throw "Wrong Password";
    }
  }

  void resetAuthentication() {
    emit(state.copyWith(
      isAuthenticated: false,
    ));
  }
}
