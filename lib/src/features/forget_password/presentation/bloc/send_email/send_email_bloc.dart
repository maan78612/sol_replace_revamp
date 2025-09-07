part of 'package:sol_replace_revamp/src/features/forget_password/forget_password_library.dart';

// Internal event for debounced validation
class _ValidateForm extends SendEmailEvent {
  const _ValidateForm();
}

class SendEmailBloc extends Bloc<SendEmailEvent, SendEmailState> {
  Timer? _debounceTimer;
  
  // Debounce duration for form validation
  static const Duration _debounceDuration = Duration(milliseconds: 300);

  SendEmailBloc() : super(SendEmailState.initial()) {
    on<SendEmailChanged>(_onEmailChanged);
    on<SendEmailSubmitted>(_onSendEmailSubmitted);
    on<_ValidateForm>(_onValidateForm);
  }

  void _onEmailChanged(SendEmailChanged event, Emitter<SendEmailState> emit) {
    final emailError = TextFieldValidator.validateEmail(event.email);
    state.emailController.error = emailError;
    
    // Debounce form validation to reduce unnecessary state emissions
    _debounceValidation();
  }
  
  void _debounceValidation() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDuration, () {
      add(const _ValidateForm());
    });
  }
  
  void _onValidateForm(_ValidateForm event, Emitter<SendEmailState> emit) {
    final isFormValid = _validateForm();
    if (state.isFormValid != isFormValid) {
      emit(state.copyWith(isFormValid: isFormValid, errorMessage: null));
    }
  }

  Future<void> _onSendEmailSubmitted(
    SendEmailSubmitted event,
    Emitter<SendEmailState> emit,
  ) async {
    if (!state.isFormValid || state.isLoading) return;
    
    emit(state.copyWith(isLoading: true, errorMessage: null));
    
    try {
      final email = state.emailController.controller.text.trim();
      
      // Create ForgetPassword-specific OTP repository
      final forgetPasswordDataSource = ForgetPasswordDataSource();
      final otpRepository = ServiceLocator.instance.createOtpRepository(
        forgetPasswordDataSource,
      );

      // Navigate to OTP view
      CustomNavigation().push(
        OtpView(
          email: email,
          onValidate: () async {
            // Handle successful OTP verification for password reset
            SnackBarUtils.show(
              'OTP verified! You can now reset your password.',
              SnackBarType.success,
            );
            // Navigate back to login or to password reset form
            CustomNavigation().pop();
          },
          description: "Enter the OTP sent to your email to reset your password",
          backToText: 'Back to Send Email',
          backToTab: () => CustomNavigation().pop(),
          sendInitialOtpCall: true,
          buttonText: 'Verify & Reset',
          repo: otpRepository, // Use ForgetPassword-specific OTP repository
        ),
      );
      
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    }
  }

  bool _validateForm() {
    final email = state.emailController.controller.text;
    final emailError = state.emailController.error;
    
    return email.isNotEmpty && emailError == null;
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    state.emailController.controller.dispose();
    state.emailController.focusNode.dispose();
    state.emailController.hasFocusNotifier.dispose();
    return super.close();
  }
}
