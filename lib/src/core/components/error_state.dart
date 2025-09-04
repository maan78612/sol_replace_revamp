import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';

class ErrorState extends StatelessWidget {
  final String error;
  final String title;
  final Function() onRefresh;

  const ErrorState({
    super.key,
    required this.error,
    required this.title,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: AppColors.redColor, size: 48.sp),
          16.verticalSpace,
          Text(
            title,
            style: FontStyles.montserratSemiBold.copyWith(
              color: AppColors.whiteColor,
              fontSize: 18.sp,
            ),
          ),
          8.verticalSpace,
          Text(
            error,
            style: FontStyles.montserratRegular.copyWith(
              color: AppColors.lightGreyColor,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          24.verticalSpace,
          ElevatedButton(
            onPressed: onRefresh,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.blackColor,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Retry',
              style: FontStyles.montserratSemiBold.copyWith(
                fontSize: 14.sp,
                color: AppColors.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
