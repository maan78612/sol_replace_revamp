import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sol_replace_revamp/src/core/components/custom_inkwell.dart';
import 'package:sol_replace_revamp/src/core/components/custom_text_controller.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';
import 'package:sol_replace_revamp/src/core/utilities/responsive_helper.dart';

// ============================================================================
// MAIN INPUT FIELD WIDGET
// ============================================================================

class CustomInputField extends StatefulWidget {
  // Content parameters
  final String? hint;
  final String? title;
  final String? label;
  final String? titleIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;

  // Controller
  final CustomTextController controller;

  // Behavior parameters
  final TextInputType? keyboardType;
  final bool obscure;
  final bool expands;
  final bool enabled;
  final bool textAlignCenter;
  final int? maxLines;
  final bool autoFocus;
  final bool showCounterText;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;

  // Style parameters
  final Color fillColor;
  final Color? focusColor;
  final Color? titleColor;
  final double borderRadius;
  final double borderWidth;
  final bool isFilled;
  final bool isDecorationEnabled;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  // Dimension parameters
  final double titleFontSize;
  final double subTitleFontSize;
  final double titleIconSize;
  final double prefixMaxHeight;
  final double prefixMaxWidth;
  final EdgeInsets? contentPadding;
  final EdgeInsetsGeometry? titlePadding;
  final EdgeInsetsGeometry? errorPadding;

  // Callback parameters
  final VoidCallback? onTap;
  final ValueChanged<String>? onChange;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmit;

  // Accessibility parameters
  final String? semanticLabel;
  final String? semanticHint;
  final bool excludeSemantics;
  final String? restorationId;

