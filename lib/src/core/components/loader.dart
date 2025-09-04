import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomLoader extends StatefulWidget {
  final bool isLoading;
  final Widget child;
  final Widget? loader;
  final Color backgroundColor;

  const CustomLoader({
    super.key,
    required this.isLoading,
    required this.child,
    this.loader,
    this.backgroundColor = AppColors.darkGreyColor,
  });

  @override
  State<StatefulWidget> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // Alternate direction
    _animation = Tween<double>(
      begin: 1.0,
      end: 0.6,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: widget.isLoading,
      color: widget.backgroundColor,
      opacity: 0.55,
      progressIndicator: ScaleTransition(
        scale: _animation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 54.h,
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
            ),
            child:
                widget.loader ??
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitFadingCircle(
                      color: AppColors.blackColor,
                      size: 28.sp,
                    ),
                    8.horizontalSpace,
                    Text(
                      'Loading',
                      style: FontStyles.montserratRegular.copyWith(
                        color: AppColors.blackColor,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ),
      child: widget.child,
    );
  }
}
