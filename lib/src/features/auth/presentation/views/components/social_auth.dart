part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _SocialAuth extends StatelessWidget {
  const _SocialAuth();

  @override
  Widget build(BuildContext context) {

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
            _socialLoginButtons(context, data),
          ],
        );
      },
    );
  }

  Widget _socialLoginButtons(BuildContext context, ResponsiveData data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          imagePath: AppIcons.facebook,
          onTap: () {
            context.read<AuthBloc>().add(const SignInWithFacebook());
          },
          data: data,
        ),
        20.horizontalSpace,
        _buildSocialButton(
          imagePath: AppIcons.gmail,
          onTap: () {
            context.read<AuthBloc>().add(const SignInWithGoogle());
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
