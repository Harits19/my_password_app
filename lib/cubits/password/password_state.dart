part of 'password_cubit.dart';

enum PasswordStateEnum { loaded, createAppPassword }

class PasswordState extends Equatable {
  final List<PasswordModel> listPassword;
  final PasswordModel? appPassword;
  final bool isAuthenticated;
  final PasswordStateEnum passwordState;

  PasswordState({
    required this.listPassword,
    required this.appPassword,
    required this.passwordState,
    required this.isAuthenticated,
  });

  @override
  List<Object?> get props => [
        listPassword,
        appPassword,
        isAuthenticated,
      ];
}
