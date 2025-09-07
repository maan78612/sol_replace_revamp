part of 'package:sol_replace_revamp/src/features/forget_password/forget_password_library.dart';

abstract class SendEmailEvent extends Equatable {
  const SendEmailEvent();

  @override
  List<Object?> get props => [];
}

class SendEmailChanged extends SendEmailEvent {
  final String email;

  const SendEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class SendEmailSubmitted extends SendEmailEvent {
  const SendEmailSubmitted();
}
