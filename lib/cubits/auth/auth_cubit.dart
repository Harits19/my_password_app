import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_password_app/core/models/user_model.dart';
import 'package:my_password_app/core/services/google_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthSignOut());

  Future<void> signInWithGoogle() async {
    final userModel = await GoogleService.signInWithGoogle();
    emit(AuthSignIn(userModel));
  }

  Future<void> checkSignInStatus() async {
    final userModel = await GoogleService.checkCurrentUser();
    if (userModel != null) {
      emit(AuthSignIn(userModel));
    } else {
      emit(AuthSignOut());
    }
  }

  Future<void> signOutWithGoogle({
    required ValueChanged<String> onError,
  }) async {
    try {
      await GoogleService.signOutWithGoogle();
      emit(AuthSignOut());
    } catch (e) {
      onError(e.toString());
    }
  }
}
