import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInState {
  final AsyncValue<GoogleSignInAccount?> googleSignInAccount;

  SignInState({
    required this.googleSignInAccount,
  });

  SignInState copyWith({
    AsyncValue<GoogleSignInAccount?>? googleSignInAccount,
  }) =>
      SignInState(
        googleSignInAccount: googleSignInAccount ?? this.googleSignInAccount,
      );
}
