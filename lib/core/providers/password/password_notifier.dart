import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/providers/sign_in/sign_in_notifier.dart';
import 'package:my_password_app/core/services/share_service.dart';
import 'package:my_password_app/models/password_model.dart';
import 'package:my_password_app/core/services/password_service.dart';
import 'package:my_password_app/models/share_model.dart';
import 'package:my_password_app/utils/my_print.dart';

final passwordProvider =
    StateNotifierProvider<PasswordNotifier, List<PasswordModel>>(
  (ref) {
    return PasswordNotifier(
      ref,
    )..get();
  },
);

class PasswordNotifier extends StateNotifier<List<PasswordModel>> {
  PasswordNotifier(this.ref) : super([]);

  final Ref ref;

  void add(PasswordModel passwordModel) {
    state.add(passwordModel);
    state = [...state];
    sync();
  }

  void remove(String id) {
    state.removeWhere((element) => element.id == id);
    state = [...state];
    sync();
  }

  void update(PasswordModel passwordModel) {
    state = state
        .map(
          (e) => e.id == passwordModel.id ? passwordModel : e,
        )
        .toList();
    sync();
  }

  Future<void> sync() async {
    await PasswordService.save(state);
    get();
  }

  void get() {
    final result = PasswordService.get();
    state = result;
  }

  void export() {
    ShareService().export(ShareModel(
      signInState: ref.watch(signInProvider).copyWith(
            useFingerprint: false,
            isLoggedIn: false,
          ),
      passwords: state,
    ));
  }

  Future<bool> import() async {
    final shareModel = await ShareService().import();

    myPrint(shareModel?.toJson());
    if (shareModel == null) return false;
    final passwords = shareModel.passwords;
    final signInState = shareModel.signInState;
    state = passwords;
    await sync();
    final signRead = ref.read(signInProvider.notifier);
    await signRead.import(signInState);
    return true;
  }
}