  const CustomInputField({
    super.key,
    // Content
    this.hint,
    this.title,
    this.label,
    this.titleIcon,
    this.prefixWidget,
    this.suffixWidget,
    // Controller
    required this.controller,
    // Behavior
    this.keyboardType,
    this.obscure = false,
    this.expands = false,
    this.enabled = true,
    this.textAlignCenter = false,
    this.maxLines = 1,
    this.autoFocus = false,
    this.showCounterText = false,
    this.maxLength,
    this.inputFormatters,
    this.textInputAction = TextInputAction.done,
    // Style
    this.fillColor = Colors.transparent,
    this.focusColor,
    this.titleColor = AppColors.blackColor,
    this.borderRadius = 12,
    this.borderWidth = 1,
    this.isFilled = true,
    this.isDecorationEnabled = true,
    this.textStyle,
    this.hintStyle,
    // Dimensions
    this.titleFontSize = 16,
    this.subTitleFontSize = 12,
    this.titleIconSize = 24,
    this.prefixMaxHeight = 20,
    this.prefixMaxWidth = 60,
    this.contentPadding,
    this.titlePadding,
    this.errorPadding,
    // Callbacks
    this.onTap,
    this.onChange,
    this.onEditingComplete,
    this.onSubmit,
    // Accessibility
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.restorationId,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscure;
  }

  @override
  void didUpdateWidget(CustomInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscure != oldWidget.obscure) {
      setState(() => _obscureText = widget.obscure);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, data) => LayoutBuilder(
        builder: (context, constraints) => ValueListenableBuilder<bool>(
          valueListenable: widget.controller.hasFocusNotifier,
          builder: (context, hasFocus, _) {
            final fieldWidth =
                InputFieldDimensionsCalculator.calculateFieldWidth(
                  data,
                  constraints.maxWidth,
                );

            return ConstrainedBox(
              constraints: BoxConstraints(maxWidth: fieldWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_shouldShowTitle()) ...[
                    _buildTitleSection(data, fieldWidth),
                    _buildTitleSpacing(data),
                  ],
                  _buildTextField(hasFocus, data, fieldWidth),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Check if title section should be displayed
  bool _shouldShowTitle() {
    return widget.title != null || widget.titleIcon != null;
  }

  /// Build the title section with icon and error text
  Widget _buildTitleSection(ResponsiveData data, double availableWidth) {
    return Padding(
      padding: widget.titlePadding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.titleIcon != null) ...[
            _buildTitleIcon(data, availableWidth),
            _buildTitleIconSpacing(data),
          ],
          if (widget.title != null)
            Text(
              widget.title!,
              style: FontStyles.montserratBold.copyWith(
                fontSize: ResponsiveHelper.adaptiveFontSize(
                  data: data,
                  baseSize: widget.titleFontSize,
                  scaleFactor: 0.95,
                ),
                color: widget.titleColor,
              ),
            ),
          _buildTitleErrorSpacing(data),
          Expanded(child: _buildErrorText(data)),
        ],
      ),
    );
  }

  /// Build spacing between title icon and title text
  Widget _buildTitleIconSpacing(ResponsiveData data) {
    return SizedBox(
      width: ResponsiveHelper.responsiveSpacing(
        data: data,
        mobile: 8.0,
        tablet: 10.0,
        desktop: 12.0,
      ),
    );
  }

  /// Build spacing between title and error text
  Widget _buildTitleErrorSpacing(ResponsiveData data) {
    return SizedBox(
      width: ResponsiveHelper.responsiveSpacing(
        data: data,
        mobile: 16.0,
        tablet: 18.0,
        desktop: 20.0,
      ),
    );
  }

  /// Build spacing between title section and text field
  Widget _buildTitleSpacing(ResponsiveData data) {
    return SizedBox(
      height: ResponsiveHelper.responsiveSpacing(
        data: data,
        mobile: 10.0,
        tablet: 12.0,
        desktop: 14.0,
      ),
    );
  }

  /// Build error text widget
  Widget _buildErrorText(ResponsiveData data) {
    return Padding(
      padding: widget.errorPadding ?? EdgeInsets.zero,
      child: Text(
        widget.controller.error ?? "",
        maxLines: 2,
        textAlign: TextAlign.end,
        overflow: TextOverflow.ellipsis,
        style: FontStyles.montserratRegular.copyWith(
          fontSize: ResponsiveHelper.adaptiveFontSize(
            data: data,
            baseSize: 11.0,
            scaleFactor: 0.9,
          ),
          color: AppColors.redColor,
        ),
      ),
    );
  }

  /// Build the main text field widget
  Widget _buildTextField(
    bool hasFocus,
    ResponsiveData data,
    double availableWidth,
  ) {
    final fontSize = ResponsiveHelper.adaptiveFontSize(
      data: data,
      baseSize: 14.0,
      scaleFactor: 1.0,
    );

    final cursorHeight = ResponsiveHelper.responsiveSpacing(
      data: data,
      mobile: 18.0,
      tablet: 20.0,
      desktop: 22.0,
    );

    return TextFormField(
      // Basic configuration
      autofocus: widget.autoFocus,
      focusNode: widget.controller.focusNode,
      controller: widget.controller.controller,
      enabled: widget.enabled,
      restorationId: widget.restorationId,

      // Text configuration
      textAlign: widget.textAlignCenter ? TextAlign.center : TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      style:
          widget.textStyle ??
          FontStyles.montserratRegular.copyWith(
            fontSize: fontSize,
            color: AppColors.blackColor,
          ),

      // Input configuration
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      obscureText: _obscureText,
      obscuringCharacter: "•",

      // Length and expansion
      maxLength: widget.maxLength,
      maxLines: widget.expands ? null : widget.maxLines,
      minLines: widget.expands ? null : widget.maxLines,
      expands: widget.expands,

      // Visual configuration
      cursorColor: AppColors.primaryColor,
      cursorHeight: cursorHeight,

      // Callbacks
      onTap: widget.onTap,
      onChanged: widget.onChange,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onSubmit,

      // Decoration
      decoration: _buildInputDecoration(
        hasFocus,
        fontSize,
        data,
        availableWidth,
      ),
    );
  }

  /// Build the input decoration with borders, icons, and styling
  InputDecoration _buildInputDecoration(
    bool hasFocus,
    double fontSize,
    ResponsiveData data,
    double availableWidth,
  ) {
    final horizontalPadding = ResponsiveHelper.responsiveSpacing(
      data: data,
      mobile: 13.0,
      tablet: 15.0,
      desktop: 17.0,
    );

    final verticalPadding = ResponsiveHelper.responsiveSpacing(
      data: data,
      mobile: 12.0,
      tablet: 14.0,
      desktop: 16.0,
    );

    // Calculate icon constraints
    final prefixConstraints =
        InputFieldDimensionsCalculator.calculateIconConstraints(
          data,
          availableWidth,
          heightPercentage: 0.12,
          widthPercentage: 0.15,
          minHeight: 28.0,
          maxHeight: 50.0,
          minWidth: 36.0,
          maxWidth: 65.0,
        );

    final suffixConstraints =
        InputFieldDimensionsCalculator.calculateIconConstraints(
          data,
          availableWidth,
          heightPercentage: 0.12,
          widthPercentage: 0.15,
          minHeight: 28.0,
          maxHeight: 50.0,
          minWidth: 36.0,
          maxWidth: 65.0,
        );

    return InputDecoration(
      // Text and labels
      hintText: widget.hint,
      labelText: widget.label,
      labelStyle: TextStyle(
        color: hasFocus ? AppColors.primaryColor : AppColors.whiteColor,
      ),
      hintStyle:
          widget.hintStyle ??
          FontStyles.montserratRegular.copyWith(
            fontSize: fontSize,
            color: AppColors.greyColor,
          ),

      // Counter
      counterText: widget.showCounterText ? null : "",
      counterStyle: FontStyles.montserratRegular.copyWith(
        fontSize: fontSize,
        color: AppColors.primaryColor,
      ),

      // Padding and fill
      contentPadding:
          widget.contentPadding ??
          EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
      filled: widget.isFilled,
      fillColor: widget.fillColor,
      focusColor: widget.focusColor ?? AppColors.primaryColor,

      // Borders
      border: _getInputBorder(hasFocus, data),
      enabledBorder: _getInputBorder(hasFocus, data),
      errorBorder: _getInputBorder(hasFocus, data),
      focusedBorder: _getFocusedBorder(hasFocus, data),
      disabledBorder: _getInputBorder(hasFocus, data),

      // Icon constraints and widgets
      prefixIconConstraints: prefixConstraints,
      suffixIconConstraints: suffixConstraints,
      prefixIcon: _buildPrefixIcon(data),
      suffixIcon: _buildSuffixIcon(data, availableWidth),
    );
  }

  /// Get input border
  InputBorder _getInputBorder(bool hasFocus, ResponsiveData data) {
    if (!widget.isDecorationEnabled) return InputBorder.none;

    final borderRadius = ResponsiveHelper.responsiveRadius(
      data: data,
      mobile: widget.borderRadius,
      tablet: widget.borderRadius,
      desktop: widget.borderRadius,
    );

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: _getBorderColor(hasFocus),
        width: widget.borderWidth,
      ),
    );
  }

