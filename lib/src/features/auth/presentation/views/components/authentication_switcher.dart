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
  
  // Track current auth type for animation control
  AuthType _currentAuthType = AuthType.login;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Slide animation for the indicator
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    // Scale animation for button press feedback
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    // Smooth slide animation with better easing
    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.fastEaseInToSlowEaseOut,
    ));

    // Subtle scale animation for interaction feedback
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      final vm = ref.read(widget.authVmProvider);
      _currentAuthType = vm.authScreenType;
      
      print('🏁 Initial setup: authType = $_currentAuthType');
      
      // Set initial position immediately without animation
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          if (_currentAuthType == AuthType.signup) {
            print('📍 Setting initial position to signup (1.0)');
            _slideController.value = 1.0;
          } else {
            print('📍 Setting initial position to login (0.0)');
            _slideController.value = 0.0;
          }
        }
      });
    }
  }

  void _handleAuthTypeChange(AuthType newAuthType) {
    if (_currentAuthType != newAuthType && mounted) {
      print('🔄 Animation: Changing from $_currentAuthType to $newAuthType');
      
      setState(() {
        _currentAuthType = newAuthType;
      });
      
      // Animate to new position
      if (newAuthType == AuthType.signup) {
        print('➡️ Animating forward to signup (current value: ${_slideController.value})');
        _slideController.forward();
      } else {
        print('⬅️ Animating reverse to login (current value: ${_slideController.value})');
        _slideController.reverse();
      }
    } else if (_currentAuthType == newAuthType) {
      print('✅ Same auth type: $newAuthType, no animation needed');
    }
  }

  void _handleButtonPress() {
    if (mounted) {
      _scaleController.forward().then((_) {
        if (mounted) {
          _scaleController.reverse();
        }
      });
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  /// Get maximum width for switcher based on available container space (like CustomInputField)
  double _getMaxFieldWidth(ResponsiveData data, double availableWidth) {
    return ResponsiveHelper.value<double>(
      data: data,
      mobile: availableWidth,
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
    final vm = ref.watch(widget.authVmProvider);
    
    // Direct state change detection and animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && vm.authScreenType != _currentAuthType) {
        print('🎯 Direct state change detected: $_currentAuthType → ${vm.authScreenType}');
        _handleAuthTypeChange(vm.authScreenType);
      }
    });

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

          return AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  height: inputFieldHeight,
                  width: fieldWidth,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(
                      color: AppColors.greyColor.withOpacity(0.3),
                      width: 1.0,
                    ),
                  ),
                  child: Stack(
                    clipBehavior: Clip.antiAlias,
                    children: [
                      // Animated sliding indicator
                      _buildSlidingIndicator(fieldWidth, borderRadius),
                      // Tab buttons
                      _buildTabButtons(vm, data, inputFieldHeight),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// Build the animated sliding indicator
  Widget _buildSlidingIndicator(double fieldWidth, double borderRadius) {
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        final indicatorWidth = (fieldWidth / 2) - 8;
        final leftPosition = _slideAnimation.value * (fieldWidth / 2) + 4;
        
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
                  color: AppColors.primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Build the tab buttons row
  Widget _buildTabButtons(_AuthVm vm, ResponsiveData data, double containerHeight) {
    return Row(
      children: [
        Expanded(
          child: _buildTabButton(
            title: 'Login',
            authType: AuthType.login,
            vm: vm,
            data: data,
            containerHeight: containerHeight,
          ),
        ),
        Expanded(
          child: _buildTabButton(
            title: 'Sign Up',
            authType: AuthType.signup,
            vm: vm,
            data: data,
            containerHeight: containerHeight,
          ),
        ),
      ],
    );
  }

  /// Build individual tab button with improved interaction
  Widget _buildTabButton({
    required String title,
    required AuthType authType,
    required _AuthVm vm,
    required ResponsiveData data,
    required double containerHeight,
  }) {
    final isSelected = authType == vm.authScreenType;

    return GestureDetector(
      onTapDown: (_) => _handleButtonPress(),
      onTap: () {
        print('🔘 Button tapped: $title (authType: $authType, isSelected: $isSelected)');
        if (!isSelected) {
          print('🚀 Calling vm.loginSignUpHeader($authType)');
          vm.loginSignUpHeader(authType);
        } else {
          print('⚠️ Button already selected, no action taken');
        }
      },
      child: Container(
        height: containerHeight,
        alignment: Alignment.center,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutCubic,
          style: FontStyles.montserratBold.copyWith(
            fontSize: ResponsiveHelper.adaptiveFontSize(
              data: data,
              baseSize: 14.0,
              scaleFactor: 1.0,
            ),
            color: isSelected ? AppColors.whiteColor : AppColors.primaryColor,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            letterSpacing: 0.5,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              shadows: isSelected
                  ? [
                      Shadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                      ),
                    ]
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
