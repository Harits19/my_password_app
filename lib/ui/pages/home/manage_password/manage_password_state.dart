import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/models/password_model.dart';

class ManagePasswordState {
  final AsyncValue<String> result;
  final AsyncValue<List<PasswordModel>> passwords;

  ManagePasswordState({
    required this.result,
    required this.passwords,
  });

  ManagePasswordState copyWith({
    AsyncValue<String>? result,
  }) =>
      ManagePasswordState(
        result: result ?? this.result,
        passwords: passwords,
      );
}
