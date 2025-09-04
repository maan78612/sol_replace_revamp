import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/images.dart';

import '../constants/icons.dart';

class CommonFileImage extends StatefulWidget {
  final File? imageFile;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final String placeHolderImage;
  final double size;

  const CommonFileImage({
    super.key,
    required this.imageFile,
    required this.size,
    this.onEdit,
    this.onDelete,
    required this.placeHolderImage ,
  });

  @override
  State<CommonFileImage> createState() => _CommonFileImageState();
}

class _CommonFileImageState extends State<CommonFileImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.lightGreyColor,
          ),

          child: widget.imageFile != null
              ? _buildFileImage(widget.imageFile!)
              : _placeholder(),
        ),
        if (widget.onEdit != null)
          Positioned(
            bottom: 4,
            right: 4,
            child: _circleIconButton(
              icon: widget.imageFile == null
                  ? Icons.add
                  : Icons.edit,
              onTap: widget.onEdit!,
            ),
          ),
        if (widget.onDelete != null && widget.imageFile != null)
          Positioned(
            top: 4,
            right: 4,
            child: _circleIconButton(
              icon: Icons.delete_forever,
              onTap: widget.onDelete ?? () {},
            ),
          ),
      ],
    );
  }

  Widget _buildFileImage(File file) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2000.sp),
      child: Image.file(
        file,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return _placeholder();
        },
      ),
    );
  }

  Widget _placeholder() {
    return Center(
      child: Image.asset(
        widget.placeHolderImage,
        color: AppColors.primaryColor,
        width: widget.size / 2,
        height: widget.size / 2,
      ),
    );
  }

  Widget _circleIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        // padding: EdgeInsets.all(4.sp),
        child: Icon(icon, size: 30.sp),
      ),
    );
  }
}
