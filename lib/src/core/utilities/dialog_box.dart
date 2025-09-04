import 'package:sol_replace_revamp/src/core/globals/variables.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogBoxUtils {
  static Future<bool?> show(Widget child, {bool isDismissible = false}) async {
    return await showDialog<bool>(
      context: materialAppKey.currentContext!,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: hMargin,
            vertical: 10.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          backgroundColor: AppColors.whiteColor,
          child: child,
        );
      },
    );
  }
}
