part of 'password_cubit.dart';

enum PasswordStateEnum { loaded, createAppPassword }

class PasswordOldState {
  final List<PasswordModel> listPassword;
  final PasswordModel? appPassword;
  final bool isAuthenticated;
  final PasswordStateEnum? passwordState;
  final bool showAuthenticationDialog;

  PasswordOldState({
    required this.listPassword,
    required this.appPassword,
    required this.passwordState,
    required this.isAuthenticated,
  }) : showAuthenticationDialog = !isAuthenticated;

  PasswordOldState copyWith({
    List<PasswordModel>? listPassword,
    PasswordModel? appPassword,
    bool? isAuthenticated,
    PasswordStateEnum? passwordState,
  }) {
    return PasswordOldState(
      listPassword: listPassword ?? this.listPassword,
      appPassword: appPassword ?? this.appPassword,
      passwordState: passwordState ?? this.passwordState,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
