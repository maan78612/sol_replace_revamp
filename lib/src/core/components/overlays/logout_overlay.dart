import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';
import 'package:sol_replace_revamp/src/core/constants/icons.dart';

class LogoutOverlay extends StatefulWidget {
  final bool isUnauthorized;

  const LogoutOverlay({super.key, required this.isUnauthorized});

  @override
  State<LogoutOverlay> createState() => _LogoutOverlayState();
}

class _LogoutOverlayState extends State<LogoutOverlay>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _flipController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _flipController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() {
    _fadeController.forward();
    _scaleController.forward();
    _flipController.repeat();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.blackColor.withValues(alpha:0.95),
                  AppColors.blackColor.withValues(alpha:0.98),
                  AppColors.blackColor.withValues(alpha:0.95),
                ],
              ),
            ),
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAnimatedIcon(),
                  40.verticalSpace,
                  _buildLogoutText(),

                  30.verticalSpace,
                  _buildSubText(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedIcon() {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: AnimatedBuilder(
            animation: _flipAnimation,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // Add perspective
                  ..rotateY(_flipAnimation.value * 2 * 3.14159),
                alignment: Alignment.center,
                child: Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.redColor.withValues(alpha:0.8),
                        AppColors.redColor.withValues(alpha:0.4),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.redColor.withValues(alpha:0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppIcons.logout,
                      width: 80.w,
                      height: 80.w,
                      colorFilter: ColorFilter.mode(
                        AppColors.whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildLogoutText() {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Text(
            widget.isUnauthorized ? "Session Expired" : "Logging Out",
            style: FontStyles.montserratBold.copyWith(
              fontSize: 24.sp,
              color: AppColors.whiteColor,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }



  Widget _buildSubText() {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value * 0.7,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.isUnauthorized
                  ? "Your session has expired for security reasons.\nPlease log in again to continue..."
                  : "Please wait while we sign you out...",
              style: FontStyles.montserratRegular.copyWith(
                fontSize: 14.sp,
                color: AppColors.lightGreyColor,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}

// // Helper class to manage the logout overlay
// class LogoutOverlayHelper {
//   static OverlayEntry? _overlayEntry;
//   static DateTime? _showTime;
//
//   static void show(bool isUnauthorized) {
//     _showOverlay(isUnauthorized);
//   }
//
//   static void _showOverlay(bool isUnauthorized) {
//     if (_overlayEntry != null) {
//       debugPrint('⚠️ Overlay already showing - skipping');
//       return;
//     }
//
//     try {
//       final materialAppContext = materialAppKey.currentContext;
//       if (materialAppContext == null) {
//         throw Exception('MaterialApp context is null');
//       }
//
//       // Create the overlay entry
//       _overlayEntry = OverlayEntry(
//         builder: (context) => LogoutOverlay(isUnauthorized: isUnauthorized),
//       );
//
//       _insertOverlay(materialAppContext);
//
//       _showTime = DateTime.now();
//     } catch (e) {
//       throw 'Failed to show logout overlay: $e';
//     }
//   }
//
//   static void _insertOverlay(BuildContext context) {
//     try {
//       // Try to get the overlay using the context with rootOverlay
//       final overlay = Overlay.of(context, rootOverlay: true);
//       overlay.insert(_overlayEntry!);
//     } catch (e) {
//       debugPrint('Failed to insert overlay with rootOverlay: $e');
//
//       // Try without rootOverlay
//       try {
//         final overlay = Overlay.of(context, rootOverlay: true);
//         overlay.insert(_overlayEntry!);
//       } catch (e2) {
//         debugPrint('Failed to insert overlay without rootOverlay: $e2');
//
//         // Try to find the overlay by traversing the widget tree
//         try {
//           final overlay = _findOverlayInWidgetTree(context);
//           if (overlay != null) {
//             overlay.insert(_overlayEntry!);
//           } else {
//             throw Exception('Could not find overlay in widget tree');
//           }
//         } catch (e3) {
//           debugPrint('Failed to find overlay in widget tree: $e3');
//           rethrow;
//         }
//       }
//     }
//   }
//
//   static OverlayState? _findOverlayInWidgetTree(BuildContext context) {
//     try {
//       // Try to find the Navigator and get its overlay
//       final navigator = Navigator.of(context);
//       return navigator.overlay;
//     } catch (e) {
//       debugPrint('Error finding overlay in widget tree: $e');
//     }
//     return null;
//   }
//
//   static Future<void> hide() async {
//     if (_overlayEntry == null) {
//       debugPrint('⚠️ No overlay to hide');
//       return;
//     }
//
//     try {
//       // Ensure overlay is visible for at least 2 seconds
//       if (_showTime != null) {
//         final elapsed = DateTime.now().difference(_showTime!);
//         const minDuration = Duration(seconds: 2);
//
//         if (elapsed < minDuration) {
//           final remaining = minDuration - elapsed;
//           debugPrint(
//             '⏳ Waiting ${remaining.inMilliseconds}ms before hiding overlay...',
//           );
//           await Future.delayed(remaining);
//         }
//       }
//
//       debugPrint('🎭 Removing logout overlay...');
//       _overlayEntry?.remove();
//       _overlayEntry = null;
//       _showTime = null;
//       debugPrint('✅ Logout overlay removed successfully');
//     } catch (e) {
//       // If there's an error hiding the overlay, just clean up the references
//       debugPrint('❌ Error hiding overlay: $e');
//       _overlayEntry = null;
//       _showTime = null;
//       throw Exception('Failed to hide logout overlay: $e');
//     }
//   }
// }
