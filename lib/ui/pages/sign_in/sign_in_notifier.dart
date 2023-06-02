import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/services/google_api_service.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_state.dart';
import 'package:my_password_app/core/services/local_auth_service.dart';
import 'package:my_password_app/core/services/sign_in_service.dart';
import 'package:my_password_app/ui/widgets/snack_bar_widget.dart';

final signInProvider =
    StateNotifierProvider<SignInNotifier, SignInState>((ref) {
  return SignInNotifier(
    SignInState(
      googleSignInAccount: AsyncData(null),
    ),
    googleApiService: ref.watch(googleApiService),
  );
});

class SignInNotifier extends StateNotifier<SignInState> {
  SignInNotifier(
    super.state, {
    required GoogleApiService googleApiService,
  }) : this._googleApiService = googleApiService;

  final GoogleApiService _googleApiService;

  void signIn() async {
    try {
      state = state.copyWith(
        googleSignInAccount: AsyncLoading(),
      );
      final result = await _googleApiService.signIn();
      state = state.copyWith(
        googleSignInAccount: AsyncData(result),
      );
    } catch (e) {
      state = state.copyWith(
        googleSignInAccount: AsyncError(e, StackTrace.current),
      );
    }
  }

  void signOut() async {
    try {
      state = state.copyWith(
        googleSignInAccount: AsyncLoading(),
      );
      final result = await _googleApiService.signOut();
      state = state.copyWith(
        googleSignInAccount: AsyncData(result),
      );
    } catch (e) {
      state = state.copyWith(
        googleSignInAccount: AsyncError(e, StackTrace.current),
      );
    }
  }
}
