part of 'package:sol_replace_revamp/src/features/splash/splash_library.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class CheckAutoLogin extends SplashEvent {
  const CheckAutoLogin();
}

class NavigateToAuth extends SplashEvent {
  const NavigateToAuth();
}

class NavigateToMainApp extends SplashEvent {
  const NavigateToMainApp();
}
