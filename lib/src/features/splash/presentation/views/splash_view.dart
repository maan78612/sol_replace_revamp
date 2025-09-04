part of 'package:sol_replace_revamp/src/features/splash/splash_library.dart';

/// Expert-level responsive splash view with fluid transitions
class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _scaleController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  final splashViewModelProvider = ChangeNotifierProvider<SplashViewModel>((
    ref,
  ) {
    return SplashViewModel(ref);
  });

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    // Main slide animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Scale animation for responsive transitions
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimations();
    });
  }

  void _startAnimations() {
    _animationController.forward();
    _scaleController.forward();

    Future.delayed(const Duration(milliseconds: 1800), () async {
      if (mounted) {
        await ref.read(splashViewModelProvider).checkAutoLogin();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: ResponsiveWidget(
          builder: (context, data) {
            return AnimatedBuilder(
              animation: Listenable.merge([
                _animationController,
                _scaleController,
              ]),
              builder: (context, child) {
                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: FadeTransition(
                          opacity: _opacityAnimation,
                          child: _buildFluidSplashContent(data),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildFluidSplashContent(ResponsiveData data) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: ResponsiveHelper.maxContentWidth(data),
        maxHeight: data.height * 0.8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Fluid logo with expert scaling
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 600),
            tween: Tween(
              begin: 0.0,
              end: ResponsiveHelper.fluidValue(
                data: data,
                mobile: 120.0,
                tablet: 180.0,
                desktop: 280.0,
                ultraWide: 320.0,
              ),
            ),
            curve: Curves.easeOutBack,
            builder: (context, animatedSize, child) {
              return Container(
                constraints: BoxConstraints(
                  minWidth: 80.0,
                  maxWidth: data.width * 0.6,
                  minHeight: 80.0,
                  maxHeight: data.height * 0.3,
                ),
                child: SvgPicture.asset(
                  AppIcons.logo,
                  width: animatedSize,
                  height: animatedSize,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),

          // Fluid spacing with smooth transitions
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 500),
            tween: Tween(
              begin: 0.0,
              end: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 32.0,
                tablet: 48.0,
                desktop: 72.0,
                ultraWide: 80.0,
              ),
            ),
            curve: Curves.easeOut,
            builder: (context, animatedHeight, child) {
              return SizedBox(height: animatedHeight);
            },
          ),

          // Fluid text with smooth font scaling
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 500),
            tween: Tween(
              begin: 0.0,
              end: ResponsiveHelper.responsiveFontSize(
                data: data,
                mobile: 14.0,
                tablet: 16.0,
                desktop: 18.0,
                ultraWide: 20.0,
              ),
            ),
            curve: Curves.easeOut,
            builder: (context, animatedFontSize, child) {
              return Container(
                constraints: BoxConstraints(maxWidth: data.width * 0.8),
                child: Text(
                  'Your Digital Solution Partner',
                  textAlign: TextAlign.center,
                  style: FontStyles.montserratRegular.copyWith(
                    fontSize: animatedFontSize,
                    color: AppColors.greyColor,
                    letterSpacing: 0.5,
                    height: 1.2,
                  ),
                ),
              );
            },
          ),

          // Fluid bottom spacing
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 500),
            tween: Tween(
              begin: 0.0,
              end: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 48.0,
                tablet: 64.0,
                desktop: 80.0,
                ultraWide: 96.0,
              ),
            ),
            curve: Curves.easeOut,
            builder: (context, animatedHeight, child) {
              return SizedBox(height: animatedHeight);
            },
          ),

          // Fluid progress indicator
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 400),
            tween: Tween(
              begin: 0.0,
              end: ResponsiveHelper.fluidValue(
                data: data,
                mobile: 24.0,
                tablet: 28.0,
                desktop: 32.0,
                ultraWide: 36.0,
              ),
            ),
            curve: Curves.easeOut,
            builder: (context, animatedSize, child) {
              return Container(
                width: animatedSize,
                height: animatedSize,
                child: CircularProgressIndicator(
                  strokeWidth: (animatedSize / 12).clamp(2.0, 4.0),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primaryColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
