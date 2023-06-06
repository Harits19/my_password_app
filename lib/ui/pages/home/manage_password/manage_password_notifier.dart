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

  void addPassword(PasswordModel passwordModel) async {
    state.passwords.whenData((value) async {
      print('called');
      state = state.copyWith(result: AsyncLoading());
      await Future.delayed(Duration(seconds: 1));
      if (value.contains(passwordModel)) {
        state = state.copyWith(
          result: AsyncError('Duplicate data', StackTrace.current),
        );
        return;
      }
      final newValue = [...value, passwordModel];
      await _sharedPrefService.save(newValue);
      state = state.copyWith(result: AsyncData('Success add data'));
    });
  }
}
