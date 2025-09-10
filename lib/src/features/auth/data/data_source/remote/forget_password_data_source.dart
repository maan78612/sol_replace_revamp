part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

/// ForgetPassword-specific OTP data source
/// Handles OTP operations for password reset functionality
class ForgetPasswordDataSource implements OtpDataSource {
  final GoTrueClient _auth = SBTables.auth;

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  //  Override Methods of OTP DataSource for Password Reset
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  @override
  Future<void> sendOtpOnEmail({required String email}) async {
    try {
      await _auth.resetPasswordForEmail(email);
    } on AuthApiException catch (e) {
      throw 'Failed to send password reset email: ${e.message}';
    } catch (e) {
      debugPrint("Unknown error sendOtpOnEmail for password reset = $e");
      throw e.toString();
    }
  }

  @override
  Future<void> verifyOTP({required String email, required String token}) async {
    try {
      final response = await SBTables.auth.verifyOTP(
        email: email,
        token: token,
        type: OtpType.recovery,
      );

      if (response.user == null) {
        throw 'Password reset verification failed: No user returned';
      }
    } on AuthApiException catch (e) {
      throw 'Password reset verification failed: ${e.message}';
    } catch (e) {
      throw 'An unexpected error occurred during password reset verification.';
    }
  }
}
