part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(authRepository: ServiceLocator.instance.authRepository),
        ),
        BlocProvider<LoginBloc>(
          create: (context) =>
              LoginBloc(authRepository: ServiceLocator.instance.authRepository),
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(
            authRepository: ServiceLocator.instance.authRepository,
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.offWhiteColor,
        body: ResponsiveWidget(
          builder: (context, data) => _body(context, data),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, ResponsiveData data) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, top: 20),
          height: 50.h,
          child: SvgPicture.asset(
            AppIcons.logoHorizontal,
            fit: BoxFit.contain,
            alignment: data.isDesktopRange
                ? Alignment.topLeft
                : Alignment.topCenter,
          ),
        ),
        Expanded(
          child: Row(
            children: [
              // Left side illustration (only for desktop)
              if (data.isDesktopRange) ...[
                Expanded(
                  flex: ResponsiveHelper.value<int>(
                    data: data,
                    tablet: 1,
                    desktop: 2,
                    desktopLarge: 4,
                    fallback: 1,
                  ),
                  child: _sideLogo(context, data),
                ),
              ],

              // Right side form
              Expanded(
                flex: ResponsiveHelper.value<int>(
                  data: data,
                  tablet: 2,
                  desktop: 3,
                  desktopLarge: 5,
                  fallback: 1,
                ),
                child: _buildFormSection(context, data),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTermsText(ResponsiveData data) {
    final fontSize = ResponsiveHelper.adaptiveFontSize(
      data: data,
      baseSize: 14.0,
      scaleFactor: 0.95,
    );

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text:
                "By ${state.authType == AuthType.login ? "login" : "signup"} in you are agreeing our\n",
            style: FontStyles.montserratRegular.copyWith(
              fontSize: fontSize,
              color: AppColors.blackColor,
              height: 1.6.h,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Term and privacy policy',
                style: FontStyles.montserratRegular.copyWith(
                  fontSize: fontSize,
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Handle terms and privacy policy tap
                  },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sideLogo(BuildContext context, ResponsiveData data) {
    return Container(
      height: data.height,
      padding: ResponsiveHelper.responsivePadding(data),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.responsiveWidth(
              data: data,
              mobile: 300.0,
              tablet: 350.0,
              desktop: 400.0,
              ultraWide: 500.0,
            ),
            maxHeight: ResponsiveHelper.responsiveHeight(
              data: data,
              mobile: data.height * 0.8,
              tablet: data.height * 0.75,
              desktop: data.height * 0.7,
              ultraWide: data.height * 0.6,
            ),
          ),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return SvgPicture.asset(
                state.authType == AuthType.login
                    ? AppIcons.login
                    : AppIcons.signup,
                placeholderBuilder: (context) =>
                    const CircularProgressIndicator(),
                fit: BoxFit.contain,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection(BuildContext context, ResponsiveData data) {
    final elevation = ResponsiveHelper.value<double>(
      data: data,
      mobile: 12.0,
      tablet: 12.0,
      desktop: 12.0,
      desktopLarge: 16.0,
      ultraWide: 20.0,
      fallback: 0.0,
    );

    return Card(
      color: AppColors.whiteColor,
      elevation: elevation,
      margin: EdgeInsets.only(
        bottom: 40.h,
        top: data.isDesktopRange ? 0 : 40.h,
        right: 20.w,
        left: !data.isDesktopRange ? 20.w : 0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.responsiveRadius(
            data: data,
            mobile: 8.0,
            tablet: 10.0,
            desktop: 12.0,
            ultraWide: 16.0,
          ),
        ),
      ),
      child: SizedBox(
        height: data.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              40.verticalSpace,
              const _Switcher(),
              50.verticalSpace,
              _buildAuthCard(context, data),
              30.verticalSpace,
              // const _SocialAuth(),
              20.verticalSpace,
              _buildTermsText(data),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthCard(BuildContext context, ResponsiveData data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return state.authType == AuthType.login
                ? const _LoginComponent()
                : const _SignUpComponent();
          },
        ),
        10.verticalSpace,
      ],
    );
  }
}
