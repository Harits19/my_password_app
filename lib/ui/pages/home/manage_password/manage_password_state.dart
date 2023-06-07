import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/enums/generate_enum.dart';
import 'package:my_password_app/core/models/password_model.dart';

class ManagePasswordState {
  final AsyncValue<String> result;
  final AsyncValue<List<PasswordModel>> passwords;
  final TextEditingController name, password, email, note;
  final PasswordModel? selectedPasswordModel;
  final int passwordLength;
  final Map<GenerateEnum, bool> passwordConfig;

  ManagePasswordState({
    required this.result,
    required this.passwords,
    required this.email,
    required this.name,
    required this.note,
    required this.password,
    required this.selectedPasswordModel,
    required this.passwordLength,
    required this.passwordConfig,
  });

  ManagePasswordState copyWith({
    AsyncValue<String>? result,
    PasswordModel? selectedPasswordModel,
    bool? editable,
    int? passwordLength,
    Map<GenerateEnum, bool>? passwordConfig,
  }) =>
      ManagePasswordState(
        result: result ?? this.result,
        passwords: passwords,
        email: email,
        name: name,
        note: note,
        password: password,
        selectedPasswordModel:
            selectedPasswordModel ?? this.selectedPasswordModel,
        passwordLength: passwordLength ?? this.passwordLength,
        passwordConfig: passwordConfig ?? this.passwordConfig,
      );

  PasswordModel get passwordModel => PasswordModel(
        name: name.text,
        password: password.text,
        email: email.text,
        note: note.text,
      );
}
