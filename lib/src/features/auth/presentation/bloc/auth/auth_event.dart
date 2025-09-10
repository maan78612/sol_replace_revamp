part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthTypeChanged extends AuthEvent {
  final AuthType authType;

  const AuthTypeChanged(this.authType);

  @override
  List<Object?> get props => [authType];
}

class SignInWithGoogle extends AuthEvent {
  const SignInWithGoogle();
}

class SignInWithFacebook extends AuthEvent {
  const SignInWithFacebook();
}
