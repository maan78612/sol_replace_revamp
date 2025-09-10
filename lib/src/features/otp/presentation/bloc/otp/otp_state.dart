part of 'package:sol_replace_revamp/src/features/otp/otp_library.dart';

class OtpState extends Equatable {
  final String otpCode;
  final bool isLoading;
  final bool isResendLoading;
  final bool isBtnEnabled;
  final bool isResend;
  final int secs;
  final String? errorMessage;

  const OtpState({
    this.otpCode = '',
    this.isLoading = false,
    this.isResendLoading = false,
    this.isBtnEnabled = false,
    this.isResend = false,
    this.secs = 60,
    this.errorMessage,
  });

  OtpState copyWith({
    String? otpCode,
    bool? isLoading,
    bool? isResendLoading,
    bool? isBtnEnabled,
    bool? isResend,
    int? secs,
    String? errorMessage,
  }) {
    return OtpState(
      otpCode: otpCode ?? this.otpCode,
      isLoading: isLoading ?? this.isLoading,
      isResendLoading: isResendLoading ?? this.isResendLoading,
      isBtnEnabled: isBtnEnabled ?? this.isBtnEnabled,
      isResend: isResend ?? this.isResend,
      secs: secs ?? this.secs,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        otpCode,
        isLoading,
        isResendLoading,
        isBtnEnabled,
        isResend,
        secs,
        errorMessage,
      ];
}
