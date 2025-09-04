import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';

class LoadingState extends StatelessWidget {
  final String title;

  const LoadingState({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFadingCircle(color: AppColors.primaryColor, size: 28.sp),
          16.verticalSpace,
          Text(
            title,
            style: FontStyles.montserratRegular.copyWith(
              color: AppColors.lightGreyColor,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
