import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sol_replace_revamp/src/core/components/custom_inkwell.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/images.dart';
import 'package:sol_replace_revamp/src/core/globals/system_overlay.dart';
import 'package:sol_replace_revamp/src/core/globals/variables.dart';
import 'package:sol_replace_revamp/src/core/services/custom_navigation.dart';

/// A customizable app bar widget that provides consistent styling and behavior
/// across the application with enhanced features and performance optimizations.
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Optional bottom widget (typically used for tabs)
  final PreferredSizeWidget? bottom;

  /// Whether to center the title text
  final bool centerTitle;
  final bool isDarkOverlay;

  /// Custom back button callback
  final VoidCallback? onBack;

  /// List of action components to display on the right side
  final List<Widget> actions;

  /// Background color of the app bar
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? iconBgColor;

  /// Text color for the title
  final Color? titleColor;

  /// Custom text style for the title
  final TextStyle? titleStyle;

  /// Whether to hide the back button
  final bool hideBackButton;

  /// Custom back button color
  final Color? backButtonColor;

  /// Whether to show elevation shadow
  final bool showElevation;

  /// Custom elevation value
  final double? elevation;

  /// System UI overlay style for status bar
  final SystemUiOverlayStyle? systemOverlayStyle;

  final Widget? title;

  const CommonAppBar({
    super.key,
    this.title,
    this.isDarkOverlay = true,
    this.bottom,
    this.centerTitle = false,
    this.onBack,
    this.actions = const [],
    this.backgroundColor,
    this.titleColor,
    this.titleStyle,
    this.hideBackButton = false,
    this.backButtonColor,
    this.showElevation = false,
    this.elevation,
    this.systemOverlayStyle,
    this.iconColor = AppColors.primaryColor,
    this.iconBgColor = AppColors.blackColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      centerTitle: centerTitle,
      toolbarHeight: kToolbarHeight,
      backgroundColor: _getBackgroundColor(backgroundColor),
      elevation: showElevation ? (elevation ?? 2.0) : 0,
      shadowColor: showElevation ? Colors.black26 : Colors.transparent,
      systemOverlayStyle:
          systemOverlayStyle ??
          getSystemOverlayStyle(
            isDarkMode: isDarkOverlay,
            backgroundColor: backgroundColor,
          ),
      title: _buildTitle(),
      leading: _buildLeading(),
      leadingWidth: (hideBackButton ? 0 : 34.w) + hMargin,
      actions: _buildActions(),
      bottom: bottom,
    );
  }

  /// Determines the background color based on theme and provided color
  Color _getBackgroundColor(Color? backgroundColor) {
    if (backgroundColor != null) return backgroundColor;
    return AppColors.blackColor;
  }

  /// Builds the title widget with proper styling and tap handling
  Widget _buildTitle() {
    Widget titleWidget =
        title ?? SizedBox.shrink();

    return titleWidget;
  }

  /// Builds the leading widget (back button or custom widget) - FIXED HEIGHT CONSTRAINT
  Widget? _buildLeading() {
    if (hideBackButton) return SizedBox.shrink();
    return Center(
      child: CommonInkWell(
        onTap: _handleBackPress,
        child: Container(
          width: 40.w,
          height: 28.h,
          margin: EdgeInsetsDirectional.only(start: hMargin),

          alignment: Alignment.center,
          // Center the icon
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(35.r),
          ),
          child: Icon(Icons.arrow_back_sharp, color: iconColor, size: 16.sp),
        ),
      ),
    );
  }

  /// Builds the actions list with proper spacing
  List<Widget>? _buildActions() {
    if (actions.isEmpty) return null;

    return [
      ...actions.map(
        (action) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: action,
        ),
      ),
      SizedBox(width: 8.w), // Right margin
    ];
  }

  /// Handles back button press with custom or default behavior
  void _handleBackPress() {
    if (onBack != null) {
      onBack!();
    } else {
      CustomNavigation().pop();
    }
  }

  @override
  Size get preferredSize {
    final height = kToolbarHeight + (bottom?.preferredSize.height ?? 0);
    return Size.fromHeight(height);
  }
}
