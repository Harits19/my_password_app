import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/models/password_model.dart';

final passwordProvider =
    StateNotifierProvider<PasswordNotifier, List<PasswordModel>>(
        (ref) => PasswordNotifier());

class PasswordNotifier extends StateNotifier<List<PasswordModel>> {
  PasswordNotifier() : super([]);

  void add(PasswordModel passwordModel) {
    state.add(passwordModel);
    state = [...state];
  }

  void remove(String id) {
    state.removeWhere((element) => element.id == id);
    state = [...state];
  }

  void update(PasswordModel passwordModel) {
    state = state
        .map(
          (e) => e.id == passwordModel.id ? passwordModel : e,
        )
        .toList();

    print(state.first.name);
  }

  void _sync(){
    
  }
}
