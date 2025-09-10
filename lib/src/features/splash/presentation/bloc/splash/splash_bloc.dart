part of 'package:sol_replace_revamp/src/features/splash/splash_library.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashRepository _splashRepository;

  SplashBloc({
    required SplashRepository splashRepository,
  })  : _splashRepository = splashRepository,
        super(const SplashState()) {
    on<CheckAutoLogin>(_onCheckAutoLogin);
    on<NavigateToAuth>(_onNavigateToAuth);
    on<NavigateToMainApp>(_onNavigateToMainApp);
  }

  Future<void> _onCheckAutoLogin(
    CheckAutoLogin event,
    Emitter<SplashState> emit,
  ) async {
    if (state.hasNavigated) return; // Prevent multiple navigation attempts
    
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      // Use isolate for session check to avoid blocking UI thread
      final session = await _checkSessionInIsolate();

      if (kDebugMode) {
        debugPrint("session = $session");
      }

      if (session != null && session.accessToken.isNotEmpty) {
        if (kDebugMode) {
          debugPrint("Active session found, attempting auto login");
        }
        await _handleAutoLogin(session, emit);
      } else {
        if (kDebugMode) {
          debugPrint("No active session found, navigating to auth screen");
        }
        await _navigateToAuthScreen(emit);
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Auto login error: ${e.toString()}");
      }
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      await _navigateToAuthScreen(emit);
    }
  }
  
  Future<Session?> _checkSessionInIsolate() async {
    // For now, keep it simple but add caching
    return _splashRepository.getCurrentSession();
  }

  Future<void> _onNavigateToAuth(
    NavigateToAuth event,
    Emitter<SplashState> emit,
  ) async {
    await _navigateToAuthScreen(emit);
  }

  Future<void> _onNavigateToMainApp(
    NavigateToMainApp event,
    Emitter<SplashState> emit,
  ) async {
    await _navigateToMainApp(emit);
  }

  // ========================================
  // AUTO LOGIN HANDLING
  // ========================================
  Future<void> _handleAutoLogin(
    Session session,
    Emitter<SplashState> emit,
  ) async {
    try {
      await _splashRepository.fetchUser(session.accessToken);
      // Note: We'll need to handle user state differently since we're not using Riverpod
      // For now, we'll just navigate to main app
      await _navigateToMainApp(emit);
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Failed to fetch user: ${e.toString()}");
      }
      // If user fetch fails, navigate to auth screen
      await _navigateToAuthScreen(emit);
    }
  }

  // Navigate to auth screen when no user is found
  Future<void> _navigateToAuthScreen(Emitter<SplashState> emit) async {
    if (state.hasNavigated) return; // Prevent multiple navigation calls
    
    try {
      // Reduce delay for better performance
      await Future.delayed(const Duration(milliseconds: 300));
      
      // Import auth view here to avoid circular dependency
      await CustomNavigation().pushAndRemoveUntil(
        const AuthView(),
        animate: true,
        direction: AxisDirection.left,
      );
      emit(state.copyWith(isLoading: false, hasNavigated: true));
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Navigation error: ${e.toString()}");
      }
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  // Navigate to main app after successful login
  Future<void> _navigateToMainApp(Emitter<SplashState> emit) async {
    if (state.hasNavigated) return; // Prevent multiple navigation calls
    
    try {
      // Reduce delay for better performance
      await Future.delayed(const Duration(milliseconds: 300));
      
      // TODO: Replace with your main app screen
      // For now, navigate to auth screen as placeholder
      await CustomNavigation().pushAndRemoveUntil(
        const AuthView(),
        animate: true,
        direction: AxisDirection.left,
      );
      emit(state.copyWith(isLoading: false, hasNavigated: true));
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Navigation error: ${e.toString()}");
      }
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
