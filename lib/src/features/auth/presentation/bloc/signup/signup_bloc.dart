part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository;

  SignUpBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(SignUpState.initial()) {
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpFirstNameChanged>(_onFirstNameChanged);
    on<SignUpLastNameChanged>(_onLastNameChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignUpDateOfBirthChanged>(_onDateOfBirthChanged);
    on<SignUpTermsToggled>(_onTermsToggled);
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<SignUpDataCleared>(_onDataCleared);
  }

  void _onEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
    // Handle validation like Riverpod version - immediate validation
    final emailError = TextFieldValidator.validateEmail(event.email);
    state.emailController.error = emailError;

    // Update form validation state
    final isFormValid = _validateForm();
    emit(state.copyWith(isFormValid: isFormValid, errorMessage: null));
  }

  void _onFirstNameChanged(SignUpFirstNameChanged event, Emitter<SignUpState> emit) {
    // Handle validation like Riverpod version - immediate validation
    final nameError = TextFieldValidator.validateFullName(event.name);
    state.firstNameController.error = nameError;

    // Update form validation state
    final isFormValid = _validateForm();
    emit(state.copyWith(isFormValid: isFormValid, errorMessage: null));
  }

  void _onLastNameChanged(SignUpLastNameChanged event, Emitter<SignUpState> emit) {
    // Handle validation like Riverpod version - immediate validation
    final nameError = TextFieldValidator.validateFullName(event.name);
    state.lastNameController.error = nameError;

    // Update form validation state
    final isFormValid = _validateForm();
    emit(state.copyWith(isFormValid: isFormValid, errorMessage: null));
  }


  void _onPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    final password = event.password;
    final hasMinLength = password.length >= 8;
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // Handle validation like Riverpod version - immediate validation
    final passwordError = (!hasMinLength || !hasUppercase || !hasSpecialChar)
        ? "Password requirements not met"
        : null;
    state.passwordController.error = passwordError;

    // Re-validate confirm password if it's not empty
    if (state.confirmPasswordController.controller.text.isNotEmpty) {
      final confirmPasswordError = TextFieldValidator.validateConfirmPassword(
        state.confirmPasswordController.controller.text,
        password,
      );
      state.confirmPasswordController.error = confirmPasswordError;
    }

    final shouldShowPasswordValidation =
        state.passwordController.focusNode.hasFocus || password.isNotEmpty;

    // Update form validation state
    final isFormValid = _validateForm();
    emit(
      state.copyWith(
        hasMinLength: hasMinLength,
        hasUppercase: hasUppercase,
        hasSpecialChar: hasSpecialChar,
        shouldShowPasswordValidation: shouldShowPasswordValidation,
        isFormValid: isFormValid,
        errorMessage: null,
      ),
    );
  }

  void _onConfirmPasswordChanged(
    SignUpConfirmPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    // Handle validation like Riverpod version - immediate validation
    final confirmPasswordError = TextFieldValidator.validateConfirmPassword(
      event.confirmPassword,
      state.passwordController.controller.text,
    );
    state.confirmPasswordController.error = confirmPasswordError;

    // Update form validation state
    final isFormValid = _validateForm();
    emit(state.copyWith(isFormValid: isFormValid, errorMessage: null));
  }

  void _onDateOfBirthChanged(
    SignUpDateOfBirthChanged event,
    Emitter<SignUpState> emit,
  ) {
    if (_isAtLeast18YearsOld(event.dateOfBirth)) {
      state.dobController.controller.text = DateFormat(
        'dd / MM / yyyy',
      ).format(event.dateOfBirth);
      state.dobController.error = null;

      // Immediate form validation
      final isFormValid = _validateForm();
      emit(state.copyWith(
        dateOfBirth: event.dateOfBirth, 
        isFormValid: isFormValid,
        errorMessage: null,
      ));
    } else {
      state.dobController.error = "Selected age is less than 18";
      state.dobController.controller.clear();

      // Immediate form validation
      final isFormValid = _validateForm();
      emit(state.copyWith(
        dateOfBirth: null, 
        isFormValid: isFormValid,
        errorMessage: null,
      ));
    }
  }

  void _onTermsToggled(SignUpTermsToggled event, Emitter<SignUpState> emit) {
    // Immediate form validation
    final isFormValid = _validateForm(acceptTerms: event.acceptTerms);
    emit(state.copyWith(
      acceptTerms: event.acceptTerms, 
      isFormValid: isFormValid,
      errorMessage: null,
    ));
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await _authRepository.registerUser(
        UserModel(
          name: state.firstNameController.controller.text,
          email: state.emailController.controller.text,
          imageUrl: '',
          createdAt: DateTime.now(),
          role: UserType.user,
          authId: '',
          dob: state.dateOfBirth!,
        ),
        state.passwordController.controller.text.trim(),
      );

      add(const SignUpDataCleared());
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    }
  }

  void _onDataCleared(SignUpDataCleared event, Emitter<SignUpState> emit) {
    state.firstNameController.controller.clear();
    state.lastNameController.controller.clear();
    state.emailController.controller.clear();
    state.passwordController.controller.clear();
    state.confirmPasswordController.controller.clear();
    state.dobController.controller.clear();

    emit(
      state.copyWith(
        dateOfBirth: null,
        acceptTerms: false,
        profileImage: null,
        hasMinLength: false,
        hasUppercase: false,
        hasSpecialChar: false,
        shouldShowPasswordValidation: false,
        isFormValid: false,
        errorMessage: null,
      ),
    );
  }

  bool _validateForm({bool? acceptTerms}) {
    final isValidEmail =
        state.emailController.controller.text.isNotEmpty &&
        state.emailController.error == null;

    final isValidFirstName =
        state.firstNameController.controller.text.isNotEmpty &&
        state.firstNameController.error == null;

    final isValidLastName =
        state.lastNameController.controller.text.isNotEmpty &&
        state.lastNameController.error == null;

    final isValidPassword =
        state.passwordController.controller.text.isNotEmpty &&
        state.passwordController.error == null &&
        state.hasMinLength &&
        state.hasUppercase &&
        state.hasSpecialChar;

    final isValidConfirmPassword =
        state.confirmPasswordController.controller.text.isNotEmpty &&
        state.confirmPasswordController.error == null;

    final isValidDateOfBirth = state.dateOfBirth != null && state.dobController.error == null;

    final terms = acceptTerms ?? state.acceptTerms;

    return isValidEmail &&
        isValidFirstName &&
        isValidLastName &&
        isValidPassword &&
        isValidConfirmPassword &&
        isValidDateOfBirth &&
        terms;
  }

  bool _isAtLeast18YearsOld(DateTime date) {
    final today = DateTime.now();
    final age = today.year - date.year;

    if (age > 18) return true;
    if (age == 18) {
      // Check if the birthday has occurred this year
      if (today.month > date.month) return true;
      if (today.month == date.month && today.day >= date.day) return true;
    }
    return false;
  }

  @override
  Future<void> close() {
    state.firstNameController.controller.dispose();
    state.lastNameController.controller.dispose();
    state.emailController.controller.dispose();
    state.passwordController.controller.dispose();
    state.confirmPasswordController.controller.dispose();
    state.dobController.controller.dispose();
    return super.close();
  }
}
