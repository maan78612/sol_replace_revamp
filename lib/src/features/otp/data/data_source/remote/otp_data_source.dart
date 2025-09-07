part of 'package:sol_replace_revamp/src/features/otp/otp_library.dart';

/// Abstract OTP data source that can be implemented by different modules
abstract class OtpDataSource {
  Future<void> sendOtpOnEmail({required String email});
  Future<void> verifyOTP({required String email, required String token});
}

/// Default OTP data source implementation
/// This is used when no specific module data source is provided
class DefaultOtpDataSource implements OtpDataSource {
  @override
  Future<void> sendOtpOnEmail({required String email}) async {
    // Default OTP sending logic - can be implemented with your preferred service
    await Future.delayed(const Duration(seconds: 1));
    debugPrint("Default OTP sent to: $email");
  }
  
  @override
  Future<void> verifyOTP({required String email, required String token}) async {
    // Default OTP verification logic - can be implemented with your preferred service
    await Future.delayed(const Duration(seconds: 1));
    debugPrint("Default OTP verified for: $email with token: $token");
  }
}
