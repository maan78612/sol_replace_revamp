abstract class OtpRepository {
  Future<void> sendOtpOnEmail({required String email});

  Future<void> verifyOTP({required String email, required String token});
}
