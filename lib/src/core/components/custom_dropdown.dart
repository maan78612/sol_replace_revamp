import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';
import 'package:sol_replace_revamp/src/core/constants/icons.dart';

class CustomDropdown<T> extends StatefulWidget {
  final T value;
  final List<T> options;
  final ValueChanged<T> onChanged;
  final String Function(T)? itemToString;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final double? borderRadius;
  final bool showIcon;
  final Duration? animationDuration;
  final double? maxDropdownHeight;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.itemToString,
    this.width,
    this.height,
    this.padding,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.borderRadius,
    this.showIcon = true,
    this.animationDuration,
    this.maxDropdownHeight,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  final GlobalKey _dropdownKey = GlobalKey();
  bool _isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _dropdownKey,
      onTap: () async {
        setState(() => _isDropdownOpen = true);
        final RenderBox renderBox =
            _dropdownKey.currentContext!.findRenderObject() as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero);
        final fieldWidth = renderBox.size.width;
        final fieldHeight = renderBox.size.height;

        final selected = await showMenu<T>(
          context: context,
          constraints: BoxConstraints(
            minWidth: fieldWidth,
            maxWidth: fieldWidth,
            maxHeight: widget.maxDropdownHeight ?? 0.5.sh,
          ),
          position: RelativeRect.fromLTRB(
            offset.dx,
            offset.dy + fieldHeight,
            offset.dx + fieldWidth,
            offset.dy,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(widget.borderRadius ?? 12.r),
              bottomRight: Radius.circular(widget.borderRadius ?? 12.r),
            ),
          ),
          color: widget.backgroundColor ?? AppColors.blackColor,
          items: widget.options.map((option) {
            return PopupMenuItem<T>(
              value: option,
              height: widget.height ?? 40.h,
              child: Text(
                _getItemString(option),
                style: FontStyles.montserratRegular.copyWith(
                  color: widget.textColor ?? AppColors.whiteColor,
                  fontSize: 14.sp,
                ),
              ),
            );
          }).toList(),
        );
        setState(() => _isDropdownOpen = false);
        if (selected != null) {
          widget.onChanged(selected);
        }
      },
      child: AnimatedContainer(
        duration:
            widget.animationDuration ??
            Duration(milliseconds: _isDropdownOpen ? 0 : 400),
        curve: Curves.easeInOut,
        width: widget.width,
        height: widget.height,
        padding:
            widget.padding ??
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.blackColor,
          borderRadius: _isDropdownOpen
              ? BorderRadius.only(
                  topRight: Radius.circular(widget.borderRadius ?? 12.r),
                  topLeft: Radius.circular(widget.borderRadius ?? 12.r),
                )
              : BorderRadius.circular(widget.borderRadius ?? 12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _getItemString(widget.value),
                style: FontStyles.montserratRegular.copyWith(
                  color: widget.textColor ?? AppColors.whiteColor,
                  fontSize: 14.sp,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (widget.showIcon) ...[
              8.horizontalSpace,
              AnimatedRotation(
                duration:
                    widget.animationDuration ??
                    const Duration(milliseconds: 200),
                turns: _isDropdownOpen ? 0 : 0.5,
                child: Icon(Icons.keyboard_arrow_up),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getItemString(T item) {
    if (widget.itemToString != null) {
      return widget.itemToString!(item);
    }
    return item.toString();
  }
}
