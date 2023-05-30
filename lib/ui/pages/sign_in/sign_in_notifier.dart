import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_state.dart';
import 'package:my_password_app/core/services/local_auth_service.dart';
import 'package:my_password_app/core/services/sign_in_service.dart';
import 'package:my_password_app/ui/widgets/snack_bar_widget.dart';

final signInProvider = StateNotifierProvider<SigInNotifier, SignInState>(
  (ref) => SigInNotifier()..getMasterPassword(),
);

class SigInNotifier extends StateNotifier<SignInState> {
  SigInNotifier() : super(SignInState());

  Future<void> createMasterPassword(
      String password, String confirmPassword) async {
    if (password.length <= 6 || confirmPassword.length <= 6) {
      throw "Minimal 6 karakter";
    }
    if (password != confirmPassword) {
      throw "Password doesn't match";
    }
    state = SignInState(password: password);
    await SignInService.saveState(state);
    getMasterPassword();
  }

  void getMasterPassword() {
    final signInState = SignInService.getMasterPassword();
    state = signInState;
  }

  void signIn(String password) {
    if (password != state.password) {
      throw 'Password tidak sesuai';
    } else {
      state = state.copyWith(isLoggedIn: true);
    }
  }

  Future<void> toggleUseFingerprint() async {
    state = state.copyWith(
      useFingerprint: !state.useFingerprint,
    );
    await SignInService.saveState(state);
  }

  Future<bool> authWithBiometric(BuildContext context) async {
    try {
      final isAuthenticated = await LocalAuthService.authenticate();
      if (isAuthenticated) {
        state = state.copyWith(isLoggedIn: true);
      }
      return isAuthenticated;
    } on PlatformException catch (e) {
      SnackBarWidget.show(context, e.message);
      return false;
    }
  }

  Future<void> import(SignInState signInState) async {
    state = signInState;
    await SignInService.saveState(state);
  }

  void signOut() {
    state = state.copyWith(isLoggedIn: false);
  }

  Future<void> updateMasterPassword(
    String currentPassword,
    String newPassword,
    String confirmNewPassword,
  ) async {
    if (currentPassword != state.password) {
      throw 'Old password not correct';
    }
    await createMasterPassword(newPassword, confirmNewPassword);
  }
}