  /// Get focused border
  InputBorder _getFocusedBorder(bool hasFocus, ResponsiveData data) {
    return _getInputBorder(hasFocus, data).copyWith(
      borderSide: BorderSide(
        color: _getFocusBorderColor(hasFocus),
        width: widget.borderWidth,
      ),
    );
  }

  /// Get border color
  Color _getBorderColor(bool hasFocus) {
    if (!widget.isDecorationEnabled) return Colors.transparent;
    return widget.controller.error == null
        ? AppColors.darkGreyColor
        : AppColors.redColor;
  }

  /// Get focus border color
  Color _getFocusBorderColor(bool hasFocus) {
    if (!widget.isDecorationEnabled) return Colors.transparent;
    return widget.controller.error == null
        ? AppColors.primaryColor
        : AppColors.redColor;
  }

  /// Build prefix icon
  Widget? _buildPrefixIcon(ResponsiveData data) {
    if (widget.prefixWidget == null) return null;

    final rightPadding = ResponsiveHelper.responsiveSpacing(
      data: data,
      mobile: 8.0,
      tablet: 10.0,
      desktop: 12.0,
    );

    final leftPadding = ResponsiveHelper.responsiveSpacing(
      data: data,
      mobile: 16.0,
      tablet: 18.0,
      desktop: 20.0,
    );

    return Padding(
      padding: EdgeInsets.only(right: rightPadding, left: leftPadding),
      child: widget.prefixWidget,
    );
  }

