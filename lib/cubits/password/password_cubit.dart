import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_password_app/core/models/password_application_model.dart';
import 'package:my_password_app/core/services/drive_service.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(PasswordLoaded(listPassword: []));

  Future<void> receivePassword(GoogleSignInAccount googleSignInAccount) async {
    final currentState = this.state;
    if (currentState is PasswordLoaded) {
      emit(PasswordIdle(listPassword: currentState.listPassword));
    }
    final listPassword = await DriveService.receiveFilePassword(
        googleSignInAccount: googleSignInAccount);
    emit(PasswordLoaded(listPassword: listPassword));
  }

  Future<void> addPassword({
    required GoogleSignInAccount googleSignInAccount,
    required PasswordModel password,
  }) async {
    final currentState = this.state;
    if (currentState is PasswordLoaded) {
      currentState.listPassword.add(password);
      await DriveService.updateFilePassword(
        googleSignInAccount: googleSignInAccount,
        password: List.from(
          currentState.listPassword,
        ),
      );
      await receivePassword(googleSignInAccount);
    }
  }
}
