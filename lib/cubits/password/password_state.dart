part of 'password_cubit.dart';

enum PasswordStateEnum { loaded, createAppPassword }

class PasswordState extends Equatable {
  final List<PasswordModel> listPassword;
  final PasswordModel? appPassword;
  final bool isAuthenticated;
  final PasswordStateEnum passwordState;
  final bool showAuthenticationDialog;

  PasswordState({
    required this.listPassword,
    required this.appPassword,
    required this.passwordState,
    required this.isAuthenticated,
  }) : showAuthenticationDialog = !isAuthenticated;

  PasswordState copyWith({
    List<PasswordModel>? listPassword,
    PasswordModel? appPassword,
    bool? isAuthenticated,
    PasswordStateEnum? passwordState,
  }) {
    return PasswordState(
      listPassword: listPassword ?? this.listPassword,
      appPassword: appPassword ?? this.appPassword,
      passwordState: passwordState ?? this.passwordState,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  List<Object?> get props => [
        listPassword,
        appPassword,
        passwordState,
        isAuthenticated,
      ];
}
