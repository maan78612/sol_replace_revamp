part of 'package:sol_replace_revamp/src/features/forget_password/forget_password_library.dart';

class SendEmailView extends StatelessWidget {
  const SendEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendEmailBloc(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: ResponsiveWidget(
          builder: (context, data) => _body(context, data),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, ResponsiveData data) {
    return Row(
      children: [
        if (data.isDesktopRange) ...[
          Expanded(
            flex: ResponsiveHelper.value<int>(
              data: data,
              tablet: 1,
              desktop: 2,
              desktopLarge: 3,
              fallback: 1,
            ),
            child: _sideLogo(context, data),
          ),
        ],

        // Right side form
        Expanded(
          flex: ResponsiveHelper.value<int>(
            data: data,
            tablet: 2,
            desktop: 3,
            desktopLarge: 2,
            fallback: 1,
          ),
          child: _buildSendEmailCard(context, data),
        ),
      ],
    );
  }

  Widget _sideLogo(BuildContext context, ResponsiveData data) {
    return Container(
      height: data.height * 0.7,
      padding: ResponsiveHelper.responsivePadding(data),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.responsiveWidth(
              data: data,
              mobile: 300.0,
              tablet: 350.0,
              desktop: 400.0,
              ultraWide: 500.0,
            ),
            maxHeight: ResponsiveHelper.responsiveHeight(
              data: data,
              mobile: data.height * 0.8,
              tablet: data.height * 0.75,
              desktop: data.height * 0.7,
              ultraWide: data.height * 0.6,
            ),
          ),
          child: SvgPicture.asset(
            AppIcons.logo,
            placeholderBuilder: (context) => const CircularProgressIndicator(),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildSendEmailCard(BuildContext context, ResponsiveData data) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: BlocBuilder<SendEmailBloc, SendEmailState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              40.verticalSpace,
              Text(
                'Reset Password',
                style: FontStyles.montserratBold.copyWith(
                  fontSize: ResponsiveHelper.adaptiveFontSize(
                    data: data,
                    baseSize: 18.0,
                    scaleFactor: 1.2,
                  ),
                  color: AppColors.blackColor,
                ),
              ),
              10.verticalSpace,
              Text(
                'Enter your email address and we\'ll send you an OTP to reset your password',
                textAlign: TextAlign.center,
                style: FontStyles.montserratRegular.copyWith(
                  fontSize: ResponsiveHelper.adaptiveFontSize(
                    data: data,
                    baseSize: 12.0,
                    scaleFactor: 0.9,
                  ),
                  color: AppColors.greyColor,
                ),
              ),
              40.verticalSpace,
              CustomInputField(
                hint: 'Enter your email',
                title: 'Email Address',
                titleIcon: AppIcons.email,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                controller: state.emailController,
                onChange: (value) {
                  context.read<SendEmailBloc>().add(SendEmailChanged(value));
                },
                suffixWidget: _getSuffixIcon(
                  con: state.emailController,
                  data: data,
                ),
              ),
              40.verticalSpace,
              // Send OTP Button
              CustomButton(
                title: state.isLoading ? 'Sending...' : 'Send OTP',
                isEnable: state.isFormValid && !state.isLoading,
                onPressed: () => context.read<SendEmailBloc>().add(
                  const SendEmailSubmitted(),
                ),
                bgColor: AppColors.primaryColor,
                textColor: AppColors.whiteColor,
                isLoading: state.isLoading,
              ),
              20.verticalSpace,
              // Back to Login
              Center(
                child: CommonInkWell(
                  onTap: () => CustomNavigation().pop(),
                  child: Text(
                    'Back to Login',
                    style: FontStyles.montserratMedium.copyWith(
                      fontSize: ResponsiveHelper.adaptiveFontSize(
                        data: data,
                        baseSize: 14.0,
                        scaleFactor: 0.95,
                      ),
                      color: AppColors.primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget? _getSuffixIcon({
    required CustomTextController con,
    required ResponsiveData data,
  }) {
    return (con.controller.text.isNotEmpty)
        ? Icon(
            con.error != null ? Icons.close : Icons.check,
            color: con.error != null
                ? AppColors.redColor
                : AppColors.primaryColor,
            size: ResponsiveHelper.responsiveHeight(
              data: data,
              mobile: 20.0,
              tablet: 22.0,
              desktop: 24.0,
            ),
          )
        : null;
  }
}
