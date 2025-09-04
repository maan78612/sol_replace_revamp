part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class AuthView extends ConsumerWidget {
  AuthView({super.key});

  final _authVmProvider = ChangeNotifierProvider<_AuthVm>((ref) {
    return _AuthVm();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(_authVmProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: ResponsiveWidget(
          builder: (context, data) => _buildResponsiveLayout(context, data, vm),
        ),
      ),
    );
  }

  Widget _buildResponsiveLayout(
    BuildContext context,
    ResponsiveData data,
    _AuthVm vm,
  ) {
    // Use screen size categories for cleaner layout decisions
    switch (data.screenSize) {
      case ScreenSize.compact:
        return _buildMobileLayout(context, data, vm);
      case ScreenSize.medium:
      case ScreenSize.expanded:
      case ScreenSize.large:
        return _buildDesktopTabletLayout(context, data, vm);
    }
  }

  Widget _buildMobileLayout(
    BuildContext context,
    ResponsiveData data,
    _AuthVm vm,
  ) {
    return SingleChildScrollView(
      padding: ResponsiveHelper.responsivePadding(data),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top spacing
          SizedBox(
            height: ResponsiveHelper.responsiveSpacing(
              data: data,
              mobile: 40.0,
              tablet: 48.0,
              desktop: 56.0,
            ),
          ),

          // Auth type switcher
          _Switcher(_authVmProvider),

          // Main auth card
          _buildAuthCard(context, data, vm),

          // Spacing before social auth
          SizedBox(
            height: ResponsiveHelper.responsiveSpacing(
              data: data,
              mobile: 30.0,
              tablet: 36.0,
              desktop: 42.0,
            ),
          ),

          // Social authentication
          _SocialAuth(_authVmProvider),

          // Bottom spacing
          SizedBox(
            height: ResponsiveHelper.responsiveSpacing(
              data: data,
              mobile: 30.0,
              tablet: 36.0,
              desktop: 42.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopTabletLayout(
    BuildContext context,
    ResponsiveData data,
    _AuthVm vm,
  ) {
    return Row(
      children: [
        // Left side illustration (only for desktop)
        if (data.isDesktopRange) ...[
          Expanded(
            flex: ResponsiveHelper.value<int>(
              data: data,
              tablet: 1,
              desktop: 2,
              desktopLarge: 3,
              fallback: 1,
            ),
            child: _buildIllustrationSection(context, data, vm),
          ),
        ],

        // Right side form
        Expanded(
          flex: ResponsiveHelper.value<int>(
            data: data,
            tablet: 2,
            desktop: 3,
            desktopLarge: 2,
            fallback: 1,
          ),
          child: _buildFormSection(context, data, vm),
        ),
      ],
    );
  }

  Widget _buildIllustrationSection(
    BuildContext context,
    ResponsiveData data,
    _AuthVm vm,
  ) {
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
          child: SvgPicture.asset(
            vm.authScreenType == AuthType.login
                ? AppIcons.login
                : AppIcons.signup,
            placeholderBuilder: (context) => const CircularProgressIndicator(),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection(
    BuildContext context,
    ResponsiveData data,
    _AuthVm vm,
  ) {
    final elevation = ResponsiveHelper.value<double>(
      data: data,
      mobile: 0.0,
      tablet: 8.0,
      desktop: 12.0,
      desktopLarge: 16.0,
      ultraWide: 20.0,
      fallback: 0.0,
    );

    return Card(
      color: AppColors.whiteColor,
      elevation: elevation,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          data.isTabletRange || data.isDesktopRange
              ? ResponsiveHelper.responsiveRadius(
                  data: data,
                  mobile: 8.0,
                  tablet: 10.0,
                  desktop: 12.0,
                  ultraWide: 16.0,
                )
              : 0,
        ),
      ),
      child: SizedBox(
        height: data.height,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: hMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top spacing
              SizedBox(
                height: ResponsiveHelper.responsiveSpacing(
                  data: data,
                  mobile: 60.0,
                  tablet: 72.0,
                  desktop: 84.0,
                ),
              ),

              // Auth type switcher
              _Switcher(_authVmProvider),

              // Main auth card
              _buildAuthCard(context, data, vm),

              30.verticalSpace,

              // Social authentication
              _SocialAuth(_authVmProvider),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthCard(BuildContext context, ResponsiveData data, _AuthVm vm) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: ResponsiveHelper.maxContentWidth(data),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top spacing
          SizedBox(
            height: ResponsiveHelper.responsiveSpacing(
              data: data,
              mobile: 20.0,
              tablet: 24.0,
              desktop: 28.0,
            ),
          ),

          // Title
          _buildTitle(data, vm),

          10.verticalSpace,

          // Terms and privacy text
          _buildTermsText(data),

          // Spacing before form
          20.verticalSpace,

          // Auth form component
          vm.authScreenType == AuthType.login
              ? _LoginComponent()
              : _SignUpComponent(),
        ],
      ),
    );
  }

  Widget _buildTitle(ResponsiveData data, _AuthVm vm) {
    final fontSize = ResponsiveHelper.adaptiveFontSize(
      data: data,
      baseSize: 24.0,
      scaleFactor: 1.0,
    );

    return Text(
      vm.authScreenType == AuthType.login ? "Login" : "Sign Up",
      style: FontStyles.montserratBold.copyWith(
        fontSize: fontSize,
        color: AppColors.blackColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTermsText(ResponsiveData data) {
    final fontSize = ResponsiveHelper.adaptiveFontSize(
      data: data,
      baseSize: 14.0,
      scaleFactor: 0.95,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "By login in you are agreeing our\n",
        style: FontStyles.montserratRegular.copyWith(
          fontSize: fontSize,
          color: AppColors.blackColor,
          height: 1.4,
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
  }
}
