part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _Switcher extends ConsumerStatefulWidget {
  final ChangeNotifierProvider<_AuthVm> authVmProvider;

  const _Switcher(this.authVmProvider);

  @override
  ConsumerState<_Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends ConsumerState<_Switcher>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  /// Get maximum width for switcher based on available container space (like CustomInputField)
  double _getMaxFieldWidth(ResponsiveData data, double availableWidth) {
    // For mobile screen OR mobile-sized container, use full available width
    if (data.isMobileRange || availableWidth <= ResponsiveConfig.mobileLarge) {
      return availableWidth;
    }

    // For tablet and desktop, use a percentage of the available container width
    return ResponsiveHelper.value<double>(
      data: data,
      mobile: availableWidth,
      mobileLarge: availableWidth * 0.95,
      tablet: availableWidth * 0.85,
      tabletLarge: availableWidth * 0.75,
      desktop: availableWidth * 0.7,
      desktopLarge: availableWidth * 0.65,
      ultraWide: availableWidth * 0.65,
      fallback: availableWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(widget.authVmProvider);
    
    // Update slide animation based on current auth type
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (vm.authScreenType == AuthType.signup) {
        _slideController.forward();
      } else {
        _slideController.reverse();
      }
    });

    return ResponsiveWidget(
      builder: (context, data) => LayoutBuilder(
        builder: (context, constraints) {
          // Calculate field width like CustomInputField
          final fieldWidth = _getMaxFieldWidth(data, constraints.maxWidth);
          


          final borderRadius = ResponsiveHelper.responsiveRadius(
            data: data,
            mobile: 25.0,
            tablet: 27.5,
            desktop: 30.0,
          );

          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: fieldWidth),
            child: Container(
              width: fieldWidth,
              height: inputFieldHeight,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: AppColors.greyColor.withOpacity(0.3),
                  width: 1.0,
                ),
              ),
              child: Stack(
                children: [
                  // Animated sliding indicator background
                  AnimatedBuilder(
                    animation: _slideAnimation,
                    builder: (context, child) {
                      return Positioned(
                        left: _slideAnimation.value * (fieldWidth / 2),
                        top: 3,
                        child: Container(
                          width: (fieldWidth / 2) - 6,
                          height: inputFieldHeight - 6,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(borderRadius - 3),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // Tab buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildTabButton(
                          title: 'Login',
                          authType: AuthType.login,
                          vm: vm,
                          data: data,
                          containerHeight: inputFieldHeight,
                        ),
                      ),
                      Expanded(
                        child: _buildTabButton(
                          title: 'Sign Up',
                          authType: AuthType.signup,
                          vm: vm,
                          data: data,
                          containerHeight: inputFieldHeight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabButton({
    required String title,
    required AuthType authType,
    required _AuthVm vm,
    required ResponsiveData data,
    required double containerHeight,
  }) {
    final isSelected = authType == vm.authScreenType;
    
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          _scaleController.forward().then((_) {
            _scaleController.reverse();
          });
          vm.loginSignUpHeader(authType);
        }
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: isSelected ? _scaleAnimation.value : 1.0,
            child: Container(
              height: containerHeight,
              alignment: Alignment.center,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                style: FontStyles.montserratBold.copyWith(
                  fontSize: ResponsiveHelper.adaptiveFontSize(
                    data: data,
                    baseSize: isSelected ? 16.0 : 15.0,
                    scaleFactor: 1.0,
                  ),
                  color: isSelected 
                      ? AppColors.whiteColor 
                      : AppColors.primaryColor,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
