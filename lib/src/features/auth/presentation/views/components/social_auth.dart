part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _SocialAuth extends ConsumerWidget {
  final ChangeNotifierProvider<_AuthVm> authVmProvider;

  const _SocialAuth(this.authVmProvider);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(authVmProvider);

    return ResponsiveWidget(
      builder: (context, data) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.responsiveWidth(
                      data: data,
                      mobile: 16.0,
                      tablet: 20.0,
                      desktop: 24.0,
                    ),
                  ),
                  child: Text(
                    "OR",
                    style: FontStyles.montserratMedium.copyWith(
                      fontSize: ResponsiveHelper.adaptiveFontSize(
                        data: data,
                        baseSize: 14.0,
                        scaleFactor: 0.9,
                      ),
                      color: AppColors.darkGreyColor,
                    ),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            SizedBox(
              height: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 30.0,
                tablet: 36.0,
                desktop: 42.0,
              ),
            ),
            _socialLoginButtons(vm, data),
          ],
        );
      },
    );
  }

  Widget _socialLoginButtons(_AuthVm vm, ResponsiveData data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          imagePath: AppIcons.facebook,
          onTap: () {
            vm.signInWithFacebook();
          },
          data: data,
        ),
        20.horizontalSpace,
        _buildSocialButton(
          imagePath: AppIcons.gmail,
          onTap: () {
            vm.signInWithGoogle();
          },
          data: data,
        ),
        if (Platform.isMacOS || Platform.isIOS) ...[
          20.horizontalSpace,
          _buildSocialButton(
            imagePath: AppIcons.apple,
            onTap: () {},
            data: data,
          ),
        ],
      ],
    );
  }

  Widget _buildSocialButton({
    required String imagePath,
    required VoidCallback onTap,
    required ResponsiveData data,
  }) {
    final size = 55.0;

    return CommonInkWell(
      onTap: () => onTap(),
      child: Container(
        constraints: BoxConstraints(maxHeight: size, maxWidth: size),
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGreyColor),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: Center(
          child: SvgPicture.asset(
            imagePath,

            fit: BoxFit.contain,
            // Remove any color filters that might hide the icons
          ),
        ),
      ),
    );
  }
}
