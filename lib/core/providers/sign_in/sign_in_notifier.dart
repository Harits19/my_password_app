import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/providers/sign_in/sign_in_state.dart';
import 'package:my_password_app/core/services/sign_in_service.dart';
import 'package:my_password_app/core/models/master_password_model.dart';

final signInProvider = StateNotifierProvider<SigInNotifier, SignInState>(
  (ref) => SigInNotifier()..getMasterPassword(),
);

class SigInNotifier extends StateNotifier<SignInState> {
  SigInNotifier() : super(SignInState());

  Future<void> createMasterPassword(String password, String confirmPassword) {
    if (password.length <= 6 || confirmPassword.length <= 6) {
      throw "Minimal 6 karakter";
    }
    if (password != confirmPassword) {
      throw "Password doesn't match";
    }
    return SignInService.saveMasterPassword(
      MasterPasswordModel(password: password),
    );
  }

  void getMasterPassword() {
    final masterPasswordModel = SignInService.getMasterPassword();
    state = SignInState(masterPasswordModel: masterPasswordModel);
  }

  void signIn(String password) {
    if (password != state.masterPasswordModel?.password) {
      throw 'Password tidak sesuai';
    } else {
      state = state.copyWith(isLoggedIn: true);
    }
  }
}
