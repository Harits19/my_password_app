import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_password_app/models/password_model.dart';

class HomeState {
  final AsyncValue<GoogleSignInAccount?> googleSignInAccount;
  final AsyncValue<List<PasswordModel>> passwords;

  HomeState({
    required this.googleSignInAccount,
    required this.passwords,
  });

  HomeState copyWith({
    AsyncValue<GoogleSignInAccount?>? googleSignInAccount,
    AsyncValue<List<PasswordModel>>? passwords,
  }) {
    return HomeState(
      googleSignInAccount: googleSignInAccount ?? this.googleSignInAccount,
      passwords: passwords ?? this.passwords,
    );
  }
}
