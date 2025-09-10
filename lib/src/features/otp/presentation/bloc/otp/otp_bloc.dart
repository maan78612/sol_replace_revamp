part of 'package:sol_replace_revamp/src/features/otp/otp_library.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpRepository _repo;
  final String email;
  final VoidCallback onValidate; // Use VoidCallback instead of Function()
  final int pinLengths = 6;

  Timer? _timer;
  StreamSubscription<int>? _timerSubscription;

  OtpBloc({
    required OtpRepository repo,
    required this.email,
    required this.onValidate,
    required bool sendInitialOtpCall,
  })  : _repo = repo,
        super(const OtpState()) {
    on<OtpCodeChanged>(_onOtpCodeChanged);
    on<SendOtp>(_onSendOtp);
    on<VerifyOtp>(_onVerifyOtp);
    on<StartTimer>(_onStartTimer);
    on<TimerTick>(_onTimerTick);

    if (sendInitialOtpCall) {
      add(const SendOtp());
    } else {
      add(const StartTimer());
    }
  }

  void _onOtpCodeChanged(OtpCodeChanged event, Emitter<OtpState> emit) {
    final canEnable = event.code.length == pinLengths;
    emit(state.copyWith(
      otpCode: event.code,
      isBtnEnabled: canEnable,
      errorMessage: null,
    ));
  }

  Future<void> _onSendOtp(SendOtp event, Emitter<OtpState> emit) async {
    if (state.isResendLoading) return;

    emit(state.copyWith(isResendLoading: true, errorMessage: null));
    try {
      await _repo.sendOtpOnEmail(email: email);
      emit(state.copyWith(
        otpCode: '',
        isResendLoading: false,
      ));
      add(const StartTimer());
    } catch (e) {
      emit(state.copyWith(
        isResendLoading: false,
        secs: 0,
        isResend: true,
        errorMessage: e.toString(),
      ));
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    }
  }

  Future<void> _onVerifyOtp(VerifyOtp event, Emitter<OtpState> emit) async {
    if (!state.isBtnEnabled || state.isLoading) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await _repo.verifyOTP(email: email, token: state.otpCode.trim());
      onValidate();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      debugPrint("verifyOtp error: ${e.toString()}");
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
      SnackBarUtils.show(e.toString(), SnackBarType.error);
    }
  }

  void _onStartTimer(StartTimer event, Emitter<OtpState> emit) {
    _cancelTimer();
    emit(state.copyWith(
      isResend: false,
      secs: 60,
      isBtnEnabled: state.otpCode.length == pinLengths,
    ));

    // Use a more efficient timer approach
    _startCountdown();
  }

  void _startCountdown() {
    const duration = Duration(seconds: 1);
    int currentSeconds = 60;
    
    _timer = Timer.periodic(duration, (timer) {
      currentSeconds--;
      if (currentSeconds <= 0) {
        timer.cancel();
        add(const TimerTick(isFinished: true));
      } else {
        // Only emit state every 5 seconds to reduce UI rebuilds
        if (currentSeconds % 5 == 0 || currentSeconds <= 5) {
          add(TimerTick(seconds: currentSeconds));
        }
      }
    });
  }

  void _onTimerTick(TimerTick event, Emitter<OtpState> emit) {
    if (event.isFinished) {
      emit(state.copyWith(
        secs: 0,
        isResend: true,
        isBtnEnabled: state.otpCode.length == pinLengths,
      ));
    } else if (event.seconds != null) {
      emit(state.copyWith(secs: event.seconds!));
    }
  }
  
  void _cancelTimer() {
    _timer?.cancel();
    _timerSubscription?.cancel();
  }

  @override
  Future<void> close() {
    _cancelTimer();
    return super.close();
  }
}
