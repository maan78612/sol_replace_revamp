part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class LoginState extends Equatable {
  final CustomTextController emailController;
  final CustomTextController passwordController;
  final bool isLoading;
  final bool isFormValid;
  final String? errorMessage;

  const LoginState({
    required this.emailController,
    required this.passwordController,
    this.isLoading = false,
    this.isFormValid = false,
    this.errorMessage,
  });

  LoginState copyWith({
    CustomTextController? emailController,
    CustomTextController? passwordController,
    bool? isLoading,
    bool? isFormValid,
    String? errorMessage,
  }) {
    return LoginState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      isLoading: isLoading ?? this.isLoading,
      isFormValid: isFormValid ?? this.isFormValid,
      errorMessage: errorMessage,
    );
  }

  factory LoginState.initial() {
    return LoginState(
      emailController: CustomTextController(
        controller: TextEditingController(),
        focusNode: FocusNode(),
      ),
      passwordController: CustomTextController(
        controller: TextEditingController(),
        focusNode: FocusNode(),
      ),
    );
  }

  @override
  List<Object?> get props => [
        emailController.controller.text,
        emailController.error,
        passwordController.controller.text,
        passwordController.error,
        isLoading,
        isFormValid,
        errorMessage,
      ];
}
