part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _LoginViewModel with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  bool _isBtnEnabled = false;
  final CustomTextController emailCont = CustomTextController(
    controller: TextEditingController(),
    focusNode: FocusNode(),
  );
  final CustomTextController passwordCont = CustomTextController(
    controller: TextEditingController(),
    focusNode: FocusNode(),
  );

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool get isBtnEnabled => _isBtnEnabled;

  bool get _isValidEmail =>
      emailCont.controller.text.isNotEmpty && emailCont.error == null;

  bool get _isValidPassword =>
      passwordCont.controller.text.isNotEmpty && emailCont.error == null;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  void onChange({
    required CustomTextController con,
    String? Function(String?)? validator,
    required String value,
  }) {
    if (validator != null) {
      con.error = validator(value);
    }
    _setEnableBtn();
  }

  void _setEnableBtn() {
    _isBtnEnabled = _isValidEmail && _isValidPassword;
    notifyListeners();
  }

  Future<void> loginUser() async {
    setLoading(true);
    try {
      final userModel = await _authRepository.signInWithEmailPassword(
        emailCont.controller.text.trim(),
        passwordCont.controller.text.trim(),
      );
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    } finally {
      setLoading(true);
    }
  }

}
