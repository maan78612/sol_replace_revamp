import 'package:sol_replace_revamp/src/core/globals/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sol_replace_revamp/src/core/components/custom_inkwell.dart';
import 'package:sol_replace_revamp/src/core/components/custom_input_field.dart';
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
        return LayoutBuilder(
          builder: (context, constraints) {
            final adaptiveWidth =
                width ?? _getMaxFieldWidth(data, constraints.maxWidth);

            return ConstrainedBox(
              constraints: BoxConstraints(maxWidth: adaptiveWidth),
              child: _buildButton(data, adaptiveWidth),
            );
          },
        );
      },
    );
  }

  Widget _buildButton(ResponsiveData data, double buttonWidth) {
    return CommonInkWell(
      onTap: isEnable ? onPressed : null,
      child: Container(
        width: buttonWidth,
        height: height ?? inputFieldHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: isEnable ? Border.all(color: borderColor ?? bgColor) : null,
          borderRadius: BorderRadius.circular(50.r),
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
                margin: EdgeInsets.symmetric(vertical: 4.h),
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
                  if (icon != null && title != null) 5.horizontalSpace,
                  if (title != null)
                    Text(
                      title!,
                      textAlign: TextAlign.center,
                      style:
                          textStyle ??
                          FontStyles.montserratSemiBold.copyWith(
                            color: textColor,
                            fontSize:
                                fontSize ??
                                ResponsiveHelper.adaptiveFontSize(
                                  data: data,
                                  baseSize: 14.0,
                                  scaleFactor: 0.8,
                                ),
                            height: 1,
                          ),
                    ),
                ],
              ),
      ),
    );
  }

  double _getMaxFieldWidth(ResponsiveData data, double availableWidth) {
    return ResponsiveHelper.value<double>(
      data: data,
      mobile: data.width * 0.5,
      mobileLarge: data.width * 0.5,
      tablet: data.width * 0.4,
      tabletLarge: data.width * 0.4,
      desktop: data.width * 0.2,
      desktopLarge: data.width * 0.2,
      ultraWide: data.width * 0.2,
      fallback: availableWidth,
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
