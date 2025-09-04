import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';

class CommonSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;

  const CommonSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22.sp,
      width: 44.sp,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Switch(
          padding:EdgeInsets.zero,
          value: value,
          onChanged: onChanged,
          activeColor: activeColor ?? AppColors.primaryColor,
          inactiveThumbColor: inactiveThumbColor ?? AppColors.lightGreyColor,
          inactiveTrackColor: inactiveTrackColor ?? AppColors.darkGreyColor,
        ),
      ),
    );
  }
} 