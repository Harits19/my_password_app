part of 'password_cubit.dart';

abstract class PasswordState extends Equatable {
  const PasswordState();

  @override
  List<Object> get props => [];
}

class PasswordIdle extends PasswordState {
   final List<PasswordModel> listPassword;

  PasswordIdle({
    required this.listPassword,
  });
}

class PasswordLoaded extends PasswordState {
  final List<PasswordModel> listPassword;

  PasswordLoaded({
    required this.listPassword,
  });
}
