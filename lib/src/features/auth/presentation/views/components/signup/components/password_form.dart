part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _PasswordForm extends ConsumerWidget {
  final ChangeNotifierProvider<_SignUpVM> signUpVMProvider;

  const _PasswordForm(this.signUpVMProvider);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpVM = ref.watch(signUpVMProvider);
    return ResponsiveWidget(
      builder: (context, data) {
        return Column(
          children: [
            CustomInputField(
              title: 'Password',
              titleIcon: AppIcons.lock,
              hint: 'Enter your password.',
              obscure: true,
              textInputAction: TextInputAction.next,
              controller: signUpVM.passwordCont,
              onChange: (value) => signUpVM.validatePassword(value),
            ),
            SizedBox(
              height: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 24.0,
                tablet: 28.0,
                desktop: 32.0,
              ),
            ),
            CustomInputField(
              title: 'Confirm Password',
              titleIcon: AppIcons.lock,
              hint: 'Enter your password.',
              obscure: true,
              textInputAction: TextInputAction.done,
              controller: signUpVM.confirmPassCont,
              onChange: (value) => signUpVM.onChange(
                con: signUpVM.confirmPassCont,
                value: value,
                validator: (val) => TextFieldValidator.validateConfirmPassword(
                  val,
                  signUpVM.passwordCont.controller.text,
                ),
              ),
            ),

            if (signUpVM.shouldShowPasswordValidation) _passwordValidator(signUpVM),
          ],
        );
      },
    );
  }

  Widget _passwordValidator(_SignUpVM vm) {
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
              isActive = vm.hasMinLength;
            } else if (index < 4) {
              // Next two containers for uppercase
              isActive = vm.hasUppercase;
            } else {
              // Last two containers for special character
              isActive = vm.hasSpecialChar;
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

        _buildValidationRow('At least 8 characters', vm.hasMinLength),
        4.verticalSpace,
        _buildValidationRow('At least one uppercase letter', vm.hasUppercase),
        4.verticalSpace,
        _buildValidationRow(
          'At least one special character',
          vm.hasSpecialChar,
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
