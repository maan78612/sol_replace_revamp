import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sol_replace_revamp/src/core/components/custom_inkwell.dart';
import 'package:sol_replace_revamp/src/core/components/custom_text_controller.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';
import 'package:sol_replace_revamp/src/core/utilities/responsive_helper.dart';

class CustomInputField extends StatefulWidget {
  final String? hint;
  final String? title;
  final String? label;
  final Widget? prefixWidget;
  final CustomTextController controller;
  final TextInputType? keyboardType;
  final bool obscure;
  final bool expands;
  final bool enabled;
  final bool textAlignCenter;
  final int? maxLines;
  final Color fillColor;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChange;
  final VoidCallback? onEditingComplete;
  final bool isDecorationEnabled;
  final bool autoFocus;
  final Color? focusColor;
  final Color? titleColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final double borderRadius;
  final Widget? suffixWidget;
  final ValueChanged<String>? onSubmit;
  final int? maxLength;
  final EdgeInsets? contentPadding;
  final double borderWidth;
  final double titleIconSize;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool isFilled;
  final double titleFontSize;
  final double subTitleFontSize;
  final String? titleIcon;
  final EdgeInsetsGeometry? titlePadding;
  final EdgeInsetsGeometry? errorPadding;
  final double prefixMaxHeight;
  final double prefixMaxWidth;
  final bool showCounterText;

  const CustomInputField({
    super.key,
    this.hint,
    this.title,
    this.label,
    this.prefixWidget,
    this.prefixMaxHeight = 20,
    this.prefixMaxWidth = 60,
    required this.controller,
    this.keyboardType,
    this.obscure = false,
    this.expands = false,
    this.enabled = true,
    this.textAlignCenter = false,
    this.maxLines = 1,
    this.onTap,
    this.onChange,
    this.onEditingComplete,
    this.isDecorationEnabled = true,
    this.autoFocus = false,
    this.focusColor,
    this.titleColor = AppColors.blackColor,
    this.inputFormatters,
    this.textInputAction = TextInputAction.done,
    this.borderRadius = 80,
    this.suffixWidget,
    this.onSubmit,
    this.maxLength,
    this.contentPadding,
    this.borderWidth = 1,
    this.hintStyle,
    this.textStyle,
    this.isFilled = true,
    this.titleFontSize = 16,
    this.subTitleFontSize = 12,
    this.titleIcon,
    this.titlePadding,
    this.errorPadding,
    this.titleIconSize = 24,
    this.fillColor = AppColors.blackColor,
    this.showCounterText = false,
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
      builder: (context, data) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return ValueListenableBuilder<bool>(
              valueListenable: widget.controller.hasFocusNotifier,
              builder: (context, hasFocus, _) {
                final fieldWidth = _getMaxFieldWidth(data, constraints.maxWidth);
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: fieldWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.title != null || widget.titleIcon != null) ...[
                        _buildTitleSection(data, fieldWidth),
                        SizedBox(
                          height: ResponsiveHelper.responsiveSpacing(
                            data: data,
                            mobile: 10.0,
                            tablet: 12.0,
                            desktop: 14.0,
                          ),
                        ),
                      ],
                      _buildTextField(hasFocus, data, fieldWidth),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  /// Get maximum width for input fields based on available container space
  double _getMaxFieldWidth(ResponsiveData data, double availableWidth) {
    // For mobile screen OR mobile-sized container, use full available width
    if (data.isMobileRange || availableWidth <= ResponsiveConfig.mobileLarge) {
      return availableWidth;
    }

    // For tablet and desktop, use a percentage of the available container width
    // This ensures fields don't become too wide in flex containers
    return ResponsiveHelper.value<double>(
      data: data,
      mobile: availableWidth,
      mobileLarge: availableWidth * 0.95,
      tablet: availableWidth * 0.85,
      // Use 85% of container width
      tabletLarge: availableWidth * 0.75,
      // Use 80% of container width
      desktop: availableWidth * 0.7,
      // Use 75% of container width
      desktopLarge: availableWidth * 0.65,
      // Use 70% of container width
      ultraWide: availableWidth * 0.65,
      // Use 65% of container width
      fallback: availableWidth,
    );
  }

  Widget _buildTitleSection(ResponsiveData data, double availableWidth) {
    return Padding(
      padding: widget.titlePadding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.titleIcon != null) ...[
            _buildTitleIcon(data, availableWidth),
            SizedBox(
              width: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 8.0,
                tablet: 10.0,
                desktop: 12.0,
              ),
            ),
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
          SizedBox(
            width: ResponsiveHelper.responsiveSpacing(
              data: data,
              mobile: 16.0,
              tablet: 18.0,
              desktop: 20.0,
            ),
          ),
          Expanded(child: _buildErrorText(data)),
        ],
      ),
    );
  }

