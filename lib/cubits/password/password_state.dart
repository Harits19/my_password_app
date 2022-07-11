part of 'password_cubit.dart';

abstract class PasswordState extends Equatable {
  const PasswordState();

  @override
  List<Object?> get props => [];
}

class PasswordLoaded extends PasswordState {
  final List<PasswordModel> listPassword;
  final PasswordModel? appPassword;
  final bool isAuthenticated;

  PasswordLoaded({
    required this.listPassword,
    this.appPassword,
    required this.isAuthenticated,
  });

  @override
  List<Object?> get props => [
        listPassword,
        appPassword,
        isAuthenticated,
      ];
}

class PasswordIdle extends PasswordState {
  final List<PasswordModel> listPassword;

  PasswordIdle({
    required this.listPassword,
  });
}

class PasswordCreatePasswordApp extends PasswordState {} // create password app;
