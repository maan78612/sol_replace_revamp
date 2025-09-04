import 'package:flutter/material.dart';

class CommonInkWell extends InkWell {
  const CommonInkWell(
      {super.key,
      super.child,
      super.onTap,
      super.enableFeedback,
      super.borderRadius})
      : super(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
        );
}
