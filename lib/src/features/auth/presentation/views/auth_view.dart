part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class AuthView extends ConsumerWidget {
  AuthView({super.key});

  final _authVmProvider = ChangeNotifierProvider<_AuthVm>((ref) {
    return _AuthVm();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(_authVmProvider);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: ResponsiveWidget(
        builder: (context, data) => _buildResponsiveLayout(context, data, vm),
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
          40.verticalSpace,
          _Switcher(_authVmProvider),
          _buildAuthCard(context, data, vm),
          30.verticalSpace,
          _SocialAuth(_authVmProvider),
          20.verticalSpace,
          _buildTermsText(data,vm),
          40.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildTermsText(ResponsiveData data,_AuthVm vm) {
    final fontSize = ResponsiveHelper.adaptiveFontSize(
      data: data,
      baseSize: 14.0,
      scaleFactor: 0.95,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "By ${vm.authScreenType == AuthType.login ? "login" : "signup"} in you are agreeing our\n",
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              40.verticalSpace,
              _Switcher(_authVmProvider),
              _buildAuthCard(context, data, vm),
              30.verticalSpace,
              _SocialAuth(_authVmProvider),
              20.verticalSpace,
              _buildTermsText(data,vm),
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
          30.verticalSpace,

          40.verticalSpace,
          vm.authScreenType == AuthType.login
              ? _LoginComponent()
              : _SignUpComponent(),
          10.verticalSpace,
        ],
      ),
    );
  }
}
