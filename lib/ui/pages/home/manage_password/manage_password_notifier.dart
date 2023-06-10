import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/services/shared_pref_service.dart';
import 'package:my_password_app/core/enums/generate_enum.dart';
import 'package:my_password_app/core/models/password_model.dart';
import 'package:my_password_app/core/utils/my_print.dart';
import 'package:my_password_app/ui/pages/home/home_notifier.dart';
import 'package:my_password_app/ui/pages/home/manage_password/manage_password_state.dart';

final managePasswordNotifier = StateNotifierProvider.autoDispose<
    ManagePasswordNotifier, ManagePasswordState>((ref) {
  return ManagePasswordNotifier(
    ManagePasswordState(
        result: AsyncData(''),
        passwords: ref.read(homeNotifier.select((value) => value.passwords)),
        email: TextEditingController(),
        name: TextEditingController(),
        note: TextEditingController(),
        password: TextEditingController(),
        selectedPasswordModel: null,
        passwordLength: 10,
        passwordConfig: Map.fromIterable(
          GenerateEnum.values,
          key: (element) => element,
          value: (element) => true,
        )),
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
    myPrint('addPassword');
    final value = state.passwords.value;
    state = state.copyWith(result: AsyncLoading());
    state = state.copyWith(
        result: await AsyncValue.guard(() async {
      await Future.delayed(Duration(seconds: 1));
      if (value.contains(state.passwordModel)) {
        throw 'Duplicate data';
      }
      final newValue = [...value, state.passwordModel];
      await _sharedPrefService.save(newValue);
      return 'Success add data';
    }));
  }

  void deletePassword() async {
    final value = state.passwords.value;
    print('called');
    state = state.copyWith(result: AsyncLoading());
    state = state.copyWith(
      result: await AsyncValue.guard(() async {
        await Future.delayed(Duration(seconds: 1));
        value.remove(state.passwordModel);
        await _sharedPrefService.save([...value]);
        return 'Success delete data';
      }),
    );
  }

  void updatePassword() async {
    final value = state.passwords.value;
    print('called');
    state = state.copyWith(result: AsyncLoading());
    state = state.copyWith(
        result: await AsyncValue.guard(() async {
      await Future.delayed(Duration(seconds: 1));
      value.remove(state.selectedPasswordModel);
      await _sharedPrefService.save([...value, state.passwordModel]);
      return 'Success update data';
    }));
  }

  void setEditable(bool? editable) {
    state = state.copyWith(
      editable: editable,
    );
  }

  void setPasswordLength(int? val) {
    state = state.copyWith(passwordLength: val);
  }

  void setPasswordConfig(Map<GenerateEnum, bool>? val) {
    state = state.copyWith(
      passwordConfig: val,
    );
  }
}
