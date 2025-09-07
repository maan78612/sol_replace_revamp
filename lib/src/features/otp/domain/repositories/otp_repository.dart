part of 'package:sol_replace_revamp/src/features/otp/otp_library.dart';

abstract class OtpRepository {
  Future<void> sendOtpOnEmail({required String email});

  Future<void> verifyOTP({required String email, required String token});
}
