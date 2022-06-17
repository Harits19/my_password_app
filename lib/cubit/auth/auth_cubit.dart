import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_password_app/core/models/user_model.dart';
import 'package:my_password_app/core/services/google_service.dart';
import 'package:my_password_app/core/services/share_pref_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signInWithGoogle({
    required ValueChanged<String> onError,
  }) async {
    try {
      final userModel = await GoogleService.signInWithGoogle();
      emit(AuthSignIn(userModel));
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<void> checkSignInStatus({
    required ValueChanged<String> onError,
  }) async {
    try {
      final userModel = await GoogleService.checkCurrentUser();
      if (userModel != null) {
        emit(AuthSignIn(userModel));
      } else {
        emit(AuthSignOut());
      }
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<void> signOutWithGoogle({
    required ValueChanged<String> onError,
  }) async {
    try {
      await GoogleService.signOutWithGoogle();
      await SharePref.removeAllSavedDataPref();
      emit(AuthSignOut());
    } catch (e) {
      onError(e.toString());
    }
  }
}
