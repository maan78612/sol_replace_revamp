part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _Switcher extends StatelessWidget {
  const _Switcher();

  /// Get maximum width for switcher based on available container space (like CustomInputField)
  double _getMaxFieldWidth(ResponsiveData data, double availableWidth) {
    return ResponsiveHelper.value<double>(
      data: data,
      mobile: availableWidth  * 0.8,
      mobileLarge: availableWidth * 0.8,
      tablet: availableWidth * 0.5,
      tabletLarge: availableWidth * 0.5,
      desktop: availableWidth * 0.7,
      desktopLarge: availableWidth * 0.7,
      ultraWide: availableWidth * 0.7,
      fallback: availableWidth,
    );
  }

  @override
  Widget build(BuildContext context) {

    return ResponsiveWidget(
      builder: (context, data) => LayoutBuilder(
        builder: (context, constraints) {
          final fieldWidth = _getMaxFieldWidth(data, constraints.maxWidth);

          final borderRadius = ResponsiveHelper.responsiveRadius(
            data: data,
            mobile: 25.0,
            tablet: 27.5,
            desktop: 30.0,
          );

          return Container(
            height: inputFieldHeight(data),
            width: fieldWidth,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: AppColors.greyColor.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Stack(
                  clipBehavior: Clip.antiAlias,
                  children: [
                    // Static sliding indicator
                    _buildSlidingIndicator(state, fieldWidth, borderRadius),
                    // Tab buttons
                    _buildTabButtons(context, state, data, inputFieldHeight(data)),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  /// Build the static sliding indicator
  Widget _buildSlidingIndicator(
    AuthState state,
    double fieldWidth,
    double borderRadius,
  ) {
    final indicatorWidth = (fieldWidth / 2) - 8;
    final leftPosition = state.authType == AuthType.login
        ? 4.0
        : (fieldWidth / 2) + 4;

    return Positioned(
      left: leftPosition,
      top: 4,
      bottom: 4,
      child: Container(
        width: indicatorWidth,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(borderRadius - 4),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
      ),
    );
  }

  /// Build the tab buttons row
  Widget _buildTabButtons(
    BuildContext context,
    AuthState state,
    ResponsiveData data,
    double containerHeight,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildTabButton(
            context: context,
            title: 'Login',
            authType: AuthType.login,
            state: state,
            data: data,
            containerHeight: containerHeight,
          ),
        ),
        Expanded(
          child: _buildTabButton(
            context: context,
            title: 'Sign Up',
            authType: AuthType.signup,
            state: state,
            data: data,
            containerHeight: containerHeight,
          ),
        ),
      ],
    );
  }

  /// Build individual tab button with improved interaction
  Widget _buildTabButton({
    required BuildContext context,
    required String title,
    required AuthType authType,
    required AuthState state,
    required ResponsiveData data,
    required double containerHeight,
  }) {
    final isSelected = authType == state.authType;

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          context.read<AuthBloc>().add(AuthTypeChanged(authType));
        }
      },
      child: Container(
        height: containerHeight,
        alignment: Alignment.center,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: FontStyles.montserratBold.copyWith(
            fontSize: ResponsiveHelper.adaptiveFontSize(
              data: data,
              baseSize: 14.0,
              scaleFactor: 1.0,
            ),
            color: isSelected ? AppColors.whiteColor : AppColors.primaryColor,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            letterSpacing: 0.5,
            shadows: isSelected
                ? [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ]
                : null,
          ),
        ),
      ),
    );
  }
}
