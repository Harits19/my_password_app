import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeState {
  final AsyncValue<GoogleSignInAccount?> googleSignInAccount;

  HomeState({required this.googleSignInAccount});

  HomeState copyWith({
    AsyncValue<GoogleSignInAccount?>? googleSignInAccount
  }) {
    return HomeState(
      googleSignInAccount: googleSignInAccount ?? this.googleSignInAccount,
    );
  }
}
