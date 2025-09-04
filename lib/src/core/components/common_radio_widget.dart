import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class CommonRadioWidget extends StatelessWidget {
  final Function() onTap;
  final bool value;
  const CommonRadioWidget({super.key, required this.onTap, required this.value});

  @override
  Widget build(BuildContext context) {
    final size = 24.sp;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: value ? AppColors.primaryColor : AppColors.blackColor,
          border: Border.all(color: AppColors.primaryColor, width: 2.0),
        ),
        child: value
            ? Center(
          child: Container(
            width: size / 2,
            height: size / 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blackColor,
            ),
          ),
        )
            : null,
      ),
    );
  }
}
