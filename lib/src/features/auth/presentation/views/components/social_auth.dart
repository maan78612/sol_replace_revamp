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
    final spacing = ResponsiveHelper.responsiveWidth(
      data: data,
      mobile: 15.0,
      tablet: 18.0,
      desktop: 21.0,
    );

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
        SizedBox(width: spacing),
        _buildSocialButton(
          imagePath: AppIcons.gmail,
          onTap: () {
            vm.signInWithGoogle();
          },
          data: data,
        ),
        // if (Platform.isIOS) ...[
        //   SizedBox(width: spacing),
        //   _buildSocialButton(
        //     imagePath: AppImages.apple,
        //     onTap: () {},
        //     data: data,
        //   ),
        // ],
      ],
    );
  }

  Widget _buildSocialButton({
    required String imagePath,
    required VoidCallback onTap,
    required ResponsiveData data,
  }) {
    final buttonSize = ResponsiveHelper.responsiveWidth(
      data: data,
      mobile: 48.0,
      tablet: 52.0,
      desktop: 56.0,
      ultraWide: 60.0,
    );

    final iconSize = ResponsiveHelper.responsiveWidth(
      data: data,
      mobile: 27.0,
      tablet: 30.0,
      desktop: 33.0,
      ultraWide: 36.0,
    );

    final borderRadius = ResponsiveHelper.responsiveRadius(
      data: data,
      mobile: 10.0,
      tablet: 12.0,
      desktop: 14.0,
      ultraWide: 16.0,
    );

    return CommonInkWell(
      onTap:()=> onTap(),
      child: Container(
        height: buttonSize,
        width: buttonSize,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGreyColor),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        child: Center(
          child: SvgPicture.asset(
            imagePath,
            height: iconSize,
            width: iconSize,
            fit: BoxFit.contain,
            // Remove any color filters that might hide the icons
          ),
        ),
      ),
    );
  }
}
