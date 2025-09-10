part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _PasswordForm extends StatelessWidget {
  const _PasswordForm();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, data) {
        return BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return Column(
              children: [
                data.isTabletRange || data.isDesktopRange
                    ? _desktopTabLayout(state, context, data)
                    : _mobileLayout(state, context, data),

                if (state.shouldShowPasswordValidation)
                  _passwordValidator(state, data),
              ],
            );
          },
        );
      },
    );
  }

  Widget _mobileLayout(
    SignUpState state,
    BuildContext context,
    ResponsiveData data,
  ) {
    return Column(
      children: [
        CustomInputField(
          title: 'Password',
          titleIcon: AppIcons.lock,
          hint: 'Enter your password.',
          obscure: true,
          textInputAction: TextInputAction.next,
          controller: state.passwordController,
          onChange: (value) {
            context.read<SignUpBloc>().add(SignUpPasswordChanged(value));
          },
        ),
        30.verticalSpace,
        CustomInputField(
          title: 'Confirm Password',
          titleIcon: AppIcons.lock,
          hint: 'Enter your password.',
          obscure: true,
          textInputAction: TextInputAction.done,
          controller: state.confirmPasswordController,
          onChange: (value) {
            context.read<SignUpBloc>().add(SignUpConfirmPasswordChanged(value));
          },
        ),
      ],
    );
  }

  Widget _desktopTabLayout(
    SignUpState state,
    BuildContext context,
    ResponsiveData data,
  ) {
    return Row(
      children: [
        Expanded(
          child: CustomInputField(
            title: 'Password',
            titleIcon: AppIcons.lock,
            hint: 'Enter your password.',
            obscure: true,
            textInputAction: TextInputAction.next,
            controller: state.passwordController,
            onChange: (value) {
              context.read<SignUpBloc>().add(SignUpPasswordChanged(value));
            },
          ),
        ),
        7.horizontalSpace,
        Expanded(
          child: CustomInputField(
            title: 'Confirm Password',
            titleIcon: AppIcons.lock,
            hint: 'Enter your password.',
            obscure: true,
            textInputAction: TextInputAction.done,
            controller: state.confirmPasswordController,
            onChange: (value) {
              context.read<SignUpBloc>().add(
                SignUpConfirmPasswordChanged(value),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _passwordValidator(SignUpState state, ResponsiveData data) {
    return Align(
      alignment: Alignment.centerLeft,
      child: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          width: _getMaxFieldWidth(data, constraints.maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              24.verticalSpace,
              _indicators(data, state),
              15.verticalSpace,
              _buildValidationRow(
                'At least 8 characters',
                state.hasMinLength,
                data,
              ),
              4.verticalSpace,
              _buildValidationRow(
                'At least one uppercase letter',
                state.hasUppercase,
                data,
              ),
              4.verticalSpace,
              _buildValidationRow(
                'At least one special character',
                state.hasSpecialChar,
                data,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _indicators(ResponsiveData data, SignUpState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,

      children: List.generate(6, (index) {
        bool isActive;
        if (index < 2) {
          isActive = state.hasMinLength;
        } else if (index < 4) {
          isActive = state.hasUppercase;
        } else {
          isActive = state.hasSpecialChar;
        }

        return Expanded(
          child: Container(
            height: 3.5.h,

            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryColor : Colors.grey,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildValidationRow(String text, bool isValid, ResponsiveData data) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.close,
          size: ResponsiveHelper.adaptiveIconSize(data: data, baseSize: 18),
          color: isValid ? AppColors.primaryColor : AppColors.redColor,
        ),
        8.horizontalSpace,
        Text(
          text,
          style: FontStyles.montserratRegular.copyWith(
            fontSize: ResponsiveHelper.adaptiveFontSize(
              data: data,
              baseSize: 14.0,
              scaleFactor: 0.8,
            ),
            color: AppColors.blackColor,
          ),
        ),
      ],
    );
  }

  double _getMaxFieldWidth(ResponsiveData data, double availableWidth) {
    return ResponsiveHelper.value<double>(
      data: data,
      mobile: data.width * 0.5,
      mobileLarge: data.width * 0.5,
      tablet: data.width * 0.4,
      tabletLarge: data.width * 0.4,
      desktop: data.width * 0.2,
      desktopLarge: data.width * 0.2,
      ultraWide: data.width * 0.2,
      fallback: availableWidth,
    );
  }
}
