part of 'package:sol_replace_revamp/src/features/forget_password/forget_password_library.dart';

class SendEmailState extends Equatable {
  final CustomTextController emailController;
  final bool isLoading;
  final bool isFormValid;
  final String? errorMessage;

  const SendEmailState({
    required this.emailController,
    this.isLoading = false,
    this.isFormValid = false,
    this.errorMessage,
  });

  SendEmailState copyWith({
    CustomTextController? emailController,
    bool? isLoading,
    bool? isFormValid,
    String? errorMessage,
  }) {
    return SendEmailState(
      emailController: emailController ?? this.emailController,
      isLoading: isLoading ?? this.isLoading,
      isFormValid: isFormValid ?? this.isFormValid,
      errorMessage: errorMessage,
    );
  }

  factory SendEmailState.initial() {
    return SendEmailState(
      emailController: CustomTextController(
        controller: TextEditingController(),
        focusNode: FocusNode(),
      ),
    );
  }

  @override
  List<Object?> get props => [
        emailController.controller.text,
        emailController.error,
        isLoading,
        isFormValid,
        errorMessage,
      ];
}
