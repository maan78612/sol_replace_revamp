part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _SignUpVM with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepositoryImpl();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _selectTerms = false;
  File? _profileImg;
  DateTime? dob;

  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasSpecialChar = false;
  bool _isBtnEnabled = false;

  final CustomTextController nameCont = CustomTextController(
    controller: TextEditingController(),
    focusNode: FocusNode(),
  );

  final CustomTextController emailCont = CustomTextController(
    controller: TextEditingController(),
    focusNode: FocusNode(),
  );

  final CustomTextController passwordCont = CustomTextController(
    controller: TextEditingController(),
    focusNode: FocusNode(),
  );

  final CustomTextController confirmPassCont = CustomTextController(
    controller: TextEditingController(),
    focusNode: FocusNode(),
  );

  CustomTextController dobCon = CustomTextController(
    controller: TextEditingController(),
    focusNode: FocusNode(),
  );

  bool get selectTerms => _selectTerms;

  File? get profileImg => _profileImg;

  bool get hasMinLength => _hasMinLength;

  bool get hasUppercase => _hasUppercase;

  bool get hasSpecialChar => _hasSpecialChar;

  bool get isBtnEnabled => _isBtnEnabled;

  bool get shouldShowPasswordValidation =>
      passwordCont.focusNode.hasFocus ||
      passwordCont.controller.text.isNotEmpty;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void toggleSelectTerms(bool? value) {
    _selectTerms = value ?? false;
    notifyListeners();
  }

  void clearSignUpData() {
    nameCont.controller.clear();
    emailCont.controller.clear();
    passwordCont.controller.clear();
    confirmPassCont.controller.clear();
    dobCon.controller.clear();
    dob = null;
    _profileImg = null;
    notifyListeners();
  }

  Future<void> setDate(DateTime date) async {
    if (_isAtLeast18YearsOld(date)) {
      dob = date;
      dobCon.controller.text = DateFormat('dd / MM / yyyy').format(date);
      dobCon.error = null;
    } else {
      dobCon.error = "Selected age is less than 18";
      dobCon.controller.clear();

      dob = null;
    }

    _updateButtonState();
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

  void _updateButtonState() {
    final isValidEmail =
        emailCont.controller.text.isNotEmpty && emailCont.error == null;

    final isValidName =
        nameCont.controller.text.isNotEmpty && nameCont.error == null;

    final isValidPassword =
        passwordCont.controller.text.isNotEmpty &&
        _hasMinLength &&
        _hasUppercase &&
        _hasSpecialChar;

    final isValidConfirmPassword =
        confirmPassCont.controller.text.isNotEmpty &&
        confirmPassCont.error == null;

    _isBtnEnabled =
        isValidEmail &&
        isValidName &&
        isValidPassword &&
        isValidConfirmPassword &&
        dob != null &&
        _selectTerms;

    notifyListeners();
  }

  void validatePassword(String password) {
    _hasMinLength = password.length >= 8;
    _hasUppercase = password.contains(RegExp(r'[A-Z]'));
    _hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // Set password error based on validation
    passwordCont.error = (!_hasMinLength || !_hasUppercase || !_hasSpecialChar)
        ? "Password requirements not met"
        : null;

    // Re-validate confirm password
    if (confirmPassCont.controller.text.isNotEmpty) {
      confirmPassCont.error = TextFieldValidator.validateConfirmPassword(
        confirmPassCont.controller.text,
        password,
      );
    }

    _updateButtonState();
  }

  void onChange({
    required CustomTextController con,
    String? Function(String?)? validator,
    required String value,
  }) {
    if (validator != null) {
      con.error = validator(value);
    }
    _updateButtonState();
  }

  Future<void> registerUser() async {
    try {
      setLoading(true);
      final userModel = await _authRepository.registerUser(
        UserModel(
          name: nameCont.controller.text,
          email: emailCont.controller.text,
          imageUrl: '',
          createdAt: DateTime.now(),
          role: UserType.user,
          authId: '',
          dob: dob!,
        ),
        passwordCont.controller.text.trim(),
      );

      clearSignUpData();
    } catch (e) {
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }
}
