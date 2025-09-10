part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthState()) {
    on<AuthTypeChanged>(_onAuthTypeChanged);
    on<SignInWithGoogle>(_onSignInWithGoogle);
    on<SignInWithFacebook>(_onSignInWithFacebook);
  }

  void _onAuthTypeChanged(AuthTypeChanged event, Emitter<AuthState> emit) {
    if (state.authType == event.authType) {
      SnackBarUtils.show(
        event.authType == AuthType.login
            ? "You are already on Login Screen"
            : 'You are already on Sign Up Screen',
        SnackBarType.error,
      );
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      emit(state.copyWith(authType: event.authType, errorMessage: null));
    }
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    }
  }

  Future<void> _onSignInWithFacebook(
    SignInWithFacebook event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await _authRepository.signInWithFacebook();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    }
  }
}
