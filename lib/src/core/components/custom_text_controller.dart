import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextController {
  TextEditingController controller;
  FocusNode focusNode;
  String? error;
  String? icon;
  ValueNotifier<bool> hasFocusNotifier;

  CustomTextController({
    required this.controller,
    this.error,
    required this.focusNode,
  }) : hasFocusNotifier = ValueNotifier(focusNode.hasFocus) {
    focusNode.addListener(() {
      hasFocusNotifier.value = focusNode.hasFocus;
    });
  }
}
