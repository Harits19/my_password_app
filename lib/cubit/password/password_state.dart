part of 'password_cubit.dart';

@immutable
abstract class PasswordState extends Equatable {
  @override
  List<Object> get props => [];
}

class PasswordInitial extends PasswordState {}

class PasswordLoading extends PasswordState {}

class PasswordLoaded extends PasswordState {
  final Auth auth;
  final bool isLocalAuthSupported;
  PasswordLoaded(
    this.auth, {
    this.isLocalAuthSupported = false,
  });
}

class PasswordError extends PasswordState {
  final String error;
  PasswordError(dynamic error) : this.error = error.toString();
}
