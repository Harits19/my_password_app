import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/services/google_api_service.dart';
import 'package:my_password_app/core/utils/my_print.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_state.dart';

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

  Timer? timer;

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void signIn() async {
    try {
      state = state.copyWith(
        googleSignInAccount: AsyncLoading(),
      );
      final result = await _googleApiService.signIn();
      state = state.copyWith(
        googleSignInAccount: AsyncData(result),
      );
      restartTimer();
    } catch (e) {
      state = state.copyWith(
        googleSignInAccount: AsyncError(e, StackTrace.current),
      );
    }
  }

  void restartTimer() async {
    myPrint('restartTimer');
    timer?.cancel();
    timer = Timer(
      Duration(minutes: 3),
      () async {
        _googleApiService.signOut();
        state = state.copyWith(
          googleSignInAccount: AsyncData(null),
        );
      },
    );
  }
}
