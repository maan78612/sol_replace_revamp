import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:sol_replace_revamp/src/core/components/custom_button.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';
import 'package:sol_replace_revamp/src/core/services/custom_navigation.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final String yesBtnText;
  final Color? yesBtnColor;
  final Color? yesBtnTextColor;
  final String noBtnText;
  final String icon;
  final Color? iconColor;
  final double? textFontSize;
  final String? deleteBtnText;
  final Function()? onDeletePressed;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.description,
    required this.yesBtnText,
    this.yesBtnColor,
    this.yesBtnTextColor,
    required this.noBtnText,
    required this.icon,
    this.textFontSize,
    this.iconColor,
    this.deleteBtnText,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: AppColors.blackColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _alertIcon(),
          24.verticalSpace,
          _title(),
          23.verticalSpace,
          _description(),
          49.verticalSpace,
          CustomButton(
            bgColor: yesBtnColor ?? AppColors.primaryColor,
            height: 44.h,
            fontSize: textFontSize,
            isLoading: false,
            isEnable: true,
            title: yesBtnText,
            textColor: yesBtnTextColor ?? AppColors.darkGreyColor,
            onPressed: () => CustomNavigation().pop(true),
          ),
          if (deleteBtnText != null) ...[
            15.verticalSpace,
            CustomButton(
              bgColor: AppColors.redColor,
              height: 44.h,
              fontSize: textFontSize,
              isLoading: false,
              isEnable: true,
              title: deleteBtnText!,
              textColor: AppColors.whiteColor,
              onPressed: (){
                onDeletePressed?.call();
              },
            ),
          ],
          15.verticalSpace,
          CustomButton(
            bgColor: AppColors.greyColor,
            height: 44.h,
            fontSize: textFontSize,

            isLoading: false,
            isEnable: true,
            title: noBtnText,
            textColor: AppColors.whiteColor,
            onPressed: () => CustomNavigation().pop(false),
          ),
        ],
      ),
    );
  }

  /// Alert Icon
  Widget _alertIcon() {
    return SizedBox(
      child: Center(
        child: SvgPicture.asset(
          icon,
          height: 56.h,
          colorFilter: iconColor != null
              ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
              : null,
        ),
      ),
    );
  }

  ///
  Widget _title() {
    return Text(
      title,
      style: FontStyles.montserratBold.copyWith(
        fontSize: 14.sp,
        color: AppColors.whiteColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  ///
  Widget _description() {
    return Text(
      description,
      textAlign: TextAlign.center,
      style: FontStyles.montserratRegular.copyWith(
        fontSize: 14.sp,
        height: 1.3,
      ),
    );
  }
}
