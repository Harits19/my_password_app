import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/services/shared_pref_service.dart';
import 'package:my_password_app/models/password_model.dart';
import 'package:my_password_app/ui/pages/home/home_notifier.dart';
import 'package:my_password_app/ui/pages/home/manage_password/manage_password_state.dart';

final managePasswordNotifier = StateNotifierProvider.autoDispose<
    ManagePasswordNotifier, ManagePasswordState>((ref) {
  return ManagePasswordNotifier(
    ManagePasswordState(
      result: AsyncData(''),
      passwords: ref.watch(homeNotifier.select((value) => value.passwords)),
      email: TextEditingController(),
      name: TextEditingController(),
      note: TextEditingController(),
      password: TextEditingController(),
      selectedPasswordModel: null,
    ),
    ref.watch(sharedPrefService),
  );
});

class ManagePasswordNotifier extends StateNotifier<ManagePasswordState> {
  ManagePasswordNotifier(
    super.state,
    this._sharedPrefService,
  );

  final SharedPrefService _sharedPrefService;

  void init(PasswordModel? passwordModel) {
    state = state.copyWith(selectedPasswordModel: passwordModel);
    state.email.text = passwordModel?.email ?? '';
    state.name.text = passwordModel?.name ?? '';
    state.note.text = passwordModel?.note ?? '';
    state.password.text = passwordModel?.password ?? '';
  }

  void addPassword() async {
    state.passwords.whenData((value) async {
      print('called');
      state = state.copyWith(result: AsyncLoading());
      await Future.delayed(Duration(seconds: 1));
      if (value.contains(state.passwordModel)) {
        state = state.copyWith(
          result: AsyncError('Duplicate data', StackTrace.current),
        );
        return;
      }
      final newValue = [...value, state.passwordModel];
      await _sharedPrefService.save(newValue);
      state = state.copyWith(result: AsyncData('Success add data'));
    });
  }

  void deletePassword() async {
    state.passwords.whenData((value) async {
      print('called');
      state = state.copyWith(result: AsyncLoading());
      await Future.delayed(Duration(seconds: 1));
      value.remove(state.passwordModel);
      await _sharedPrefService.save([...value]);
      state = state.copyWith(result: AsyncData('Success delete data'));
    });
  }

  void updatePassword() async {
    state.passwords.whenData((value) async {
      print('called');
      state = state.copyWith(result: AsyncLoading());
      await Future.delayed(Duration(seconds: 1));
      value.remove(state.selectedPasswordModel);
      await _sharedPrefService.save([...value, state.passwordModel]);
      state = state.copyWith(result: AsyncData('Success update data'));
    });
  }

  void setEditable(bool? editable) {
    state = state.copyWith(
      editable: editable,
    );
  }
}
