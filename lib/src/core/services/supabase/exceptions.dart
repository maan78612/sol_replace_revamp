class EmailNotConfirmedException implements Exception {
  final String email;
  final dynamic originalException;

  EmailNotConfirmedException({required this.email, this.originalException});

  @override
  String toString() => 'Email not confirmed for $email';
}