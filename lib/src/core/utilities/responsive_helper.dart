import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

/// Device types with more granular breakpoints for precise responsive design
enum DeviceType {
  mobile,
  mobileLarge,
  tablet,
  tabletLarge,
  desktop,
  desktopLarge,
  ultraWide,
}

/// Screen size category following Material Design 3 guidelines
enum ScreenSize { compact, medium, expanded, large }

/// Orientation with additional context
enum ResponsiveOrientation { portrait, landscape, square }

/// Device category for different interaction patterns
enum DeviceCategory {
  touch, // Mobile/Tablet
  hybrid, // Convertible devices
  pointer, // Desktop/Mouse
}

/// Immutable responsive data class with comprehensive screen information
@immutable
class ResponsiveData {
  final DeviceType deviceType;
  final ScreenSize screenSize;
  final DeviceCategory deviceCategory;
  final ResponsiveOrientation responsiveOrientation;
  final double width;
  final double height;
  final double logicalWidth;
  final double logicalHeight;
  final Orientation orientation;
  final double pixelRatio;
  final double textScaleFactor;
  final EdgeInsets viewPadding;
  final EdgeInsets viewInsets;
  final bool isAccessibilityEnabled;
  final Brightness brightness;
  final double devicePixelRatio;

  const ResponsiveData._({
    required this.deviceType,
    required this.screenSize,
    required this.deviceCategory,
    required this.responsiveOrientation,
    required this.width,
    required this.height,
    required this.logicalWidth,
    required this.logicalHeight,
    required this.orientation,
    required this.pixelRatio,
    required this.textScaleFactor,
    required this.viewPadding,
    required this.viewInsets,
    required this.isAccessibilityEnabled,
    required this.brightness,
    required this.devicePixelRatio,
  });

  /// Factory constructor with validation
  factory ResponsiveData.create({
    required DeviceType deviceType,
    required ScreenSize screenSize,
    required DeviceCategory deviceCategory,
    required ResponsiveOrientation responsiveOrientation,
    required double width,
    required double height,
    required double logicalWidth,
    required double logicalHeight,
    required Orientation orientation,
    required double pixelRatio,
    required double textScaleFactor,
    required EdgeInsets viewPadding,
    required EdgeInsets viewInsets,
    required bool isAccessibilityEnabled,
    required Brightness brightness,
    required double devicePixelRatio,
  }) {
    assert(width > 0, 'Width must be positive');
    assert(height > 0, 'Height must be positive');
    assert(pixelRatio > 0, 'Pixel ratio must be positive');

    return ResponsiveData._(
      deviceType: deviceType,
      screenSize: screenSize,
      deviceCategory: deviceCategory,
      responsiveOrientation: responsiveOrientation,
      width: width,
      height: height,
      logicalWidth: logicalWidth,
      logicalHeight: logicalHeight,
      orientation: orientation,
      pixelRatio: pixelRatio,
      textScaleFactor: textScaleFactor,
      viewPadding: viewPadding,
      viewInsets: viewInsets,
      isAccessibilityEnabled: isAccessibilityEnabled,
      brightness: brightness,
      devicePixelRatio: devicePixelRatio,
    );
  }

  // Convenience getters for device types
  bool get isMobile => deviceType == DeviceType.mobile;

  bool get isMobileLarge => deviceType == DeviceType.mobileLarge;

  bool get isTablet => deviceType == DeviceType.tablet;

  bool get isTabletLarge => deviceType == DeviceType.tabletLarge;

  bool get isDesktop => deviceType == DeviceType.desktop;

  bool get isDesktopLarge => deviceType == DeviceType.desktopLarge;

  bool get isUltraWide => deviceType == DeviceType.ultraWide;

  // Screen size convenience getters
  bool get isCompact => screenSize == ScreenSize.compact;

  bool get isMedium => screenSize == ScreenSize.medium;

  bool get isExpanded => screenSize == ScreenSize.expanded;

  bool get isLarge => screenSize == ScreenSize.large;

  // Orientation getters
  bool get isPortrait =>
      responsiveOrientation == ResponsiveOrientation.portrait;

