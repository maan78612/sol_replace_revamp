part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _LoginComponent extends StatelessWidget {
  const _LoginComponent();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, data) {
        return BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomInputField(
                  hint: 'Email',
                  title: 'Enter your email.',
                  titleIcon: AppIcons.email,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: state.emailController,
                  onChange: (value) {
                    context.read<LoginBloc>().add(LoginEmailChanged(value));
                  },
                  suffixWidget: _getSuffixIcon(
                    con: state.emailController,
                    data: data,
                  ),
                ),
                30.verticalSpace,
                CustomInputField(
                  title: 'Password',
                  hint: 'Enter your password.',
                  titleIcon: AppIcons.lock,
                  obscure: true,
                  textInputAction: TextInputAction.done,
                  controller: state.passwordController,
                  onChange: (value) {
                    context.read<LoginBloc>().add(LoginPasswordChanged(value));
                  },
                ),

                GestureDetector(
                  onTap: () => _navigateToForgetPassword(context),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.all(
                        ResponsiveHelper.responsiveWidth(
                          data: data,
                          mobile: 8.0,
                          tablet: 10.0,
                          desktop: 12.0,
                        ),
                      ),
                      child: Text(
                        "Forgot Password?",
                        style: FontStyles.montserratRegular.copyWith(
                          fontSize: ResponsiveHelper.adaptiveFontSize(
                            data: data,
                            baseSize: 12.0,
                            scaleFactor: 0.95,
                          ),
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),

                _guestText(data),
                40.verticalSpace,
                CustomButton(
                  title: 'LOGIN',
                  isEnable: state.isFormValid,
                  onPressed: () =>
                      context.read<LoginBloc>().add(const LoginSubmitted()),
                  bgColor: AppColors.primaryColor,
                  textColor: AppColors.whiteColor,
                ),
                30.verticalSpace,
              ],
            );
          },
        );
      },
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
          )
        : null;
  }

  void _navigateToForgetPassword(BuildContext context) {
    CustomNavigation().push(const SendEmailView());
  }

  Widget _guestText(ResponsiveData data) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "To continue as a Guest. ",
        style: FontStyles.montserratRegular.copyWith(
          fontSize: ResponsiveHelper.adaptiveFontSize(
            data: data,
            baseSize: 14.0,
            scaleFactor: 0.95,
          ),
          color: AppColors.blackColor,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Click Here',
            style: FontStyles.montserratRegular.copyWith(
              fontSize: ResponsiveHelper.adaptiveFontSize(
                data: data,
                baseSize: 14.0,
                scaleFactor: 0.95,
              ),
              color: AppColors.primaryColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = () async {},
          ),
        ],
      ),
    );
  }
}
