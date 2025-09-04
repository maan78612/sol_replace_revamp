import 'package:sol_replace_revamp/src/core/globals/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sol_replace_revamp/src/core/components/custom_inkwell.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';
import 'package:sol_replace_revamp/src/core/utilities/responsive_helper.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final bool isEnable;
  final Function() onPressed;
  final Widget? icon;
  final Color bgColor;
  final Color? disableBgColor;
  final Color textColor;
  final Color loadingColor;
  final bool isLoading;
  final double loadingSize;
  final Color? borderColor;
  final double? height;
  final double? fontSize;
  final double? width;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    this.title,
    required this.bgColor,
    this.disableBgColor,
    this.height,
    this.icon,
    this.fontSize,
    this.textStyle,
    this.isEnable = true,
    this.loadingColor = AppColors.blackColor,
    this.isLoading = false,
    this.loadingSize = 25.0,
    this.textColor = AppColors.blackColor,
    required this.onPressed,
    this.borderColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, data) {
        return CommonInkWell(
          onTap: isEnable ? onPressed : null,
          child: Container(
            width: width ?? _getResponsiveWidth(data),
            height: height ?? _getResponsiveHeight(data),
            alignment: Alignment.center,
            // Centers child both vertically and horizontally
            decoration: BoxDecoration(
              border: isEnable ? Border.all(color: borderColor ?? bgColor) : null,
              borderRadius: BorderRadius.circular(
                ResponsiveHelper.responsiveRadius(
                  data: data,
                  mobile: 35.0,
                  tablet: 38.0,
                  desktop: 40.0,
                ),
              ),
              color: (disableBgColor == null)
                  ? bgColor.withAlpha(isEnable ? 255 : 127)
                  : isEnable
                  ? bgColor
                  : disableBgColor,
            ),
            child: isLoading
                ? Container(
                    height: _getResponsiveLoadingSize(data),
                    width: _getResponsiveLoadingSize(data),
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                      vertical: ResponsiveHelper.responsiveSpacing(
                        data: data,
                        mobile: 6.0,
                        tablet: 7.0,
                        desktop: 8.0,
                      ),
                    ),
                    child: CircularProgressIndicator(
                      strokeWidth: ResponsiveHelper.value<double>(
                        data: data,
                        mobile: 3.0,
                        tablet: 3.5,
                        desktop: 4.0,
                        fallback: 3.0,
                      ),
                      valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    // Critical fix: Shrink row to content width
                    children: [
                      if (icon != null) icon!,
                      if (icon != null && title != null) 
                        SizedBox(
                          width: ResponsiveHelper.responsiveSpacing(
                            data: data,
                            mobile: 8.0,
                            tablet: 10.0,
                            desktop: 12.0,
                          ),
                        ),
                      if (title != null)
                        Text(
                          title!,
                          textAlign: TextAlign.center,
                          style: textStyle ??
                              FontStyles.montserratBold.copyWith(
                                color: textColor,
                                fontSize: fontSize ?? 
                                    ResponsiveHelper.adaptiveFontSize(
                                      data: data,
                                      baseSize: 14.0,
                                      scaleFactor: 1.0,
                                    ),
                                height: 1,
                              ),
                        ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  /// Get responsive width for button
  double _getResponsiveWidth(ResponsiveData data) {
    // Use similar constraints as CustomInputField for consistency
    return ResponsiveHelper.value<double>(
      data: data,
      mobile: data.width, // Full width on mobile
      mobileLarge: data.width * 0.95,
      tablet: 500.0, // Fixed max width for tablet
      tabletLarge: 550.0,
      desktop: 400.0, // Smaller max width for desktop
      desktopLarge: 450.0,
      ultraWide: 500.0, // Reasonable width for ultra-wide
      fallback: data.width,
    );
  }

  /// Get responsive height for button
  double _getResponsiveHeight(ResponsiveData data) {
    return ResponsiveHelper.responsiveHeight(
      data: data,
      mobile: inputFieldHeight,
      tablet: inputFieldHeight * 1.1,
      desktop: inputFieldHeight * 1.15,
    );
  }

  /// Get responsive loading indicator size
  double _getResponsiveLoadingSize(ResponsiveData data) {
    return ResponsiveHelper.value<double>(
      data: data,
      mobile: loadingSize,
      tablet: loadingSize * 1.1,
      desktop: loadingSize * 1.2,
      fallback: loadingSize,
    );
  }
}
