import 'package:flutter/cupertino.dart';
import 'package:sol_replace_revamp/src/features/otp/data/data_source/remote/otp_data_source.dart';
import 'package:sol_replace_revamp/src/features/otp/domain/repositories/otp_repository.dart';

class OtpRepositoryImpl implements OtpRepository {
  final OtpDataSource _dataSource;

  OtpRepositoryImpl({required OtpDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<void> sendOtpOnEmail({required String email}) async {
    try {
      debugPrint("Sending OTP to: $email");
      await _dataSource.sendOtpOnEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> verifyOTP({required String email, required String token}) async {
    try {
      await _dataSource.verifyOTP(email: email, token: token);
    } catch (e) {
      rethrow;
    }
  }
}
