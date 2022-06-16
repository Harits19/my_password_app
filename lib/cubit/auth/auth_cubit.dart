import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_password_app/core/models/user_model.dart';
import 'package:my_password_app/core/services/google_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signInWithGoogle({
    required ValueChanged<String> onError,
  }) async {
    try {
      final userModel = await GoogleService.signInWithGoogle();
      emit(AuthLoaded(userModel));
    } catch (e) {
      onError(e.toString());
    }
  }
}