  Widget _buildTitleIcon(ResponsiveData data, double availableWidth) {
    // Base icon size on container width for better proportions
    final baseSize = availableWidth * 0.06; // 6% of container width
    final size = ResponsiveHelper.value<double>(
      data: data,
      mobile: baseSize.clamp(20.0, 24.0),
      // Clamp between 18-22px
      tablet: baseSize.clamp(22.0, 26.0),
      // Clamp between 20-24px
      desktop: baseSize.clamp(24.0, 28.0),
      // Clamp between 22-26px
      ultraWide: baseSize.clamp(26.0, 30.0),
      // Don't go bigger
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
        padding: EdgeInsets.all(size / 7),
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

    final verticalPadding = ResponsiveHelper.responsiveSpacing(
      data: data,
      mobile: 12.0,
      tablet: 14.0,
      desktop: 16.0,
    );

    return TextFormField(
      autofocus: widget.autoFocus,
      focusNode: widget.controller.focusNode,
      onFieldSubmitted: widget.onSubmit,
      maxLength: widget.maxLength,
      cursorColor: AppColors.primaryColor,
      expands: widget.expands,
      maxLines: widget.expands ? null : widget.maxLines,
      minLines: widget.expands ? null : widget.maxLines,
      onTap: widget.onTap,
      cursorHeight: cursorHeight,
      onChanged: widget.onChange,
      onEditingComplete: widget.onEditingComplete,
      enabled: widget.enabled,
      controller: widget.controller.controller,
      textAlign: widget.textAlignCenter ? TextAlign.center : TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      style: _buildTextStyle(fontSize, data),
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      obscureText: _obscureText,
      obscuringCharacter: "•",
      textInputAction: widget.textInputAction,
      decoration: _buildInputDecoration(
        hasFocus,
        fontSize,
        verticalPadding,
        data,
        availableWidth,
      ),
    );
  }

  TextStyle? _buildTextStyle(double fontSize, ResponsiveData data) {
    return widget.textStyle ??
        FontStyles.montserratRegular.copyWith(
          fontSize: fontSize,
          color: AppColors.whiteColor,
        );
  }

  InputDecoration _buildInputDecoration(
    bool hasFocus,
    double fontSize,
    double verticalPadding,
    ResponsiveData data,
    double availableWidth,
  ) {
    final horizontalPadding = ResponsiveHelper.responsiveSpacing(
      data: data,
      mobile: 13.0,
      tablet: 15.0,
      desktop: 17.0,
    );

    // Icon constraints based on available width to prevent overflow
    // Prefix icon dimensions (percentage of available width)
    final prefixMaxHeight = ResponsiveHelper.value<double>(
      data: data,
      mobile: (availableWidth * 0.12).clamp(28.0, 40.0),    // 12% of width, clamped
      tablet: (availableWidth * 0.10).clamp(32.0, 44.0),    // 10% of width, clamped
      desktop: (availableWidth * 0.08).clamp(36.0, 48.0),   // 8% of width, clamped
      ultraWide: (availableWidth * 0.07).clamp(36.0, 50.0), // 7% of width, clamped
      fallback: 36.0,
    );

    final prefixMaxWidth = ResponsiveHelper.value<double>(
      data: data,
      mobile: (availableWidth * 0.15).clamp(36.0, 50.0),    // 15% of width, clamped
      tablet: (availableWidth * 0.12).clamp(40.0, 55.0),    // 12% of width, clamped
      desktop: (availableWidth * 0.10).clamp(44.0, 60.0),   // 10% of width, clamped
      ultraWide: (availableWidth * 0.08).clamp(44.0, 65.0), // 8% of width, clamped
      fallback: 44.0,
    );

    // Suffix icon dimensions (percentage of available width)
    final suffixMaxHeight = ResponsiveHelper.value<double>(
      data: data,
      mobile: (availableWidth * 0.12).clamp(28.0, 40.0),    // 12% of width, clamped
      tablet: (availableWidth * 0.10).clamp(32.0, 44.0),    // 10% of width, clamped
      desktop: (availableWidth * 0.08).clamp(36.0, 48.0),   // 8% of width, clamped
      ultraWide: (availableWidth * 0.07).clamp(36.0, 50.0), // 7% of width, clamped
      fallback: 36.0,
    );

    final suffixMaxWidth = ResponsiveHelper.value<double>(
      data: data,
      mobile: (availableWidth * 0.15).clamp(36.0, 50.0),    // 15% of width, clamped
      tablet: (availableWidth * 0.12).clamp(40.0, 55.0),    // 12% of width, clamped
      desktop: (availableWidth * 0.10).clamp(44.0, 60.0),   // 10% of width, clamped
      ultraWide: (availableWidth * 0.08).clamp(44.0, 65.0), // 8% of width, clamped
      fallback: 44.0,
    );

    return InputDecoration(
      focusColor: widget.focusColor ?? AppColors.primaryColor,
      hintText: widget.hint,
      labelText: widget.label,
      labelStyle: TextStyle(
        color: hasFocus ? AppColors.primaryColor : AppColors.whiteColor,
      ),
      counterText: widget.showCounterText ? null : "",
      counterStyle: FontStyles.montserratRegular.copyWith(
        fontSize: fontSize,
        color: AppColors.primaryColor,
      ),
      hintStyle:
          widget.hintStyle ??
          FontStyles.montserratRegular.copyWith(
            fontSize: fontSize,
            color: AppColors.lightGreyColor,
          ),
      contentPadding:
          widget.contentPadding ??
          EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
      filled: widget.isFilled,
      fillColor: widget.fillColor,
      border: _getInputBorder(hasFocus, data),
      enabledBorder: _getInputBorder(hasFocus, data),
      errorBorder: _getInputBorder(hasFocus, data),
      focusedBorder: _getFocusedBorder(hasFocus, data),
      disabledBorder: _getInputBorder(hasFocus, data),
      prefixIconConstraints: BoxConstraints(
        maxHeight: prefixMaxHeight,
        maxWidth: prefixMaxWidth,
      ),
      suffixIconConstraints: BoxConstraints(
        maxHeight: suffixMaxHeight,
        maxWidth: suffixMaxWidth,
      ),
      prefixIcon: _buildPrefixIcon(data),
      suffixIcon: _buildSuffixIcon(data),
    );
  }

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

  InputBorder _getFocusedBorder(bool hasFocus, ResponsiveData data) {
    return _getInputBorder(hasFocus, data).copyWith(
      borderSide: BorderSide(
        color: _getFocusBorderColor(hasFocus),
        width: widget.borderWidth,
      ),
    );
  }

  Color _getBorderColor(bool hasFocus) {
    if (!widget.isDecorationEnabled) return Colors.transparent;
    return widget.controller.error == null
        ? AppColors.darkGreyColor
        : AppColors.redColor;
  }

  Color _getFocusBorderColor(bool hasFocus) {
    if (!widget.isDecorationEnabled) return Colors.transparent;
    return widget.controller.error == null
        ? AppColors.primaryColor
        : AppColors.redColor;
  }

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

  Widget? _buildSuffixIcon(ResponsiveData data) {
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
      return Padding(
        padding: EdgeInsetsDirectional.only(end: horizontalPadding),
        child: widget.suffixWidget,
      );
    }

    if (widget.obscure) {
      final eyeIconSize = ResponsiveHelper.responsiveIconSize(
        data: data,
        mobile: 18.0,
        // Smaller, more reasonable
        tablet: 20.0,
        desktop: 22.0,
        ultraWide: 22.0, // Don't go too big
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

  void _toggleObscureText() {
    setState(() => _obscureText = !_obscureText);
  }
}
