part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class AuthState extends Equatable {
  final AuthType authType;
  final bool isLoading;
  final String? errorMessage;

  const AuthState({
    this.authType = AuthType.login,
    this.isLoading = false,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthType? authType,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      authType: authType ?? this.authType,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [authType, isLoading, errorMessage];
}
