import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_password_app/models/password_model.dart';

class HomeState {
  final AsyncValue<GoogleSignInAccount?> googleSignInAccount;
  final AsyncValue<List<PasswordModel>> passwords;
  final String search;

  HomeState({
    required this.googleSignInAccount,
    required this.passwords,
    required this.search,
  });

  HomeState copyWith({
    AsyncValue<GoogleSignInAccount?>? googleSignInAccount,
    AsyncValue<List<PasswordModel>>? passwords,
    String? search,
  }) {
    return HomeState(
      googleSignInAccount: googleSignInAccount ?? this.googleSignInAccount,
      passwords: passwords ?? this.passwords,
      search: search ?? this.search,
    );
  }

  List<PasswordModel> get showedList {
    final passwords = this.passwords.valueOrNull ?? [];
    bool check(String? val) {
      return (val?.toLowerCase().contains(search.toLowerCase()) ?? false);
    }

    if (search.isNotEmpty) {
      return passwords.where((element) {
        return check(element.email) || check(element.name);
      }).toList();
    }
    return passwords;
  }
}
