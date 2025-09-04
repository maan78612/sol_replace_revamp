part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _SignUpComponent extends ConsumerWidget {
  _SignUpComponent();

  final _signUpVMProvider = ChangeNotifierProvider<_SignUpVM>((ref) {
    return _SignUpVM();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(_signUpVMProvider);
    return ResponsiveWidget(
      builder: (context, data) {
        return Column(
          children: [
            CustomInputField(
              hint: 'Email',
              titleIcon: AppIcons.email,
              title: 'Enter your email.',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              controller: vm.emailCont,
              onChange: (value) => vm.onChange(
                con: vm.emailCont,
                value: value,
                validator: TextFieldValidator.validateEmail,
              ),
              suffixWidget: _getSuffixIcon(con: vm.emailCont),
            ),
            SizedBox(
              height: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 16.0,
                tablet: 20.0,
                desktop: 24.0,
              ),
            ),
            CustomInputField(
              hint: "Enter your name.",
              title: 'Name',
              titleIcon: AppIcons.name,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              controller: vm.nameCont,
              onChange: (value) => vm.onChange(
                con: vm.nameCont,
                value: value,
                validator: TextFieldValidator.validateFullName,
              ),
              suffixWidget: _getSuffixIcon(con: vm.nameCont),
            ),
            SizedBox(
              height: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 16.0,
                tablet: 20.0,
                desktop: 24.0,
              ),
            ),
            _DOBPicker(
              setDate: (DateTime date) => vm.setDate(date),
              controller: vm.dobCon,
            ),
            SizedBox(
              height: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 16.0,
                tablet: 20.0,
                desktop: 24.0,
              ),
            ),
            _PasswordForm(_signUpVMProvider),
            SizedBox(
              height: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 10.0,
                tablet: 12.0,
                desktop: 16.0,
              ),
            ),
            CustomButton(
              title: "SIGN UP",
              onPressed: () => vm.registerUser(),
              bgColor: AppColors.primaryColor,
              textColor: AppColors.whiteColor,
            ),
            SizedBox(
              height: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 10.0,
                tablet: 12.0,
                desktop: 16.0,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget? _getSuffixIcon({required CustomTextController con}) {
    return (con.controller.text.isNotEmpty)
        ? Icon(
            con.error != null ? Icons.close : Icons.check,
            color: con.error != null
                ? AppColors.redColor
                : AppColors.primaryColor,
            size: 18.sp,
          )
        : null;
  }
}
