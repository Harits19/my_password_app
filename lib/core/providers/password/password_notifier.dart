import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/models/password_model.dart';
import 'package:my_password_app/core/services/password_service.dart';

final passwordProvider =
    StateNotifierProvider<PasswordNotifier, List<PasswordModel>>(
        (ref) => PasswordNotifier()..get());

class PasswordNotifier extends StateNotifier<List<PasswordModel>> {
  PasswordNotifier() : super([]);

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

  void sync() async {
    await PasswordService.save(state);
    get();
  }

  void get() {
    final result = PasswordService.get();
    state = result;
  }
}
