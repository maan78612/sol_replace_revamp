import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextController {
  TextEditingController controller;
  FocusNode focusNode;
  String? _error;
  String? icon;
  ValueNotifier<bool> hasFocusNotifier;
  ValueNotifier<String?> errorNotifier;

  String? get error => _error;
  
  set error(String? value) {
    _error = value;
    errorNotifier.value = value;
  }

  CustomTextController({
    required this.controller,
    String? error,
    required this.focusNode,
  }) : _error = error,
       hasFocusNotifier = ValueNotifier(focusNode.hasFocus),
       errorNotifier = ValueNotifier(error) {
    focusNode.addListener(() {
      hasFocusNotifier.value = focusNode.hasFocus;
    });
  }
}
