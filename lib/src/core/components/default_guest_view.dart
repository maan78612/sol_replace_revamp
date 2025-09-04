import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sol_replace_revamp/src/core/components/custom_button.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';

class DefaultGuestView extends StatelessWidget {
  final String img;
  final double imgSize;
  final String text;

  const DefaultGuestView({
    super.key,
    required this.text,
    required this.img,
    required this.imgSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(img, width: imgSize.sp, height: imgSize.sp),
          24.verticalSpace,
          Text(
            text,
            style: FontStyles.montserratBold.copyWith(
              color: AppColors.whiteColor,
              fontSize: 18.sp,
            ),
            textAlign: TextAlign.center,
          ),
          24.verticalSpace,
          SizedBox(
            width: 140.w,
            height: 44.h,
            child: CustomButton(
              title: 'Sign in',
              bgColor: AppColors.primaryColor,

              onPressed: () {},
            ),
          ),
          kToolbarHeight.verticalSpace,
        ],
      ),
    );
  }
}
