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
            30.verticalSpace,
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
            30.verticalSpace,
            _DOBPicker(
              setDate: (DateTime date) => vm.setDate(date),
              controller: vm.dobCon,
            ),
            30.verticalSpace,
            _PasswordForm(_signUpVMProvider),
            40.verticalSpace,
            CustomButton(
              title: "SIGN UP",
              onPressed: () => vm.registerUser(),
              bgColor: AppColors.primaryColor,
              textColor: AppColors.whiteColor,
            ),
            30.verticalSpace,
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

          )
        : null;
  }
}
