import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sol_replace_revamp/src/core/constants/colors.dart';

class FontStyles {
  /// Helper for any family/weight/style combo
  static TextStyle _of({
    required String family,
    required FontWeight weight,
    double? size,
    FontStyle style = FontStyle.normal,
  }) {
    return TextStyle(
      fontFamily: family,
      fontWeight: weight,
      fontStyle: style,
      fontSize: (size ?? _baseSize).sp,
      height: 1,
      color: AppColors.whiteColor,
    );
  }

  static const double _baseSize = 14.0;

  // ────────────────────────────
  // Montserrat (unchanged)
  // ────────────────────────────
  static TextStyle get montserratThin =>
      _of(family: 'Montserrat', weight: FontWeight.w100);

  static TextStyle get montserratThinItalic => _of(
    family: 'Montserrat',
    weight: FontWeight.w100,
    style: FontStyle.italic,
  );

  static TextStyle get montserratExtraLight =>
      _of(family: 'Montserrat', weight: FontWeight.w200);

  static TextStyle get montserratExtraLightItalic => _of(
    family: 'Montserrat',
    weight: FontWeight.w200,
    style: FontStyle.italic,
  );

  static TextStyle get montserratLight =>
      _of(family: 'Montserrat', weight: FontWeight.w300);

  static TextStyle get montserratLightItalic => _of(
    family: 'Montserrat',
    weight: FontWeight.w300,
    style: FontStyle.italic,
  );

  static TextStyle get montserratRegular =>
      _of(family: 'Montserrat', weight: FontWeight.w400);

  static TextStyle get montserratRegularItalic => _of(
    family: 'Montserrat',
    weight: FontWeight.w400,
    style: FontStyle.italic,
  );

  static TextStyle get montserratMedium =>
      _of(family: 'Montserrat', weight: FontWeight.w500);

  static TextStyle get montserratMediumItalic => _of(
    family: 'Montserrat',
    weight: FontWeight.w500,
    style: FontStyle.italic,
  );

  static TextStyle get montserratSemiBold =>
      _of(family: 'Montserrat', weight: FontWeight.w600);

  static TextStyle get montserratSemiBoldItalic => _of(
    family: 'Montserrat',
    weight: FontWeight.w600,
    style: FontStyle.italic,
  );

  static TextStyle get montserratBold =>
      _of(family: 'Montserrat', weight: FontWeight.w700);

  static TextStyle get montserratBoldItalic => _of(
    family: 'Montserrat',
    weight: FontWeight.w700,
    style: FontStyle.italic,
  );

  static TextStyle get montserratExtraBold =>
      _of(family: 'Montserrat', weight: FontWeight.w800);

  static TextStyle get montserratExtraBoldItalic => _of(
    family: 'Montserrat',
    weight: FontWeight.w800,
    style: FontStyle.italic,
  );

  static TextStyle get montserratBlack =>
      _of(family: 'Montserrat', weight: FontWeight.w900);

  static TextStyle get montserratBlackItalic => _of(
    family: 'Montserrat',
    weight: FontWeight.w900,
    style: FontStyle.italic,
  );
}
