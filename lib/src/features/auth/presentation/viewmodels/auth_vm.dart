part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _AuthVm with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepositoryImpl();
  AuthType _authScreenType = AuthType.login;

  AuthType get authScreenType => _authScreenType;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void loginSignUpHeader(AuthType authType) {
    if (_authScreenType == authType) {
      SnackBarUtils.show(
        authType == AuthType.login
            ? "You are already on Login Screen"
            : 'You are already on Sign Up Screen',
        SnackBarType.error,
      );
    } else {
      _authScreenType = authType;
      FocusManager.instance.primaryFocus?.unfocus();
    }
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    setLoading(true);
    try {
      final userModel = await _authRepository.signInWithGoogle();
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }

  Future<void> signInWithFacebook() async {
    setLoading(true);
    try {
      final userModel = await _authRepository.signInWithFacebook();
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }
}
