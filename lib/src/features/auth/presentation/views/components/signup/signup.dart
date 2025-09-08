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
                : mobileLayout(state, context);
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
                child: CustomInputField(
                  hint: "Enter your first name.",
                  title: 'First Name',
                  titleIcon: AppIcons.name,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  controller: state.nameController,
                  onChange: (value) {
                    context.read<SignUpBloc>().add(SignUpNameChanged(value));
                  },
                  suffixWidget: _getSuffixIcon(con: state.nameController),
                ),
              ),
              7.horizontalSpace,
              Expanded(
                child: CustomInputField(
                  hint: "Enter your last name.",
                  title: 'Last Name',
                  titleIcon: AppIcons.name,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  controller: state.nameController,
                  onChange: (value) {
                    context.read<SignUpBloc>().add(SignUpNameChanged(value));
                  },
                  suffixWidget: _getSuffixIcon(con: state.nameController),
                ),
              ),
            ],
          ),

          30.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomInputField(
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
                ),
              ),
              7.horizontalSpace,
              Expanded(
                child: _DOBPicker(
                  setDate: (DateTime date) {
                    context.read<SignUpBloc>().add(
                      SignUpDateOfBirthChanged(date),
                    );
                  },
                  controller: state.dobController,
                ),
              ),
            ],
          ),

          30.verticalSpace,
          _PasswordForm(),
          40.verticalSpace,
          CustomButton(
            isEnable: state.isFormValid,
            title: "SIGN UP",
            onPressed: () =>
                context.read<SignUpBloc>().add(const SignUpSubmitted()),
            bgColor: AppColors.primaryColor,
            textColor: AppColors.whiteColor,
          ),
          30.verticalSpace,
        ],
      ),
    );
  }

  Widget mobileLayout(SignUpState state, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          CustomInputField(
            hint: "Enter your first name.",
            title: 'First Name',
            titleIcon: AppIcons.name,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            controller: state.nameController,
            onChange: (value) {
              context.read<SignUpBloc>().add(SignUpNameChanged(value));
            },
            suffixWidget: _getSuffixIcon(con: state.nameController),
          ),
          30.verticalSpace,
          CustomInputField(
            hint: "Enter your last name.",
            title: 'Last Name',
            titleIcon: AppIcons.name,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            controller: state.nameController,
            onChange: (value) {
              context.read<SignUpBloc>().add(SignUpNameChanged(value));
            },
            suffixWidget: _getSuffixIcon(con: state.nameController),
          ),
          30.verticalSpace,
          CustomInputField(
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
          ),
          30.verticalSpace,
          _DOBPicker(
            setDate: (DateTime date) {
              context.read<SignUpBloc>().add(SignUpDateOfBirthChanged(date));
            },
            controller: state.dobController,
          ),

          30.verticalSpace,
          _PasswordForm(),
          40.verticalSpace,
          CustomButton(
            isEnable: state.isFormValid,
            title: "SIGN UP",
            onPressed: () =>
                context.read<SignUpBloc>().add(const SignUpSubmitted()),
            bgColor: AppColors.primaryColor,
            textColor: AppColors.whiteColor,
          ),
          30.verticalSpace,
        ],
      ),
    );
  }

  Widget? _getSuffixIcon({required CustomTextController con}) {
    return (con.controller.text.isNotEmpty)
        ? Icon(
            con.error != null ? Icons.close : Icons.check,
            color: con.error != null
                ? AppColors.redColor
                : AppColors.primaryColor,
          )
        : null;
  }
}
