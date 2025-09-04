import 'package:sol_replace_revamp/src/core/components/custom_button.dart';
import 'package:sol_replace_revamp/src/core/services/custom_navigation.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageBottomSheet extends StatelessWidget {
  final Function onImageSourceSelected;

  const SelectImageBottomSheet({
    super.key,
    required this.onImageSourceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            24.verticalSpace,
            Center(
              child: Text(
                'Select Image',
                style: FontStyles.montserratBold.copyWith(fontSize: 18.sp),
              ),
            ),
            24.verticalSpace,
            const Divider(color: AppColors.darkGreyColor),
            24.verticalSpace,
            Text(
              'Please select options below to proceed',
              textAlign: TextAlign.center,
              style: FontStyles.montserratRegular.copyWith(fontSize: 13.sp),
            ),
            30.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 37.h,
                      bgColor: AppColors.primaryColor,

                      textStyle: FontStyles.montserratRegular.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.blackColor,
                      ),
                      title: 'Gallery',
                      onPressed: () async {
                        CustomNavigation().pop();
                        onImageSourceSelected(ImageSource.gallery);
                      },
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: CustomButton(
                      height: 41.h,
                      bgColor: AppColors.blackColor,

                      title: 'Camera',
                      textStyle: FontStyles.montserratRegular.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 14.sp,
                      ),
                      borderColor: AppColors.primaryColor,
                      onPressed: () async {
                        CustomNavigation().pop();
                        onImageSourceSelected(ImageSource.camera);
                      },
                    ),
                  ),
                ],
              ),
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
