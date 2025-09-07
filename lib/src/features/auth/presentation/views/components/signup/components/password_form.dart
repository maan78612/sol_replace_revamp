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

                if (state.shouldShowPasswordValidation)
                  _passwordValidator(state),
              ],
            );
          },
        );
      },
    );
  }

  Widget _passwordValidator(SignUpState state) {
    return Column(
      children: [
        24.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            // Determine which validation group this index belongs to
            bool isActive;
            if (index < 2) {
              // First two containers for min length
              isActive = state.hasMinLength;
            } else if (index < 4) {
              // Next two containers for uppercase
              isActive = state.hasUppercase;
            } else {
              // Last two containers for special character
              isActive = state.hasSpecialChar;
            }

            return Container(
              height: 3.5.h,
              width: 50.w,
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryColor : Colors.grey,
                borderRadius: BorderRadius.circular(2.r),
              ),
            );
          }),
        ),
        15.verticalSpace,

        _buildValidationRow('At least 8 characters', state.hasMinLength),
        4.verticalSpace,
        _buildValidationRow('At least one uppercase letter', state.hasUppercase),
        4.verticalSpace,
        _buildValidationRow(
          'At least one special character',
          state.hasSpecialChar,
        ),
      ],
    );
  }

  Widget _buildValidationRow(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.close,
          size: 18.sp,
          color: isValid ? AppColors.primaryColor : AppColors.redColor,
        ),
        8.horizontalSpace,
        Text(
          text,
          style: FontStyles.montserratRegular.copyWith(
            fontSize: 14.sp,
            color: AppColors.whiteColor,
          ),
        ),
      ],
    );
  }
}
