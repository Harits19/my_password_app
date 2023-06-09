import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/enums/sync_enum.dart';
import 'package:my_password_app/core/services/google_drive_service.dart';
import 'package:my_password_app/core/services/shared_pref_service.dart';
import 'package:my_password_app/ui/pages/home/home_state.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_notifier.dart';

final homeNotifier = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(
    HomeState(
      search: '',
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
  void sycnData({
    required SyncEnum sync,
  }) async {
    final passwordTemp = state.passwords;
    state = state.copyWith(
      passwords: AsyncLoading(),
    );
    state = state.copyWith(
      passwords: await AsyncValue.guard(() async {
        final account = state.googleSignInAccount.valueOrNull;
        if (account == null) return [];
        final lastData = await _googleDriveService.syncPasswordList(
          account: account,
          list: passwordTemp.valueOrNull ?? [],
          sync: sync,
        );
        await _sharedPrefService.save(lastData);
        return lastData;
      }),
    );
  }

  void getListPassword() async {
    state = state.copyWith(
      passwords: AsyncData(_sharedPrefService.getListPassword()),
    );
  }

  void setSearch(String? val) {
    state = state.copyWith(search: val);
  }
}
