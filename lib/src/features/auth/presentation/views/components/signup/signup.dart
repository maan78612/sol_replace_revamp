part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _SignUpComponent extends StatelessWidget {
  const _SignUpComponent();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, data) {
        return BlocBuilder<SignUpBloc, SignUpState>(
          builder: (ctx, state) {
            return data.isTabletRange || data.isDesktopRange
                ? _desktopTabLayout(state, context)
                : _mobileLayout(state, context);
          },
        );
      },
    );
  }

  Widget _desktopTabLayout(SignUpState state, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _firstNameField(state: state, context: context),
              ),
              7.horizontalSpace,
              Expanded(
                child: _lastNameField(state: state, context: context),
              ),
            ],
          ),
          30.verticalSpace,

          Row(
            children: [
              Expanded(
                child: _emailField(state: state, context: context),
              ),
              7.horizontalSpace,
              Expanded(
                child: _dobDatePicker(state: state, context: context),
              ),
            ],
          ),
          30.verticalSpace,
          _PasswordForm(),
          40.verticalSpace,
          _buildSignUpButton(state: state, context: context),
          30.verticalSpace,
        ],
      ),
    );
  }

  Widget _mobileLayout(SignUpState state, BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: hMargin),
      child: Column(
        children: [
          _firstNameField(state: state, context: context),
          30.verticalSpace,
          _lastNameField(state: state, context: context),
          30.verticalSpace,
          _emailField(state: state, context: context),
          30.verticalSpace,
          _dobDatePicker(state: state, context: context),
          30.verticalSpace,
          _PasswordForm(),
          40.verticalSpace,
          _buildSignUpButton(state: state, context: context),
          30.verticalSpace,
        ],
      ),
    );
  }

  Widget _firstNameField({
    required SignUpState state,
    required BuildContext context,
  }) {
    return CustomInputField(
      hint: "Enter your first name.",
      title: 'First Name',
      titleIcon: AppIcons.name,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      controller: state.firstNameController,
      onChange: (value) {
        context.read<SignUpBloc>().add(SignUpFirstNameChanged(value));
      },
      suffixWidget: _getSuffixIcon(con: state.firstNameController),
    );
  }

  Widget _lastNameField({
    required SignUpState state,
    required BuildContext context,
  }) {
    return CustomInputField(
      hint: "Enter your last name.",
      title: 'Last Name',
      titleIcon: AppIcons.name,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      controller: state.lastNameController,
      onChange: (value) {
        context.read<SignUpBloc>().add(SignUpLastNameChanged(value));
      },
      suffixWidget: _getSuffixIcon(con: state.lastNameController),
    );
  }

  Widget _emailField({
    required SignUpState state,
    required BuildContext context,
  }) {
    return CustomInputField(
      hint: 'Email',
      titleIcon: AppIcons.email,
      title: 'Enter your email.',
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      controller: state.emailController,
      onChange: (value) {
        context.read<SignUpBloc>().add(SignUpEmailChanged(value));
      },
      suffixWidget: _getSuffixIcon(con: state.emailController),
    );
  }

  Widget _dobDatePicker({
    required SignUpState state,
    required BuildContext context,
  }) {
    return _DOBPicker(
      setDate: (DateTime date) {
        context.read<SignUpBloc>().add(SignUpDateOfBirthChanged(date));
      },
      controller: state.dobController,
    );
  }

  Widget _buildSignUpButton({
    required SignUpState state,
    required BuildContext context,
  }) {
    return CustomButton(
      isEnable: state.isFormValid,
      title: "SIGN UP",
      onPressed: () => context.read<SignUpBloc>().add(const SignUpSubmitted()),
      bgColor: AppColors.primaryColor,
      textColor: AppColors.whiteColor,
    );
  }

  Widget? _getSuffixIcon({required CustomTextController con}) {
    return ValueListenableBuilder<String?>(
      valueListenable: con.errorNotifier,
      builder: (context, error, _) {
        return (con.controller.text.isNotEmpty)
            ? Icon(
                error != null ? Icons.close : Icons.check,
                color: error != null
                    ? AppColors.redColor
                    : AppColors.primaryColor,
              )
            : const SizedBox.shrink();
      },
    );
  }
}
