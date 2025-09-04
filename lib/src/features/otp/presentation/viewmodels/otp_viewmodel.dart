import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sol_replace_revamp/src/core/enums/snackbar_status.dart';
import 'package:sol_replace_revamp/src/core/utilities/custom_snack_bar.dart';
import 'package:sol_replace_revamp/src/features/otp/domain/repositories/otp_repository.dart';

class OtpVM with ChangeNotifier {
  final OtpRepository _repo;
  final String email;
  final Function() onValidate;

  OtpVM({
    required OtpRepository repo,
    required this.email,
    required this.onValidate,
    required bool sendInitialOtpCall,
  }) : _repo = repo {
    otpCodeCont.addListener(_onCodeChanged);

    if (sendInitialOtpCall) {
      _sendInitialOtp();
    } else {
      _startTimer();
    }
  }

  // Change return type to Future<void>
  Future<void> _sendInitialOtp() async {
    await sendOtp();
  }

  final TextEditingController otpCodeCont = TextEditingController();
  final int pinLengths = 6;

  Timer? _timer;

  bool _isLoading = false;
  bool _isResendLoading = false;
  bool _isBtnEnabled = false;
  bool _isResend = false;
  int _secs = 60;

  bool get isLoading => _isLoading;

  bool get isResendLoading => _isResendLoading;

  bool get isBtnEnabled => _isBtnEnabled;

  bool get isResend => _isResend;

  int get secs => _secs;

  void onCodeChanged() => _onCodeChanged();

  void _onCodeChanged() {
    final canEnable = otpCodeCont.text.length == pinLengths;
    if (canEnable != _isBtnEnabled) {
      _isBtnEnabled = canEnable;
      notifyListeners();
    }
  }

  void _setLoading(bool v) {
    if (_isLoading != v) {
      _isLoading = v;
      notifyListeners();
    }
  }

  void _setResendLoading(bool v) {
    _isResendLoading = v;
    notifyListeners();
  }

  Future<void> sendOtp() async {
    if (_isResendLoading) return;

    _setResendLoading(true);
    try {
      await _repo.sendOtpOnEmail(email: email);
      otpCodeCont.clear();
      _startTimer();
    } catch (e) {
      _secs = 0;
      _isResend = true;
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    } finally {
      _setResendLoading(false);
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _isResend = false;
    _secs = 60;
    _onCodeChanged();
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      _secs--;
      if (_secs <= 0) {
        _secs = 0;
        _isResend = true;
        _onCodeChanged();
        notifyListeners();
        t.cancel();
      } else {
        notifyListeners();
      }
    });
  }

  Future<void> verifyOtp() async {
    if (!_isBtnEnabled || _isLoading) return;

    _setLoading(true);
    try {
      await _repo.verifyOTP(email: email, token: otpCodeCont.text.trim());

      await onValidate();
    } catch (e) {
      debugPrint("verifyOtp error: ${e.toString()}");
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    } finally {
      _setLoading(false);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpCodeCont.dispose();
    super.dispose();
  }
}
