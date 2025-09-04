part of 'package:sol_replace_revamp/src/features/splash/splash_library.dart';

class SplashViewModel with ChangeNotifier {
  late final Ref _ref;

  SplashViewModel(this._ref);

  final SplashRepository _splashRepository = SplashRepositoryImpl();

  // ========================================
  // STATE VARIABLES
  // ========================================
  bool _isLoading = false;

  // ========================================
  // GETTERS
  // ========================================
  bool get isLoading => _isLoading;

  // ========================================
  // STATE MANAGEMENT
  // ========================================
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // ========================================
  // AUTO LOGIN METHODS
  // ========================================
  Future<void> checkAutoLogin() async {
    setLoading(true);
    try {
      // Check if user has an active session
      final session = _splashRepository.getCurrentSession();

      debugPrint("session = $session");

      if (session != null && session.accessToken.isNotEmpty) {
        debugPrint("Active session found, attempting auto login");
        await _handleAutoLogin(session);
      } else {
        debugPrint("No active session found, navigating to auth screen");
        await _navigateToAuthScreen();
      }
    } catch (e) {
      debugPrint("Auto login error: ${e.toString()}");
      await _navigateToAuthScreen();
    } finally {
      setLoading(false);
    }
  }

  // ========================================
  // AUTO LOGIN HANDLING
  // ========================================
  Future<void> _handleAutoLogin(Session session) async {
    try {
      final user = await _splashRepository.fetchUser(session.accessToken);
      _ref.read(userModelProvider.notifier).setUser(user);
      
      // Navigate to main app after successful auto-login
      await _navigateToMainApp();
    } catch (e) {
      debugPrint("Failed to fetch user: ${e.toString()}");
      // If user fetch fails, navigate to auth screen
      await _navigateToAuthScreen();
    }
  }

  // Navigate to auth screen when no user is found
  Future<void> _navigateToAuthScreen() async {
    try {
      // Add a small delay to ensure animation completes
      await Future.delayed(Duration(milliseconds: 500));
      
      // Import auth view here to avoid circular dependency
      await CustomNavigation().pushAndRemoveUntil(
        AuthView(),
        animate: true,
        direction: AxisDirection.left,
      );
    } catch (e) {
      debugPrint("Navigation error: ${e.toString()}");
    }
  }

  // Navigate to main app after successful login
  Future<void> _navigateToMainApp() async {
    try {
      // Add a small delay to ensure animation completes
      await Future.delayed(Duration(milliseconds: 500));
      
      // TODO: Replace with your main app screen
      // For now, navigate to auth screen as placeholder
      await CustomNavigation().pushAndRemoveUntil(
        AuthView(),
        animate: true,
        direction: AxisDirection.left,
      );
    } catch (e) {
      debugPrint("Navigation error: ${e.toString()}");
    }
  }
}
