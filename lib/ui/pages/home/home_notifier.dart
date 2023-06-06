import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/services/google_drive_service.dart';
import 'package:my_password_app/core/services/shared_pref_service.dart';
import 'package:my_password_app/models/password_model.dart';
import 'package:my_password_app/ui/pages/home/home_state.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_notifier.dart';

final homeNotifier = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(
    HomeState(
      passwords: AsyncData([]),
      googleSignInAccount: ref.watch(
        signInProvider.select(
          (value) => value.googleSignInAccount,
        ),
      ),
    ),
    googleDriveService: ref.watch(googleDriveService),
    passwordService: ref.watch(sharedPrefService),
  )..getListPassword();
});

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(
    super.state, {
    required GoogleDriveService googleDriveService,
    required SharedPrefService passwordService,
  })  : this._googleDriveService = googleDriveService,
        this._sharedPrefService = passwordService;

  final GoogleDriveService _googleDriveService;
  final SharedPrefService _sharedPrefService;
  void check() async {
    state.googleSignInAccount.whenData((account) async {
      if (account == null) return;
      final dummyList = List.generate(
          10,
          (index) =>
              PasswordModel(name: 'name $index', password: 'password $index'));
      _googleDriveService.syncPasswordList(
        account: account,
        list: dummyList,
      );
    });
  }

  void getListPassword() {
    final result = _sharedPrefService.getListPassword();
    state = state.copyWith(
      passwords: AsyncData(result),
    );
  }
}
