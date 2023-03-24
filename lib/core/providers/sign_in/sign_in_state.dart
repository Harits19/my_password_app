import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/core/models/master_password_model.dart';

class SignInState {
  final MasterPasswordModel? masterPasswordModel;
  final bool isLoggedIn;

  bool get haveMasterPassword => (masterPasswordModel?.password).isNotNullEmpty;

  SignInState({
    this.masterPasswordModel,
    this.isLoggedIn = false,
  });

  SignInState copyWith({
    bool? isLoggedIn,
  }) {
    return SignInState(
      masterPasswordModel: masterPasswordModel,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
