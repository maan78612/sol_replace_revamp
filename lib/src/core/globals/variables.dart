import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sol_replace_revamp/src/core/utilities/responsive_helper.dart';

const int routingDuration = 300;
// double inputFieldHeight = 56;
double inputFieldHeight(ResponsiveData data) =>
    ResponsiveHelper.responsiveHeight(
      data: data,
      mobile: 56.0,
      tablet: 56.0,
      desktop: 50.0,
    );

double hMargin = 24.w;

final GlobalKey<NavigatorState> materialAppKey = GlobalKey<NavigatorState>();