  bool get isLandscape =>
      responsiveOrientation == ResponsiveOrientation.landscape;

  bool get isSquare => responsiveOrientation == ResponsiveOrientation.square;

  // Device category getters
  bool get isTouchDevice => deviceCategory == DeviceCategory.touch;

  bool get isHybridDevice => deviceCategory == DeviceCategory.hybrid;

  bool get isPointerDevice => deviceCategory == DeviceCategory.pointer;

  // Advanced dimension helpers
  bool get isWide => width > height;

  bool get isTall => height > width;

  double get aspectRatio => width / height;

  double get diagonalSize => math.sqrt(width * width + height * height);

  double get shortestSide => math.min(width, height);

  double get longestSide => math.max(width, height);

  // Density and scaling helpers
  bool get isHighDensity => pixelRatio >= 2.0;

  bool get isLowDensity => pixelRatio < 1.5;

  bool get hasLargeText => textScaleFactor > 1.3;

  bool get hasSmallText => textScaleFactor < 0.9;

  // Accessibility helpers
  bool get hasNotch => viewPadding.top > 24;

  bool get hasBottomInsets => viewInsets.bottom > 0;

  bool get isDarkMode => brightness == Brightness.dark;

  bool get isLightMode => brightness == Brightness.light;

  // Breakpoint helpers
  bool get isMobileRange => isMobile || isMobileLarge;

  bool get isTabletRange => isTablet || isTabletLarge;

  bool get isDesktopRange => isDesktop || isDesktopLarge || isUltraWide;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponsiveData &&
          runtimeType == other.runtimeType &&
          deviceType == other.deviceType &&
          screenSize == other.screenSize &&
          deviceCategory == other.deviceCategory &&
          responsiveOrientation == other.responsiveOrientation &&
          width == other.width &&
          height == other.height &&
          orientation == other.orientation &&
          pixelRatio == other.pixelRatio;

  @override
  int get hashCode => Object.hash(
    deviceType,
    screenSize,
    deviceCategory,
    responsiveOrientation,
    width,
    height,
    orientation,
    pixelRatio,
  );

  @override
  String toString() =>
      'ResponsiveData('
      'deviceType: $deviceType, '
      'screenSize: $screenSize, '
      'size: ${width.toStringAsFixed(1)}x${height.toStringAsFixed(1)}, '
      'orientation: $responsiveOrientation)';
}

/// Responsive configuration with clean breakpoints
class ResponsiveConfig {
  ResponsiveConfig._();

  // Device type breakpoints (logical pixels)
  static const double mobile = 360.0;
  static const double mobileLarge = 480.0;
  static const double tablet = 768.0;
  static const double tabletLarge = 1024.0;
  static const double desktop = 1280.0;
  static const double desktopLarge = 1440.0;
  static const double ultraWide = 1920.0;

  // Material Design 3 breakpoints
  static const double compactWidth = 600.0;
  static const double mediumWidth = 840.0;
  static const double expandedWidth = 1200.0;
  static const double largeWidth = 1600.0;
}

/// Expert-level responsive helper for UI responsiveness
class ResponsiveHelper {
  ResponsiveHelper._();

  /// Get device type with enhanced granular breakpoints
  static DeviceType getDeviceType(double width) {
    if (width < ResponsiveConfig.mobile) return DeviceType.mobile;
    if (width < ResponsiveConfig.mobileLarge) return DeviceType.mobile;
    if (width < ResponsiveConfig.tablet) return DeviceType.mobileLarge;
    if (width < ResponsiveConfig.tabletLarge) return DeviceType.tablet;
    if (width < ResponsiveConfig.desktop) return DeviceType.tabletLarge;
    if (width < ResponsiveConfig.desktopLarge) return DeviceType.desktop;
    if (width < ResponsiveConfig.ultraWide) return DeviceType.desktopLarge;
    return DeviceType.ultraWide;
  }

  /// Get screen size category (Material Design 3 + Large)
  static ScreenSize getScreenSize(double width) {
    if (width < ResponsiveConfig.compactWidth) return ScreenSize.compact;
    if (width < ResponsiveConfig.mediumWidth) return ScreenSize.medium;
    if (width < ResponsiveConfig.expandedWidth) return ScreenSize.expanded;
    return ScreenSize.large;
  }

