import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInState {
  final AsyncValue<GoogleSignInAccount?> googleSignInAccount;
  final Timer? timer;

  SignInState({
    required this.googleSignInAccount,
    required this.timer,
  });

  SignInState copyWith({
    AsyncValue<GoogleSignInAccount?>? googleSignInAccount,
    Timer? timer,
  }) =>
      SignInState(
        googleSignInAccount: googleSignInAccount ?? this.googleSignInAccount,
        timer: timer ?? this.timer,
      );
}
