part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  const SignUpEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class SignUpFirstNameChanged extends SignUpEvent {
  final String name;

  const SignUpFirstNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class SignUpLastNameChanged extends SignUpEvent {
  final String name;

  const SignUpLastNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  const SignUpPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class SignUpConfirmPasswordChanged extends SignUpEvent {
  final String confirmPassword;

  const SignUpConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}

class SignUpDateOfBirthChanged extends SignUpEvent {
  final DateTime dateOfBirth;

  const SignUpDateOfBirthChanged(this.dateOfBirth);

  @override
  List<Object?> get props => [dateOfBirth];
}

class SignUpTermsToggled extends SignUpEvent {
  final bool acceptTerms;

  const SignUpTermsToggled(this.acceptTerms);

  @override
  List<Object?> get props => [acceptTerms];
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();
}

class SignUpDataCleared extends SignUpEvent {
  const SignUpDataCleared();
}
