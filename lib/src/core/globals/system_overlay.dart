import 'package:flutter/services.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';

/// Determines the background color based on theme and provided color
Color _getBackgroundColor(Color? backgroundColor) {
  if (backgroundColor != null) return backgroundColor;
  return AppColors.blackColor;
}

/// Creates appropriate system overlay style for status bar
SystemUiOverlayStyle getSystemOverlayStyle({
  Color? backgroundColor,
  required bool isDarkMode,
}) {
  return SystemUiOverlayStyle(
    statusBarColor: AppColors.blackColor,
    statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
    statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
    systemNavigationBarColor: _getBackgroundColor(backgroundColor),
    systemNavigationBarIconBrightness: isDarkMode
        ? Brightness.light
        : Brightness.dark,
  );
}
