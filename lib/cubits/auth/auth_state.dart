part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}


class AuthSignOut extends AuthState {}

class AuthSignIn extends AuthState {
  final UserModel userModel;

  AuthSignIn(this.userModel);
}
