import 'package:flutter/material.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';
import 'package:sol_replace_revamp/src/core/constants/fonts.dart';
import 'package:sol_replace_revamp/src/core/constants/images.dart';

class NetworkImageWithLoader extends StatelessWidget {
  final String imageUrl;
  final double size;
  final String placeHolderImage;

  const NetworkImageWithLoader({
    super.key,
    required this.imageUrl,
    required this.size,
    required this.placeHolderImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.lightGreyColor,
      ),

      child: _buildProfileImage(imageUrl),
    );
  }

  Widget _buildProfileImage(String networkImage) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Image.network(
        networkImage,
        width: size,
        height: size,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          final progress =
              (loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1))
                  .clamp(0.1, 1.0);

          return Stack(
            alignment: Alignment.center,
            children: [
              child,
              SizedBox(
                width: size ,
                height: size ,
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  value: progress,
                  strokeWidth: 3,
                ),
              ),
              Center(
                child: Text(
                  "Loading!",
                  style: FontStyles.montserratBold.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: size / 10,
                  ),
                ),
              ),
            ],
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _placeholder();
        },
      ),
    );
  }

  Widget _placeholder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Center(
        child: Image.asset(
          placeHolderImage,
          color: AppColors.primaryColor,
          width: size / 2,
          height: size / 2,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
