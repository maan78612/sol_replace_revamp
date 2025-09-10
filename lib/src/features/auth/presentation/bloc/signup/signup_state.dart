part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class SignUpState extends Equatable {
  final CustomTextController firstNameController;
  final CustomTextController lastNameController;
  final CustomTextController emailController;
  final CustomTextController passwordController;
  final CustomTextController confirmPasswordController;
  final CustomTextController dobController;
  final DateTime? dateOfBirth;
  final bool acceptTerms;
  final bool isLoading;
  final bool isFormValid;
  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasSpecialChar;
  final bool shouldShowPasswordValidation;
  final String? errorMessage;
  final File? profileImage;

  const SignUpState({
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.dobController,
    this.dateOfBirth,
    this.acceptTerms = false,
    this.isLoading = false,
    this.isFormValid = false,
    this.hasMinLength = false,
    this.hasUppercase = false,
    this.hasSpecialChar = false,
    this.shouldShowPasswordValidation = false,
    this.errorMessage,
    this.profileImage,
  });

  SignUpState copyWith({
    CustomTextController? nameController,
    CustomTextController? emailController,
    CustomTextController? passwordController,
    CustomTextController? confirmPasswordController,
    CustomTextController? dobController,
    DateTime? dateOfBirth,
    bool? acceptTerms,
    bool? isLoading,
    bool? isFormValid,
    bool? hasMinLength,
    bool? hasUppercase,
    bool? hasSpecialChar,
    bool? shouldShowPasswordValidation,
    String? errorMessage,
    File? profileImage,
  }) {
    return SignUpState(
      firstNameController: nameController ?? this.firstNameController,
      lastNameController: nameController ?? this.lastNameController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      confirmPasswordController:
          confirmPasswordController ?? this.confirmPasswordController,
      dobController: dobController ?? this.dobController,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      acceptTerms: acceptTerms ?? this.acceptTerms,
      isLoading: isLoading ?? this.isLoading,
      isFormValid: isFormValid ?? this.isFormValid,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasUppercase: hasUppercase ?? this.hasUppercase,
      hasSpecialChar: hasSpecialChar ?? this.hasSpecialChar,
      shouldShowPasswordValidation:
          shouldShowPasswordValidation ?? this.shouldShowPasswordValidation,
      errorMessage: errorMessage,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  factory SignUpState.initial() {
    return SignUpState(
      firstNameController: CustomTextController(
        controller: TextEditingController(),
        focusNode: FocusNode(),
      ),
      lastNameController: CustomTextController(
        controller: TextEditingController(),
        focusNode: FocusNode(),
      ),
      emailController: CustomTextController(
        controller: TextEditingController(),
        focusNode: FocusNode(),
      ),
      passwordController: CustomTextController(
        controller: TextEditingController(),
        focusNode: FocusNode(),
      ),
      confirmPasswordController: CustomTextController(
        controller: TextEditingController(),
        focusNode: FocusNode(),
      ),
      dobController: CustomTextController(
        controller: TextEditingController(),
        focusNode: FocusNode(),
      ),
    );
  }

  @override
  List<Object?> get props => [
    firstNameController.controller.text,
    lastNameController.controller.text,
    firstNameController.error,
    lastNameController.error,
    emailController.controller.text,
    emailController.error,
    passwordController.controller.text,
    passwordController.error,
    confirmPasswordController.controller.text,
    confirmPasswordController.error,
    dobController.controller.text,
    dobController.error,
    dateOfBirth,
    acceptTerms,
    isLoading,
    isFormValid,
    hasMinLength,
    hasUppercase,
    hasSpecialChar,
    shouldShowPasswordValidation,
    errorMessage,
    profileImage,
  ];
}