  /// Get device category based on screen size and interaction patterns
  static DeviceCategory getDeviceCategory(double width, double height) {
    final diagonal = math.sqrt(width * width + height * height);
    if (diagonal < 7.0) return DeviceCategory.touch; // Phone/small tablet
    if (diagonal < 13.0)
      return DeviceCategory.hybrid; // Large tablet/convertible
    return DeviceCategory.pointer; // Desktop/laptop
  }

  /// Get responsive orientation with square detection
  static ResponsiveOrientation getResponsiveOrientation(
    double width,
    double height,
  ) {
    final aspectRatio = width / height;
    if ((aspectRatio - 1.0).abs() < 0.1) return ResponsiveOrientation.square;
    return width > height
        ? ResponsiveOrientation.landscape
        : ResponsiveOrientation.portrait;
  }

  /// Create responsive data object
  static ResponsiveData getResponsiveData(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final orientation = mediaQuery.orientation;
    final pixelRatio = mediaQuery.devicePixelRatio;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0);

    // Calculate device properties
    final deviceType = getDeviceType(size.width);
    final screenSize = getScreenSize(size.width);
    final deviceCategory = getDeviceCategory(size.width, size.height);
    final responsiveOrientation = getResponsiveOrientation(
      size.width,
      size.height,
    );

