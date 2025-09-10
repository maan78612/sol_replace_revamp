part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(LoginState.initial()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final emailError = TextFieldValidator.validateEmail(event.email);
    state.emailController.error = emailError;

    // Immediate form validation
    final isFormValid = _validateForm();
    emit(state.copyWith(isFormValid: isFormValid, errorMessage: null));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final passwordError = TextFieldValidator.validatePassword(event.password);
    state.passwordController.error = passwordError;

    // Immediate form validation
    final isFormValid = _validateForm();
    emit(state.copyWith(isFormValid: isFormValid, errorMessage: null));
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await _authRepository.signInWithEmailPassword(
        state.emailController.controller.text.trim(),
        state.passwordController.controller.text.trim(),
      );
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    }
  }


  bool _validateForm() {
    return state.emailController.controller.text.isNotEmpty &&
        state.passwordController.controller.text.isNotEmpty &&
        state.emailController.error == null &&
        state.passwordController.error == null;
  }

  @override
  Future<void> close() {
    state.emailController.controller.dispose();
    state.passwordController.controller.dispose();

    return super.close();
  }
}
