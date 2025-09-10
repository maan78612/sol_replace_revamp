import 'package:sol_replace_revamp/src/features/auth/auth_library.dart';
import 'package:sol_replace_revamp/src/features/otp/otp_library.dart';
import 'package:sol_replace_revamp/src/features/splash/splash_library.dart';

/// Service locator for dependency injection
/// Implements singleton pattern for better memory management
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  static ServiceLocator get instance => _instance;
  
  ServiceLocator._internal();
  
  // Repository instances (singletons)
  AuthRepository? _authRepository;
  OtpRepository? _otpRepository;
  SplashRepository? _splashRepository;
  
  /// Get singleton instance of AuthRepository
  AuthRepository get authRepository {
    return _authRepository ??= AuthRepositoryImpl();
  }
  
  /// Get singleton instance of OtpRepository with default data source
  OtpRepository get otpRepository {
    return _otpRepository ??= OtpRepositoryImpl(dataSource: DefaultOtpDataSource());
  }
  
  /// Create OtpRepository with custom data source
  /// This allows different modules to use OTP with their own data source implementations
  OtpRepository createOtpRepository(OtpDataSource dataSource) {
    return OtpRepositoryImpl(dataSource: dataSource);
  }
  
  /// Get singleton instance of SplashRepository
  SplashRepository get splashRepository {
    return _splashRepository ??= SplashRepositoryImpl();
  }
  
  /// Reset all instances (useful for testing or memory cleanup)
  void reset() {
    _authRepository = null;
    _otpRepository = null;
    _splashRepository = null;
  }
}