    return ResponsiveData.create(
      deviceType: deviceType,
      screenSize: screenSize,
      deviceCategory: deviceCategory,
      responsiveOrientation: responsiveOrientation,
      width: size.width,
      height: size.height,
      logicalWidth: size.width / pixelRatio,
      logicalHeight: size.height / pixelRatio,
      orientation: orientation,
      pixelRatio: pixelRatio,
      textScaleFactor: textScaleFactor,
      viewPadding: mediaQuery.viewPadding,
      viewInsets: mediaQuery.viewInsets,
      isAccessibilityEnabled: mediaQuery.accessibleNavigation,
      brightness: mediaQuery.platformBrightness,
      devicePixelRatio: mediaQuery.devicePixelRatio,
    );
  }

  /// Enhanced responsive value selector with comprehensive device support
  static T value<T>({
    required ResponsiveData data,
    T? mobile,
    T? mobileLarge,
    T? tablet,
    T? tabletLarge,
    T? desktop,
    T? desktopLarge,
    T? ultraWide,
    required T fallback,
  }) {
    switch (data.deviceType) {
      case DeviceType.mobile:
        return mobile ?? fallback;
      case DeviceType.mobileLarge:
        return mobileLarge ?? mobile ?? fallback;
      case DeviceType.tablet:
        return tablet ?? mobileLarge ?? mobile ?? fallback;
      case DeviceType.tabletLarge:
        return tabletLarge ?? tablet ?? mobileLarge ?? mobile ?? fallback;
      case DeviceType.desktop:
        return desktop ??
            tabletLarge ??
            tablet ??
            mobileLarge ??
            mobile ??
            fallback;
      case DeviceType.desktopLarge:
        return desktopLarge ??
            desktop ??
            tabletLarge ??
            tablet ??
            mobileLarge ??
            mobile ??
            fallback;
      case DeviceType.ultraWide:
        return ultraWide ??
            desktopLarge ??
            desktop ??
            tabletLarge ??
            tablet ??
            mobileLarge ??
            mobile ??
            fallback;
    }
  }

  /// Responsive value with enhanced screen size categories
  static T screenSizeValue<T>({
    required ResponsiveData data,
    T? compact,
    T? medium,
    T? expanded,
    T? large,
    required T fallback,
  }) {
    switch (data.screenSize) {
      case ScreenSize.compact:
        return compact ?? fallback;
      case ScreenSize.medium:
        return medium ?? compact ?? fallback;
      case ScreenSize.expanded:
        return expanded ?? medium ?? compact ?? fallback;
      case ScreenSize.large:
        return large ?? expanded ?? medium ?? compact ?? fallback;
    }
  }

  /// Fluid interpolation between breakpoints for smooth transitions
  static double fluidValue({
    required ResponsiveData data,
    required double mobile,
    required double tablet,
    required double desktop,
    double? ultraWide,
  }) {
    final width = data.width;
    final mobileBreak = ResponsiveConfig.mobileLarge;
    final tabletBreak = ResponsiveConfig.tablet;
    final desktopBreak = ResponsiveConfig.desktop;
    final ultraWideBreak = ResponsiveConfig.ultraWide;

    if (width <= mobileBreak) {
      // Mobile range with slight scaling for very small screens
      final ratio = (width / mobileBreak).clamp(0.8, 1.0);
      return mobile * ratio;
    } else if (width <= tabletBreak) {
      // Mobile to tablet interpolation
      final progress = (width - mobileBreak) / (tabletBreak - mobileBreak);
      return _lerp(mobile, tablet, progress);
    } else if (width <= desktopBreak) {
      // Tablet to desktop interpolation
      final progress = (width - tabletBreak) / (desktopBreak - tabletBreak);
      return _lerp(tablet, desktop, progress);
    } else if (ultraWide != null && width <= ultraWideBreak) {
      // Desktop to ultra-wide interpolation
      final progress = (width - desktopBreak) / (ultraWideBreak - desktopBreak);
      return _lerp(desktop, ultraWide, progress);
    } else {
      // Beyond ultra-wide with controlled scaling
      final extraScale = ultraWide != null
          ? ((width - ultraWideBreak) / 500.0).clamp(0.0, 0.2)
          : ((width - desktopBreak) / 400.0).clamp(0.0, 0.3);
      final baseValue = ultraWide ?? desktop;
      return baseValue * (1.0 + extraScale);
    }
  }

  /// Linear interpolation helper
  static double _lerp(double a, double b, double t) {
    return a + (b - a) * t.clamp(0.0, 1.0);
  }

  /// Expert responsive font size with proper scaling
  ///
  /// This method provides fluid font scaling without double scaling issues.
  /// It considers screen density and text accessibility settings.
  ///
  /// Use this for: Body text, descriptions, general content
  /// Use adaptiveFontSize() for: Titles, headings, UI elements
  /// Use simpleFontSize() for: Precise control over specific sizes
  static double responsiveFontSize({
    required ResponsiveData data,
    required double mobile,
    double? tablet,
    double? desktop,
    double? ultraWide,
    bool useFluidScaling = true,
    bool respectTextScale = true,
  }) {
    double baseFontSize;

    if (useFluidScaling) {
      baseFontSize = fluidValue(
        data: data,
        mobile: mobile,
        tablet: tablet ?? mobile * 1.1,
        desktop: desktop ?? mobile * 1.2,
        ultraWide: ultraWide ?? desktop ?? mobile * 1.25,
      );
    } else {
      baseFontSize = value<double>(
        data: data,
        mobile: mobile,
        tablet: tablet ?? mobile * 1.1,
        desktop: desktop ?? mobile * 1.2,
        ultraWide: ultraWide ?? desktop ?? mobile * 1.25,
        fallback: mobile,
      );
    }

    // Apply screen density scaling (not double scaling)
    final screenScale = _calculateScreenScale(data);
    final scaledSize = baseFontSize * screenScale;

    // Apply text scale factor if enabled and reasonable
    if (respectTextScale &&
        data.textScaleFactor > 0.8 &&
        data.textScaleFactor < 1.5) {
      return scaledSize * data.textScaleFactor;
    }

    return scaledSize;
  }

  /// Calculate appropriate screen scale factor
  static double _calculateScreenScale(ResponsiveData data) {
    // Base scale on screen width relative to a standard mobile width (375px)
    const standardWidth = 375.0;
    final widthRatio = data.width / standardWidth;

    // Clamp the scale to reasonable bounds
    return widthRatio.clamp(0.8, 2.0);
  }

  /// Simple responsive font size for precise control
  ///
  /// Provides exact font sizes per device type without any scaling.
  /// Best for: Icons, buttons, precise UI elements
  static double simpleFontSize({
    required ResponsiveData data,
    required double mobile,
    double? tablet,
    double? desktop,
    double? ultraWide,
  }) {
    return value<double>(
      data: data,
      mobile: mobile,
      tablet: tablet ?? mobile,
      desktop: desktop ?? mobile,
      ultraWide: ultraWide ?? mobile,
      fallback: mobile,
    );
  }

  /// Get font size based on screen category
  ///
  /// Provides consistent scaling across device types with multipliers.
  /// Best for: Titles, headings, navigation, consistent UI text
  ///
  /// Device multipliers:
  /// - Mobile: 0.9x
  /// - Mobile Large: 1.0x (base)
  /// - Tablet: 1.1x
  /// - Tablet Large: 1.15x
  /// - Desktop: 1.2x
  /// - Desktop Large: 1.25x
  /// - Ultra Wide: 1.3x
  static double adaptiveFontSize({
    required ResponsiveData data,
    required double baseSize,
    double scaleFactor = 1.0,
  }) {
    double multiplier;

    switch (data.deviceType) {
      case DeviceType.mobile:
        multiplier = 0.9;
        break;
      case DeviceType.mobileLarge:
        multiplier = 1.0;
        break;
      case DeviceType.tablet:
        multiplier = 1.1;
        break;
      case DeviceType.tabletLarge:
        multiplier = 1.15;
        break;
      case DeviceType.desktop:
        multiplier = 1.2;
        break;
      case DeviceType.desktopLarge:
        multiplier = 1.25;
        break;
      case DeviceType.ultraWide:
        multiplier = 1.3;
        break;
    }

    return baseSize * multiplier * scaleFactor;
  }

  static double adaptiveIconSize({
    required ResponsiveData data,
    required double baseSize,
    double scaleFactor = 1.0,
  }) {
    double multiplier;

    switch (data.deviceType) {
      case DeviceType.mobile:
        multiplier = 1.0;
        break;
      case DeviceType.mobileLarge:
        multiplier = 1.0;
        break;
      case DeviceType.tablet:
        multiplier = 1.1;
        break;
      case DeviceType.tabletLarge:
        multiplier = 1.15;
        break;
      case DeviceType.desktop:
        multiplier = 1.2;
        break;
      case DeviceType.desktopLarge:
        multiplier = 1.25;
        break;
      case DeviceType.ultraWide:
        multiplier = 1.3;
        break;
    }

    return baseSize * multiplier * scaleFactor;
  }

  /// ScreenUtil-integrated spacing with fluid scaling
  static double responsiveSpacing({
    required ResponsiveData data,
    required double mobile,
    double? tablet,
    double? desktop,
    double? ultraWide,
    bool useFluidScaling = true,
  }) {
    double baseSpacing;

    if (useFluidScaling) {
      baseSpacing = fluidValue(
        data: data,
        mobile: mobile,
        tablet: tablet ?? mobile * 1.4,
        desktop: desktop ?? mobile * 1.8,
        ultraWide: ultraWide ?? desktop ?? mobile * 2.0,
      );
    } else {
      baseSpacing = value<double>(
        data: data,
        mobile: mobile,
        tablet: tablet ?? mobile * 1.4,
        desktop: desktop ?? mobile * 1.8,
        ultraWide: ultraWide ?? desktop ?? mobile * 2.0,
        fallback: mobile,
      );
    }

    return baseSpacing.h;
  }

  /// ScreenUtil-integrated width with fluid scaling
  static double responsiveWidth({
    required ResponsiveData data,
    required double mobile,
    double? tablet,
    double? desktop,
    double? ultraWide,
    bool useFluidScaling = true,
  }) {
    double baseWidth;

    if (useFluidScaling) {
      baseWidth = fluidValue(
        data: data,
        mobile: mobile,
        tablet: tablet ?? mobile * 1.3,
        desktop: desktop ?? mobile * 1.6,
        ultraWide: ultraWide ?? desktop ?? mobile * 1.8,
      );
    } else {
      baseWidth = value<double>(
        data: data,
        mobile: mobile,
        tablet: tablet ?? mobile * 1.3,
        desktop: desktop ?? mobile * 1.6,
        ultraWide: ultraWide ?? desktop ?? mobile * 1.8,
        fallback: mobile,
      );
    }

    return baseWidth.w;
  }

  /// ScreenUtil-integrated height with fluid scaling
  static double responsiveHeight({
    required ResponsiveData data,
    required double mobile,
    double? tablet,
    double? desktop,
    double? ultraWide,
    bool useFluidScaling = true,
  }) {
    double baseHeight;

    if (useFluidScaling) {
      baseHeight = fluidValue(
        data: data,
        mobile: mobile,
        tablet: tablet ?? mobile * 1.3,
        desktop: desktop ?? mobile * 1.6,
        ultraWide: ultraWide ?? desktop ?? mobile * 1.8,
      );
    } else {
      baseHeight = value<double>(
        data: data,
        mobile: mobile,
        tablet: tablet ?? mobile * 1.3,
        desktop: desktop ?? mobile * 1.6,
        ultraWide: ultraWide ?? desktop ?? mobile * 1.8,
        fallback: mobile,
      );
    }

    return baseHeight.h;
  }

  /// ScreenUtil-integrated radius with fluid scaling
  static double responsiveRadius({
    required ResponsiveData data,
    required double mobile,
    double? tablet,
    double? desktop,
    double? ultraWide,
    bool useFluidScaling = true,
  }) {
    double baseRadius;

    if (useFluidScaling) {
      baseRadius = fluidValue(
        data: data,
        mobile: mobile,
        tablet: tablet ?? mobile * 1.25,
        desktop: desktop ?? mobile * 1.5,
        ultraWide: ultraWide ?? desktop ?? mobile * 1.7,
      );
    } else {
      baseRadius = value<double>(
        data: data,
        mobile: mobile,
        tablet: tablet ?? mobile * 1.25,
        desktop: desktop ?? mobile * 1.5,
        ultraWide: ultraWide ?? desktop ?? mobile * 1.7,
        fallback: mobile,
      );
    }

    return baseRadius.r;
  }

  /// Responsive icon size with fluid scaling
  static double responsiveIconSize({
    required ResponsiveData data,
    required double mobile,
    double? tablet,
    double? desktop,
    double? ultraWide,
    bool useFluidScaling = true,
  }) {
    double baseIconSize;

    if (useFluidScaling) {
      baseIconSize = fluidValue(
        data: data,
        mobile: mobile,
        tablet: tablet ?? mobile * 1.1,
        desktop: desktop ?? mobile * 1.2,
        ultraWide: ultraWide ?? desktop ?? mobile * 1.25,
      );
    } else {
      baseIconSize = value<double>(
        data: data,
        mobile: mobile,
        tablet: tablet ?? mobile * 1.1,
        desktop: desktop ?? mobile * 1.2,
        ultraWide: ultraWide ?? desktop ?? mobile * 1.25,
        fallback: mobile,
      );
    }

    return baseIconSize.w;
  }

  /// Get max content width for centered layouts
  static double maxContentWidth(ResponsiveData data) {
    return value<double>(
      data: data,
      mobile: 1.sw * 0.95,
      mobileLarge: 1.sw * 0.92,
      tablet: 1.sw * 0.85,
      tabletLarge: 1.sw * 0.8,
      desktop: math.min(800.w, 1.sw * 0.75),
      desktopLarge: math.min(1000.w, 1.sw * 0.7),
      ultraWide: math.min(1200.w, 1.sw * 0.65),
      fallback: 1.sw,
    );
  }

  /// Get responsive padding
  static EdgeInsets responsivePadding(ResponsiveData data) {
    final padding = fluidValue(
      data: data,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
      ultraWide: 40.0,
    );
    return EdgeInsets.all(padding.w);
  }

  /// Get responsive margin
  static EdgeInsets responsiveMargin(ResponsiveData data) {
    final margin = fluidValue(
      data: data,
      mobile: 8.0,
      tablet: 12.0,
      desktop: 16.0,
      ultraWide: 20.0,
    );
    return EdgeInsets.all(margin.w);
  }
}

/// Clean responsive widget for UI building
class ResponsiveWidget extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveData data) builder;

  const ResponsiveWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final data = ResponsiveHelper.getResponsiveData(context);
        return builder(context, data);
      },
    );
  }
}
