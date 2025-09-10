part of 'package:sol_replace_revamp/src/features/splash/splash_library.dart';

class SplashState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final bool hasNavigated;

  const SplashState({
    this.isLoading = false,
    this.errorMessage,
    this.hasNavigated = false,
  });

  SplashState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? hasNavigated,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      hasNavigated: hasNavigated ?? this.hasNavigated,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, hasNavigated];
}
