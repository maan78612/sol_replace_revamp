// otp_view.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sol_replace_revamp/src/core/components/custom_button.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';
import 'package:sol_replace_revamp/src/features/otp/domain/repositories/otp_repository.dart';
import 'package:sol_replace_revamp/src/features/otp/presentation/viewmodels/otp_viewmodel.dart';

class OtpView extends ConsumerStatefulWidget {
  final OtpRepository repo;
  final String email;
  final Function() onValidate;
  final String description;
  final String backToText;
  final Function() backToTab;
  final bool sendInitialOtpCall;
  final String buttonText;

  const OtpView({
    super.key,
    required this.repo,
    required this.email,
    required this.onValidate,
    required this.description,
    required this.backToText,
    required this.backToTab,
    required this.sendInitialOtpCall,
    required this.buttonText,
  });

  @override
  ConsumerState<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends ConsumerState<OtpView> {
  late ChangeNotifierProvider<OtpVM> _otpProvider;

  @override
  void initState() {
    _otpProvider = ChangeNotifierProvider<OtpVM>((ref) {
      return OtpVM(
        repo: widget.repo,
        email: widget.email,
        onValidate: widget.onValidate,
        sendInitialOtpCall: widget.sendInitialOtpCall,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(_otpProvider);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      resizeToAvoidBottomInset: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.verticalSpace,
          _buildTitle(widget.description),
          57.verticalSpace,
          _buildPinField(vm, context),
          16.verticalSpace, // small gap
          _buildResendRow(vm),
          100.verticalSpace,
          CustomButton(
            isEnable: vm.isBtnEnabled,
            bgColor: AppColors.primaryColor,
            isLoading: vm.isLoading,
            onPressed: () => vm.verifyOtp(),
            title: widget.buttonText,
          ),
          27.verticalSpace,
          _buildBackToText(widget.backToText, widget.backToTab),
        ],
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

  Widget _buildPinField(OtpVM vm, BuildContext context) {
    return PinCodeTextField(
      // mainAxisAlignment: MainAxisAlignment.start,
      appContext: context,
      length: vm.pinLengths,
      controller: vm.otpCodeCont,
      textStyle: FontStyles.montserratRegular.copyWith(fontSize: 20.sp),
      cursorColor: AppColors.primaryColor,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      animationDuration: const Duration(milliseconds: 300),
      onChanged: (_) => vm.onCodeChanged(),
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

  Widget _buildResendRow(OtpVM vm) {
    return RichText(
      text: TextSpan(
        style: FontStyles.montserratRegular.copyWith(fontSize: 14.sp),
        children: [
          TextSpan(text: "Didn't get a code?"),
          if (vm.isResend && !vm.isResendLoading)
            TextSpan(
              text: 'Resend',
              style: FontStyles.montserratRegular.copyWith(
                color: AppColors.primaryColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = () => vm.sendOtp(),
            ),
          if (!vm.isResend) TextSpan(text: ' ${vm.secs}s'),
          if (vm.isResendLoading)
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
