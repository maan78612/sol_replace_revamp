import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetUtils {
  static Future<dynamic> show(
    Widget child,
    BuildContext context, {
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = true,
    Color backgroundColor = AppColors.darkGreyColor,
  }) async {
    return await showModalBottomSheet(
      isDismissible: isDismissible,
      context: context,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      backgroundColor: backgroundColor,
      builder: (BuildContext context) {
        return child;
      },
    );
  }
}
