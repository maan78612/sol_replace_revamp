part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _Switcher extends ConsumerWidget {
  final ChangeNotifierProvider<_AuthVm> authVmProvider;

  const _Switcher(this.authVmProvider);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(authVmProvider);
    return ResponsiveWidget(
      builder: (context, data) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            indicatorHeader(
              title: 'Login',
              authType: AuthType.login,
              vm: vm,
              data: data,
            ),
            SizedBox(
              width: ResponsiveHelper.responsiveWidth(
                data: data,
                mobile: 25.0,
                tablet: 30.0,
                desktop: 35.0,
              ),
            ),
            indicatorHeader(
              title: 'Sign Up',
              authType: AuthType.signup,
              vm: vm,
              data: data,
            ),
          ],
        );
      },
    );
  }

  Widget indicatorHeader({
    required String title,
    required AuthType authType,
    required _AuthVm vm,
    required ResponsiveData data,
  }) {
    return GestureDetector(
      onTap: () {
        vm.loginSignUpHeader(authType);
      },
      child: Text(
        title,
        style: FontStyles.montserratBold.copyWith(
          decoration: authType == vm.authScreenType
              ? TextDecoration.underline
              : null,
          fontSize: ResponsiveHelper.adaptiveFontSize(
            data: data,
            baseSize: 18.0,
            scaleFactor: 1.0,
          ),
          color: authType == vm.authScreenType
              ? AppColors.primaryColor
              : AppColors.greyColor,
        ),
      ),
    );
  }
}