  /// Build suffix icon
  Widget? _buildSuffixIcon(ResponsiveData data, double availableWidth) {
    final horizontalPadding = ResponsiveHelper.responsiveSpacing(
      data: data,
      mobile: 16.0,
      tablet: 18.0,
      desktop: 20.0,
    );

    final suffixPadding = ResponsiveHelper.responsiveSpacing(
      data: data,
      mobile: 6.0,
      tablet: 7.0,
      desktop: 8.0,
    );

    if (!widget.obscure && widget.suffixWidget != null) {
      // Base icon size on constraints.maxWidth for responsive suffix widgets
      final baseSize = availableWidth * 0.05; // 5% of constraints.maxWidth
      final suffixIconSize = ResponsiveHelper.value<double>(
        data: data,
        mobile: baseSize.clamp(16.0, 20.0),
        // Clamp between 16-20px
        tablet: baseSize.clamp(18.0, 22.0),
        // Clamp between 18-22px
        desktop: baseSize.clamp(20.0, 24.0),
        // Clamp between 20-24px
        ultraWide: baseSize.clamp(20.0, 26.0),
        // Clamp between 20-26px
        fallback: 18.0,
      );

      return Padding(
        padding: EdgeInsetsDirectional.only(
          end: horizontalPadding + suffixPadding,
        ),
        child: SizedBox(
          width: suffixIconSize,
          height: suffixIconSize,
          child: widget.suffixWidget,
        ),
      );
    }

    if (widget.obscure) {
      // Base icon size on constraints.maxWidth (container width) for better proportions
      final baseSize = availableWidth * 0.05; // 5% of constraints.maxWidth
      final eyeIconSize = ResponsiveHelper.value<double>(
        data: data,
        mobile: baseSize.clamp(16.0, 20.0),
        // Clamp between 16-20px
        tablet: baseSize.clamp(18.0, 22.0),
        // Clamp between 18-22px
        desktop: baseSize.clamp(20.0, 24.0),
        // Clamp between 20-24px
        ultraWide: baseSize.clamp(20.0, 26.0),
        // Clamp between 20-26px
        fallback: 18.0,
      );

      return CommonInkWell(
        onTap: _toggleObscureText,
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            end: horizontalPadding + suffixPadding,
          ),
          child: Icon(
            _obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: eyeIconSize,
            color: AppColors.primaryColor,
          ),
        ),
      );
    }

    return null;
  }

  /// Build title icon
  Widget _buildTitleIcon(ResponsiveData data, double availableWidth) {
    // Base icon size on constraints.maxWidth (container width) for better proportions
    final baseSize = availableWidth * 0.06; // 6% of constraints.maxWidth
    final size = ResponsiveHelper.value<double>(
      data: data,
      mobile: baseSize.clamp(18.0, 22.0),
      tablet: baseSize.clamp(20.0, 24.0),
      desktop: baseSize.clamp(22.0, 26.0),
      ultraWide: baseSize.clamp(24.0, 28.0),
      fallback: 20.0,
    );

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(size / 6),
        child: SvgPicture.asset(
          widget.titleIcon!,
          colorFilter: const ColorFilter.mode(
            AppColors.blackColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  /// Toggle password visibility
  void _toggleObscureText() {
    setState(() => _obscureText = !_obscureText);
  }
}

// ============================================================================
// RESPONSIVE DIMENSIONS CALCULATOR
// ============================================================================

/// Calculates responsive dimensions for input field components
class InputFieldDimensionsCalculator {
  const InputFieldDimensionsCalculator._();

  /// Calculate field width based on responsive constraints
  static double calculateFieldWidth(
    ResponsiveData data,
    double availableWidth,
  ) {
    // For tablet and desktop, use a percentage of the available container width
    return ResponsiveHelper.value<double>(
      data: data,
      mobile: availableWidth,
      mobileLarge: availableWidth * 0.8,
      tablet: availableWidth * 0.65,
      tabletLarge: availableWidth * 0.6,
      desktop: availableWidth * 0.7,
      desktopLarge: availableWidth * 0.65,
      ultraWide: availableWidth * 0.65,
      fallback: availableWidth,
    );
  }

  /// Calculate icon size based on available width
  static double calculateIconSize(
    ResponsiveData data,
    double availableWidth, {
    required double basePercentage,
    required double minSize,
    required double maxSize,
  }) {
    final baseSize = availableWidth * basePercentage;
    return ResponsiveHelper.value<double>(
      data: data,
      mobile: baseSize.clamp(minSize, maxSize),
      tablet: baseSize.clamp(minSize + 2, maxSize + 2),
      desktop: baseSize.clamp(minSize + 4, maxSize + 4),
      ultraWide: baseSize.clamp(minSize + 6, maxSize + 6),
      fallback: minSize,
    );
  }

  /// Calculate icon constraints for prefix/suffix
  static BoxConstraints calculateIconConstraints(
    ResponsiveData data,
    double availableWidth, {
    required double heightPercentage,
    required double widthPercentage,
    required double minHeight,
    required double maxHeight,
    required double minWidth,
    required double maxWidth,
  }) {
    final height = ResponsiveHelper.value<double>(
      data: data,
      mobile: (availableWidth * heightPercentage).clamp(minHeight, maxHeight),
      tablet: (availableWidth * (heightPercentage - 0.02)).clamp(
        minHeight + 4,
        maxHeight + 4,
      ),
      desktop: (availableWidth * (heightPercentage - 0.04)).clamp(
        minHeight + 8,
        maxHeight + 8,
      ),
      ultraWide: (availableWidth * (heightPercentage - 0.05)).clamp(
        minHeight + 8,
        maxHeight + 10,
      ),
      fallback: minHeight,
    );

    final width = ResponsiveHelper.value<double>(
      data: data,
      mobile: (availableWidth * widthPercentage).clamp(minWidth, maxWidth),
      tablet: (availableWidth * (widthPercentage - 0.03)).clamp(
        minWidth + 4,
        maxWidth + 5,
      ),
      desktop: (availableWidth * (widthPercentage - 0.05)).clamp(
        minWidth + 8,
        maxWidth + 10,
      ),
      ultraWide: (availableWidth * (widthPercentage - 0.07)).clamp(
        minWidth + 8,
        maxWidth + 15,
      ),
      fallback: minWidth,
    );

    return BoxConstraints(maxHeight: height, maxWidth: width);
  }
}
