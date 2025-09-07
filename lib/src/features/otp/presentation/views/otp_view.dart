part of 'package:sol_replace_revamp/src/features/otp/otp_library.dart';

class OtpView extends StatefulWidget {
  final String email;
  final VoidCallback onValidate;
  final String description;
  final String backToText;
  final VoidCallback backToTab;
  final bool sendInitialOtpCall;
  final String buttonText;
  final OtpRepository? repo; // Optional custom repository

  const OtpView({
    super.key,
    required this.email,
    required this.onValidate,
    required this.description,
    required this.backToText,
    required this.backToTab,
    required this.sendInitialOtpCall,
    required this.buttonText,
    this.repo, // Optional - will use default if not provided
  });

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(
        repo: widget.repo ?? ServiceLocator.instance.otpRepository,
        email: widget.email,
        onValidate: widget.onValidate,
        sendInitialOtpCall: widget.sendInitialOtpCall,
      ),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<OtpBloc, OtpState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.verticalSpace,
                _buildTitle(widget.description),
                57.verticalSpace,
                _buildPinField(state, context),
                16.verticalSpace, // small gap
                _buildResendRow(state),
                100.verticalSpace,
                CustomButton(
                  isEnable: state.isBtnEnabled,
                  bgColor: AppColors.primaryColor,
                  isLoading: state.isLoading,
                  onPressed: () => context.read<OtpBloc>().add(const VerifyOtp()),
                  title: widget.buttonText,
                ),
                27.verticalSpace,
                _buildBackToText(widget.backToText, widget.backToTab),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Verify Your',
                style: FontStyles.montserratBold.copyWith(
                  fontSize: 20.sp,
                  color: AppColors.whiteColor,
                ),
              ),
              TextSpan(
                text: ' ${widget.email} ',
                style: FontStyles.montserratBold.copyWith(
                  fontSize: 20.sp,
                  color: AppColors.primaryColor,
                ),
              ),

              TextSpan(
                text: 'Email',
                style: FontStyles.montserratBold.copyWith(
                  fontSize: 20.sp,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
        10.verticalSpace,
        Text(
          description,
          style: FontStyles.montserratRegular.copyWith(fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildPinField(OtpState state, BuildContext context) {
    return PinCodeTextField(
      // mainAxisAlignment: MainAxisAlignment.start,
      appContext: context,
      length: 6,
      controller: _otpController,
      textStyle: FontStyles.montserratRegular.copyWith(fontSize: 20.sp),
      cursorColor: AppColors.primaryColor,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      animationDuration: const Duration(milliseconds: 300),
      onChanged: (code) => context.read<OtpBloc>().add(OtpCodeChanged(code)),
      // separatorBuilder: (ctx, idx) => SizedBox(width: 24.sp),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10.r),
        fieldHeight: 50.sp,
        fieldWidth: 50.sp,
        activeColor: AppColors.primaryColor,
        selectedColor: AppColors.primaryColor,
        inactiveColor: AppColors.lightGreyColor,
        disabledColor: AppColors.lightGreyColor,
        inactiveFillColor: AppColors.lightGreyColor,
        errorBorderColor: AppColors.redColor,
        activeBorderWidth: 1,
        selectedBorderWidth: 1,
        inactiveBorderWidth: 1,
        disabledBorderWidth: 1,
        errorBorderWidth: 1,
      ),
    );
  }

  Widget _buildResendRow(OtpState state) {
    return RichText(
      text: TextSpan(
        style: FontStyles.montserratRegular.copyWith(fontSize: 14.sp),
        children: [
          TextSpan(text: "Didn't get a code?"),
          if (state.isResend && !state.isResendLoading)
            TextSpan(
              text: 'Resend',
              style: FontStyles.montserratRegular.copyWith(
                color: AppColors.primaryColor,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => context.read<OtpBloc>().add(const SendOtp()),
            ),
          if (!state.isResend) TextSpan(text: ' ${state.secs}s'),
          if (state.isResendLoading)
            WidgetSpan(
              child: Container(
                margin: EdgeInsets.only(left: 4),
                width: 14.sp,
                height: 14.sp,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBackToText(String backToText, Function() backToTab) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "Back To ",
              style: FontStyles.montserratRegular.copyWith(
                fontSize: 14.sp,
                color: AppColors.whiteColor,
              ),
            ),
            TextSpan(
              text: backToText,
              style: FontStyles.montserratRegular.copyWith(
                fontSize: 14.sp,
                color: AppColors.primaryColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = () => backToTab(),
            ),
          ],
        ),
      ),
    );
  }
}
