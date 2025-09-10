part of 'package:sol_replace_revamp/src/features/otp/otp_library.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

class OtpCodeChanged extends OtpEvent {
  final String code;

  const OtpCodeChanged(this.code);

  @override
  List<Object?> get props => [code];
}

class SendOtp extends OtpEvent {
  const SendOtp();
}

class VerifyOtp extends OtpEvent {
  const VerifyOtp();
}

class StartTimer extends OtpEvent {
  const StartTimer();
}

class TimerTick extends OtpEvent {
  final int? seconds;
  final bool isFinished;
  
  const TimerTick({this.seconds, this.isFinished = false});
  
  @override
  List<Object?> get props => [seconds, isFinished];
}
